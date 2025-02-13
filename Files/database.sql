-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 12, 2025 at 11:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kiosk`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `description`) VALUES
(1, 'Breakfast', 'Start your day right with our nutritious breakfast options'),
(2, 'Lunch & Dinner', 'Healthy and satisfying meals for any time of day'),
(3, 'Sides', 'Perfect accompaniments to complement your meal'),
(4, 'Snacks', 'Nutritious bites for between meals'),
(5, 'Drinks', 'Refreshing beverages to keep you hydrated'),
(6, 'Dips', 'Flavorful additions to enhance your meal');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image_id`, `filename`, `description`) VALUES
(1, 'DALLE_2025-01-22_15.59.38_-_A_sleek_and_modern_logo_design_for_a_brand_emphasizing_speed_health_and_convenience._The_logo_features_vibrant_green_and_orange_color_palette_to_sym.jpg', 'Morning Boost Smoothie Bowl Logo'),
(2, 'DALLE_2025-01-22_15.59.50_-_A_photorealistic_depiction_of_a_breakfast_wrap_named_Eggcellent_Wrap._It_features_a_whole-grain_wrap_cut_open_to_reveal_fluffy_scrambled_eggs_fresh.jpg', 'Eggcellent Wrap'),
(3, 'DALLE_2025-01-22_15.59.53_-_A_photorealistic_depiction_of_a_breakfast_item_named_Peanut_Butter_Power_Toast._It_features_a_slice_of_whole-grain_toast_topped_with_creamy_natural_.jpg', 'Peanut Butter Power Toast'),
(4, 'DALLE_2025-01-22_15.59.55_-_A_photorealistic_depiction_of_a_healthy_meal_called_Protein-Packed_Bowl._It_features_a_bowl_filled_with_fluffy_quinoa_grilled_chicken_or_tofu_colo.jpg', 'Protein-Packed Bowl'),
(5, 'DALLE_2025-01-22_15.59.58_-_A_photorealistic_depiction_of_a_salad_called_Supergreen_Salad._It_features_a_vibrant_mix_of_kale_spinach_avocado_slices_edamame_cucumber_and_a_.jpg', 'Supergreen Salad'),
(6, 'DALLE_2025-01-22_16.00.00_-_A_photorealistic_depiction_of_a_wrap_called_Zesty_Chickpea_Wrap._The_wrap_is_made_with_a_whole-grain_tortilla_filled_with_spiced_chickpeas_shredde.jpg', 'Zesty Chickpea Wrap'),
(7, 'DALLE_2025-01-22_16.00.03_-_A_photorealistic_depiction_of_a_side_dish_called_Sweet_Potato_Wedges._The_image_shows_golden-orange_sweet_potato_wedges_seasoned_with_paprika_and_li.jpg', 'Sweet Potato Wedges'),
(8, 'DALLE_2025-01-22_16.00.05_-_A_photorealistic_depiction_of_a_small_salad_side_dish_called_Quinoa_Salad_Cup._The_dish_features_fluffy_quinoa_mixed_with_diced_cucumber_cherry_tom.jpg', 'Quinoa Salad Cup'),
(9, 'DALLE_2025-01-22_16.00.07_-_A_photorealistic_depiction_of_a_side_dish_called_Mini_Veggie_Platter._The_platter_includes_fresh_carrot_sticks_celery_cucumber_slices_and_cherry_.jpg', 'Mini Veggie Platter'),
(10, 'DALLE_2025-01-22_16.00.11_-_A_photorealistic_depiction_of_a_side_dish_called_Brown_Rice__Edamame_Bowl._The_bowl_features_a_base_of_fluffy_brown_rice_topped_with_vibrant_green_.jpg', 'Brown Rice & Edamame Bowl'),
(11, 'DALLE_2025-01-22_16.00.13_-_A_photorealistic_depiction_of_a_snack_called_Roasted_Chickpeas._The_dish_features_a_small_bowl_of_golden-brown_roasted_chickpeas_seasoned_with_papr.jpg', 'Roasted Chickpeas'),
(12, 'DALLE_2025-01-22_16.00.14_-_A_photorealistic_depiction_of_a_snack_called_Trail_Mix_Cup._The_dish_features_a_small_cup_filled_with_a_mix_of_nuts_dried_fruits_and_seeds_arrang.jpg', 'Trail Mix Cup'),
(13, 'DALLE_2025-01-22_16.00.16_-_A_photorealistic_depiction_of_a_dessert_snack_called_Chia_Pudding_Cup._The_dish_features_a_small_clear_cup_filled_with_creamy_chia_pudding_made_with.jpg', 'Chia Pudding Cup'),
(14, 'DALLE_2025-01-22_16.00.19_-_A_photorealistic_depiction_of_a_snack_called_Baked_Falafel_Bites._The_dish_features_four_golden-brown_falafel_balls_served_on_a_small_white_plate_wi.jpg', 'Baked Falafel Bites'),
(15, 'DALLE_2025-01-22_16.00.21_-_A_photorealistic_depiction_of_a_snack_called_Mini_Whole-Grain_Breadsticks._The_dish_features_several_crisp_golden-brown_whole-grain_breadsticks_nea.jpg', 'Mini Whole-Grain Breadsticks'),
(16, 'DALLE_2025-01-22_16.00.23_-_A_photorealistic_depiction_of_a_snack_called_Apple__Cinnamon_Chips._The_drink_is_served_in_a_clear_glass_with_fresh_slices_of_lemon_strawberries_and.jpg', 'Apple & Cinnamon Chips'),
(17, 'DALLE_2025-01-22_16.00.31_-_A_photorealistic_depiction_of_a_snack_called_Zucchini_Fries._The_dish_features_crispy_golden-brown_zucchini_fries_with_a_light_breadcrumb_coating_.jpg', 'Zucchini Fries'),
(18, 'DALLE_2025-01-22_16.00.35_-_A_photorealistic_depiction_of_a_smoothie_called_Green_Glow_Smoothie._The_drink_is_served_in_a_clear_glass_showcasing_its_vibrant_green_color_made_.jpg', 'Green Glow Smoothie'),
(19, 'DALLE_2025-01-22_16.00.37_-_A_photorealistic_depiction_of_a_drink_called_Iced_Matcha_Latte._The_drink_is_served_in_a_clear_glass_with_a_gradient_green_color_made_from_lightly_.jpg', 'Iced Matcha Latte'),
(20, 'DALLE_2025-01-22_16.00.39_-_A_photorealistic_depiction_of_a_drink_called_Fruit-Infused_Water._The_drink_is_served_in_a_clear_glass_with_fresh_slices_of_lemon_strawberries_and.jpg', 'Fruit-Infused Water'),
(21, 'DALLE_2025-01-22_16.00.42_-_A_photorealistic_depiction_of_a_smoothie_called_Berry_Blast_Smoothie._The_drink_is_served_in_a_clear_glass_with_a_rich_pink-purple_hue_made_from_st.jpg', 'Berry Blast Smoothie'),
(22, 'DALLE_2025-01-22_16.00.43_-_A_photorealistic_depiction_of_a_refreshing_drink_called_Citrus_Cooler._The_drink_is_served_in_a_clear_glass_featuring_a_vibrant_orange_hue_from_ora.jpg', 'Citrus Cooler');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_status_id` int(11) NOT NULL,
  `pickup_number` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_product`
