<?php
require_once '../dbc.php';
header('Content-Type: application/json');

$output = [];

$query = "
SELECT
    p.product_id,
    p.name,
    p.description,
    p.price,
    p.kcal,
    p.available,
    c.name AS category_name,
    c.description AS category_description,
    i.filename AS image_name,
    i.description AS image_description
FROM
    products p
LEFT JOIN
    categories c ON p.category_id = c.category_id
LEFT JOIN
    images i ON p.image_id = i.image_id
ORDER BY
    p.product_id
";

$prepare = $con->prepare($query);
$prepare->bind_result(
    $product_id,
    $name,
    $description,
    $price,
    $kcal,
    $available,
    $category_name,
    $category_description,
    $image_filename,
    $image_description
);
$prepare->execute();

while ($prepare->fetch()) {
    $output[] = [
        'id'          => $product_id,
        'name'        => $name,
        'description' => $description,
        'price'       => $price,
        'calories'    => $kcal,
        'available'   => $available,
        'category'    => [
            'name'        => $category_name,
            'description' => $category_description,
        ],
        'image'       => [
            'filename'    => $image_filename,
            'description' => $image_description,
        ],
    ];
}

$con->close();

echo json_encode($output);
