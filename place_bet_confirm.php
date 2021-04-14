<?php 
require_once ("testBetDB.php");
session_start();
$users_query = "SELECT * FROM users WHERE id = ".$_SESSION['id'];
$send_users_query = mysqli_query($link, $users_query);
$user = mysqli_fetch_array($send_users_query);

$rate_query = "SELECT * FROM exchange_rates WHERE rate_name LIKE '".$_POST['select_currency_confirm']."'";
$send_rate_query = mysqli_query($link, $rate_query);
$rate = mysqli_fetch_array($send_rate_query);

if($_POST['select_currency_confirm'] == "EUR"){
    $amount = $_POST['amount_confirm'];
}else {
    $amount = $_POST['amount_confirm'] / $rate['rate'];
    $amount = round($amount, 2);
}

if($amount <= $user['sum_eur']){
    $balance = $user['sum_eur'] - $amount;
    $update_balance = "UPDATE users SET sum_eur = '$balance' WHERE id = ".$_SESSION['id'];
$update_balance_result =  mysqli_query ($link, $update_balance);

$id = $_SESSION['id'];
$match_id = $_POST['select_match_confirm'];
$match_result = $_POST['result'];
$create_bet = "INSERT INTO bets (bet_id, userId, matchId, bet_result, amount, is_paid)
VALUES (NULL, '$id', '$match_id', '$match_result', '$amount', 0)";
$create_bet_result =  mysqli_query ($link, $create_bet);

echo "Success!".'<br>';
echo "<a href = \"index.php\">Back</a>";
}else {
    echo 'You have little money, buddy!'.'<br>';
    echo "<a href = \"index.php\">Back</a>";
}

?>