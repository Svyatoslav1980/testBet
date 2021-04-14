<?php
session_start();
if ($_SESSION['rights']=='u')
{
echo "hello, ".$_SESSION['login']."!";

require_once ("testBetDB.php");

$matches_query = "SELECT * FROM matches WHERE match_result IS NULL";
$send_query = mysqli_query($link, $matches_query);

$users_query = "SELECT * FROM users WHERE id = ".$_SESSION['id'];
$send_users_query = mysqli_query($link, $users_query);
$user = mysqli_fetch_array($send_users_query);

$bets_query = "SELECT B.bet_id, B.matchId, B.bet_result, B.amount, B.is_paid, M.id, M.date, M.team1, M.team2, M.team1_win_rate, M.team2_win_rate, M.draw, M.match_result, U.sum_eur FROM bets AS B INNER JOIN matches AS M ON B.matchId = M.id AND M.match_result IS NOT NULL AND B.userId = ".$_SESSION['id']." AND B.is_paid = 0 INNER JOIN users AS U ON B.userId = U.id";
$send_bets_query = mysqli_query($link, $bets_query);
while ($bet = mysqli_fetch_array($send_bets_query)){
    if($bet['bet_result'] == $bet['match_result']){
        if($bet['bet_result'] == 'w1'){
            $gain = $bet['amount'] * $bet['team1_win_rate'];
            $balance = $bet['sum_eur'] + $gain;
            $update_balance = "UPDATE users SET sum_eur = '$balance' WHERE id = ".$_SESSION['id'];
            $update_balance_result =  mysqli_query ($link, $update_balance);

            $is_paid = true;
            $update_bet = "UPDATE bets SET is_paid = ".$is_paid." WHERE bet_id = ".$bet['bet_id'];
            $update_bet_result =  mysqli_query ($link, $update_bet);
        }elseif ($bet['bet_result'] == 'w2') {
            $gain = $bet['amount'] * $bet['team2_win_rate'];
            $balance = $bet['sum_eur'] + $gain;
            $update_balance = "UPDATE users SET sum_eur = '$balance' WHERE id = ".$_SESSION['id'];
            $update_balance_result =  mysqli_query ($link, $update_balance);

            $is_paid = true;
            $update_bet = "UPDATE bets SET is_paid = ".$is_paid." WHERE bet_id = ".$bet['bet_id'];
            $update_bet_result =  mysqli_query ($link, $update_bet);
        }else{
            $gain = $bet['amount'] * $bet['draw'];
            $balance = $bet['sum_eur'] + $gain;
            $update_balance = "UPDATE users SET sum_eur = '$balance' WHERE id = ".$_SESSION['id'];
            $update_balance_result =  mysqli_query ($link, $update_balance);

            $is_paid = true;
            $update_bet = "UPDATE bets SET is_paid = ".$is_paid." WHERE bet_id = ".$bet['bet_id'];
            $update_bet_result =  mysqli_query ($link, $update_bet);
        }
    }
}

?>
<h2>Your balance: <?php echo $user['sum_eur'];?> EUR</h2>
<h1>Place your bet:</h1>
<form name = "place_bet" action="place_bet.php"
enctype="multipart/form-data" method="post">
<label for="select_match">Select the match </label><select name="select_match" >
   <?php while ($match = mysqli_fetch_array($send_query))
{echo '<option value="'.$match['id'].'">'.$match['team1'].' - '.$match['team2'].'</option>';} ?>
</select></br></br>
<label for="select_currency">Select the currency </label><select name="select_currency" >
    <option selected value="EUR">EUR</option>
    <option value="USD">USD</option>
    <option value="RUR">RUR</option>
</select></br></br>
<label for="amount">Amount </label><input type="number" name="amount" required/></br><br>
<input type="submit" name="submit" value="PLACE THE BET" />
</form>
<p><a href = "logout.php">Logout</a></p>
<?php
}
else
{
echo "Please login to the site!";
echo "<a href = \"login.html\">Login</a>";
}
?>