--

CREATE TABLE `order_product` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `order_status_id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `kcal` int(11) DEFAULT NULL,
  `available` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `image_id`, `name`, `description`, `price`, `kcal`, `available`) VALUES
(1, 1, 1, 'Morning Boost Smoothie Bowl', 'A blend of acai, banana, and mixed berries topped with granola, chia seeds, and coconut flakes', 4.50, 300, 1),
(2, 1, 2, 'Eggcellent Wrap', 'Whole-grain wrap filled with scrambled eggs, spinach, and a light yogurt-based sauce', 3.50, 250, 1),
(3, 1, 3, 'Peanut Butter Power Toast', 'Whole-grain toast with natural peanut butter and banana slices', 2.80, 220, 1),
(4, 2, 4, 'Protein-Packed Bowl', 'Quinoa, grilled tofu, roasted vegetables, and a tahini dressing', 6.00, 450, 1),
(5, 2, 5, 'Supergreen Salad', 'Kale, spinach, avocado, edamame, cucumber, and a lemon-olive oil vinaigrette', 5.00, 300, 1),
(6, 2, 6, 'Zesty Chickpea Wrap', 'Whole-grain wrap with spiced chickpeas, shredded carrots, lettuce, and hummus', 4.50, 400, 1),
(7, 3, 7, 'Sweet Potato Wedges', 'Oven-baked sweet potato wedges seasoned with paprika and a touch of olive oil', 3.50, 250, 1),
(8, 3, 8, 'Quinoa Salad Cup', 'Mini cup of quinoa mixed with cucumber, cherry tomatoes, parsley, and lemon dressing', 3.00, 200, 1),
(9, 3, 9, 'Mini Veggie Platter', 'A selection of carrot sticks, celery, cucumber slices, and cherry tomatoes served with a dip of your choice', 3.00, 150, 1),
(10, 3, 10, 'Brown Rice & Edamame Bowl', 'A small portion of brown rice topped with steamed edamame and a drizzle of soy sauce', 3.50, 300, 1),
(11, 4, 11, 'Roasted Chickpeas', 'Crunchy roasted chickpeas with your choice of spicy paprika or herb seasoning', 2.50, 180, 1),
(12, 4, 12, 'Trail Mix Cup', 'A mix of nuts, dried fruits, and seeds for an energy boost', 2.00, 200, 1),
(13, 4, 13, 'Chia Pudding Cup', 'Creamy chia pudding made with almond milk and topped with fresh fruit', 3.00, 250, 1),
(14, 4, 14, 'Baked Falafel Bites', 'Baked falafel balls served with a dip of your choice', 3.50, 220, 1),
(15, 4, 15, 'Mini Whole-Grain Breadsticks', 'Crisp, wholesome breadsticks perfect for pairing with hummus or salsa', 2.00, 150, 1),
(16, 4, 16, 'Apple & Cinnamon Chips', 'Baked apple slices lightly dusted with cinnamon', 2.50, 100, 1),
(17, 4, 17, 'Zucchini Fries', 'Baked zucchini sticks coated in a light breadcrumb crust', 3.00, 180, 1),
(18, 5, 18, 'Green Glow Smoothie', 'Spinach, pineapple, cucumber, and coconut water', 3.50, 120, 1),
(19, 5, 19, 'Iced Matcha Latte', 'Lightly sweetened matcha green tea with almond milk', 3.00, 90, 1),
(20, 5, 20, 'Fruit-Infused Water', 'Freshly infused water with a choice of lemon-mint, strawberry-basil, or cucumber-lime', 1.50, 0, 1),
(21, 5, 21, 'Berry Blast Smoothie', 'A creamy blend of strawberries, blueberries, and raspberries with almond milk', 3.80, 140, 1),
(22, 5, 22, 'Citrus Cooler', 'A refreshing mix of orange juice, sparkling water, and a hint of lime', 3.00, 90, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `order_status_id` (`order_status_id`);

--
-- Indexes for table `order_product`
--
ALTER TABLE `order_product`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`order_status_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `image_id` (`image_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `order_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`order_status_id`);

--
-- Constraints for table `order_product`
--
ALTER TABLE `order_product`
  ADD CONSTRAINT `order_product_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
