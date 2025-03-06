<?php

class Product
{
    public function order($dataObject)
    {
        global $con;

        $price = $dataObject["price"];

        $pickupQuery      = "SELECT COALESCE(MAX(pickup_number), 0) + 1 AS nextPickup FROM orders";
        $result           = $con->query($pickupQuery);
        $row              = $result->fetch_assoc();
        $nextPickupNumber = $row['nextPickup'];

        $insertQuery = "INSERT INTO `orders` (order_status_id, pickup_number, price, datetime)
          VALUES (?, ?, ?, NOW())";
        $prepare  = $con->prepare($insertQuery);
        $statusId = 1;
        $prepare->bind_param("iid", $statusId, $nextPickupNumber, $price);
        $prepare->execute();

        $newOrderId = $con->insert_id;

        foreach ($dataObject["products"] as $product) {
            $productId = $product["id"];
            $amount    = $product["amount"];

            $productQuery = "SELECT price FROM products WHERE product_id = ?";
            $stmt         = $con->prepare($productQuery);
            $stmt->bind_param("i", $productId);
            $stmt->execute();
            $result       = $stmt->get_result();
            $productData  = $result->fetch_assoc();
            $productPrice = $productData['price'] * $amount;

            $query4 = "INSERT INTO order_product (order_id, product_id, price) VALUES (?, ?, ?)";
            $stmt   = $con->prepare($query4);
            $stmt->bind_param("iid", $newOrderId, $productId, $productPrice);
            $stmt->execute();
        }

        $con->close();
    }
}
