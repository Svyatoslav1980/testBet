<?php 
require_once ("testBetDB.php");

$bet_query = "SELECT * FROM matches WHERE id = ".$_POST['select_match'];
$send_bet_query = mysqli_query($link, $bet_query);
$match = mysqli_fetch_array($send_bet_query);
?>

<h1>Confirm your bet:</h1>
<form name = "place_bet" action="place_bet_confirm.php"
enctype="multipart/form-data" method="post">
<p><label for="result"> <?php echo $match['team1'].' winner. Сoefficient: '.$match['team1_win_rate'].'. Expected return: '.$_POST['amount']*$match['team1_win_rate'].' '.$_POST['select_currency'];?></label><input type="radio" name="result" value="w1" checked/></p>
<p><label for="result"> <?php echo $match['team2'].' winner. Сoefficient: '.$match['team2_win_rate'].'. Expected return: '.$_POST['amount']*$match['team2_win_rate'].' '.$_POST['select_currency'];?> </label><input type="radio" name="result" value="w2"/></p>
<p><label for="result"> <?php echo 'Draw. Сoefficient: '.$match['draw'].'. Expected return: '.$_POST['amount']*$match['draw'].' '.$_POST['select_currency'];?></label><input type="radio" name="result" value="d"/></p>
<input type="number" name="amount_confirm" value="<?php echo $_POST['amount']; ?>" required hidden/>
<input type="text" name="select_currency_confirm" value="<?php echo $_POST['select_currency']; ?>" required hidden/>
<input type="number" name="select_match_confirm" value="<?php echo $_POST['select_match']; ?>" required hidden/>
<input type="submit" name="submit" value="PLACE THE BET" />
</form>
