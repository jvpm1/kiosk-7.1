<?php
require_once '../../dbc.php';
require_once '../../Product.php';

$prod = new Product();

header('Content-Type: application/json');

// TODO: Remove upon release? //
header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Max-Age: 86400');
// END //

$response = [
    "message"  => "No POST data was found",
    "callback" => "[]",
];

$data = json_decode(file_get_contents('php://input'), true);

if ($data) {
    $response["message"] = "OK";

    $pickupNumber         = $prod->order($data);
    $response["callback"] = json_encode([
        "pickup_number" => $pickupNumber,
    ]);

    echo json_encode($response);
    exit;
}

http_response_code(404);
echo json_encode($response);
exit;
