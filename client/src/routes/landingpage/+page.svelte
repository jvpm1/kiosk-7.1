<script lang="ts">
  // Images
  import dino from "../../lib/img/logo-picture.webp";
  import arrowLeft from "$lib/img/bootstrap/arrow-left.svg";
  import globe from "$lib/img/bootstrap/globe.svg";
  import cart from "$lib/img/bootstrap/cart.svg";
  import basket from "$lib/img/bootstrap/basket.svg";
  import breakfast from "$lib/img/breakfast.jpg";
  import lunchdinner from "$lib/img/lunch&dinner.jpg";
  import sides from "$lib/img/sides.jpg";
  import snacks from "$lib/img/snacks.jpg";
  import drink from "$lib/img/drink.jpg";
  import speachbubble from "$lib/img/speachbubble.jpg";

  // Imports
  import { onMount } from "svelte";
  import { redirect } from "@sveltejs/kit";
  import { goto } from "$app/navigation";
  import { crossfade } from "svelte/transition";
  import { quintOut } from "svelte/easing";

  // Interfaces
  interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    image: {
      filename: string;
      description: string;
    };

    category: {
      name: string;
      description: string;
    };
  }

  interface ImageModule {
    default: string;
  }

  // Values
  let cartItems: Product[] = [
    {
      id: 1,
      name: "Morning Boost Smoothie Bowl",
      description:
        "A blend of acai, banana, and mixed berries topped with granola, chia seeds, and coconut flakes",
      price: 4.5,
      category: {
        name: "Breakfast",
        description:
          "Start your day right with our nutritious breakfast options",
      },
      image: {
        filename:
          "/src/lib/img/menu/DALLE_2025-01-22_15.59.38_-_A_sleek_and_modern_logo_design_for_a_brand_emphasizing_speed_health_and_convenience._The_logo_features_vibrant_green_and_orange_color_palette_to_sym.jpg",
        description: "Morning Boost Smoothie Bowl Logo",
      },
    },
    {
      id: 6,
      name: "Zesty Chickpea Wrap",
      description:
        "Whole-grain wrap with spiced chickpeas, shredded carrots, lettuce, and hummus",
      price: 4.5,
      category: {
        name: "Lunch & Dinner",
        description: "Healthy and satisfying meals for any time of day",
      },
      image: {
        filename:
          "/src/lib/img/menu/DALLE_2025-01-22_16.00.00_-_A_photorealistic_depiction_of_a_wrap_called_Zesty_Chickpea_Wrap._The_wrap_is_made_with_a_whole-grain_tortilla_filled_with_spiced_chickpeas_shredde.jpg",
        description: "Zesty Chickpea Wrap",
      },
    },
  ];
  let productsData: Product[] = [];
  let categories: string[] = [];
  let selectedCategory: string = "";

  const images = import.meta.glob("../../lib/img/menu/*.jpg", { eager: true });

  // Core values
  let currentDisplay: number = 2; // 1 = items, 2 = cart
  let totalPrice = 0;

  // Functions
  function updateTotalPrice() {
    let num = 0;
    cartItems.forEach((productsData: Product) => {
      num += productsData.price;
    });
    totalPrice = num;
  }

  function addCartItem(productData: Product) {
    cartItems.push(productData);
    updateTotalPrice();
  }

  function getImagePath(filename: string): string {
    const imagePath = `../../lib/img/menu/${filename}`;
    return (images[imagePath] as ImageModule)?.default || "";
  }

  onMount(async () => {
    const response = await fetch(
      "https://u230061.gluwebsite.nl/kiosk/api/v1/products/",
      {
        method: "GET",
        mode: "cors",
      }
    );
    productsData = await response.json();

    // Map the images to the products
    productsData = productsData.map((product) => {
      product.image.filename = getImagePath(product.image.filename);
      return product;
    });

    // Extract unique categories
    categories = [
      ...new Set(productsData.map((product) => product.category.name)),
    ];
    selectedCategory = categories[0]; // Set the initial selected category
  });

  function selectCategory(category: string) {
    selectedCategory = category;
  }

  function getCategoryImage(category: string): string {
    switch (category) {
      case "Breakfast":
        return breakfast;
      case "Lunch & Dinner":
        return lunchdinner;
      case "Sides":
        return sides;
      case "Snacks":
        return snacks;
      case "Drinks":
        return drink;
      default:
        return "";
    }
  }

  // Remove this
  // This is for debugging
  updateTotalPrice();
</script>

<!-- Main display -->
<div
  id="mainDisplay"
  class="w-full h-screen flex flex-col absolute bg-[var(--background)]"
>
  <!-- Items -->
  {#if currentDisplay == 1}
    <div id="landingpagecontainer" class="flex w-full h-full">
      <!-- Sidebar -->
      <div
        id="sidebar"
        class="bg-background rounded-br-xl p-4 bg-[var(--secondary)] w-[256px]"
      >
        <ul>
          {#each categories as category}
            <li class="mb-4">
              <button
                on:click={() => selectCategory(category)}
                class="w-full text-center p-4 rounded-lg {selectedCategory ===
                category
                  ? 'bg-[var(--lightorange)]'
                  : 'bg-transparent'}"
                style="height: 200px;"
              >
                <img
                  src={getCategoryImage(category)}
                  alt={category}
                  class="w-16 h-16 mx-16 mb-2 rounded-xl"
                />
                <span class="text-lg font-bold text-black">{category}</span>
              </button>
            </li>
          {/each}
        </ul>
      </div>

      <div id="categoriecontainer" class="flex flex-col h-full">
        <div class="flex flex-row items-start">
          <img alt="The project dino" class="w-48 mt-24" src={dino} />
          <div class="relative" style="width: 400px; height: 300px;">
            <img
              src={speachbubble}
              alt="Speech Bubble"
              class="absolute inset-0 w-full h-full object-contain"
            />
            {#if selectedCategory}
              <div
                class="absolute inset-0 flex items-center justify-center p-4"
                style="width: 300px; margin: auto;"
              >
                <p class="text-lg font-bold">
                  {productsData.find(
                    (product) => product.category.name === selectedCategory
                  )?.category.description}
                </p>
              </div>
            {/if}
          </div>
        </div>

        <div id="productscontainer" class="grid grid-cols-3 gap-4">
          {#each productsData.filter((productData) => productData.category.name === selectedCategory) as productData (productData.id)}
            <button
              class="bg-white p-4 rounded shadow flex flex-col gap-2"
              on:click={() => addCartItem(productData)}
            >
              <div class="h-full w-48">
                <img
                  alt={productData.name}
                  class="w-64 h-32 object-cover rounded"
                  src={productData.image.filename}
                />
                <h3 class="text-xl font-bold">{productData.name}</h3>
              </div>
              <p class="text-green-600 font-semibold">${productData.price}</p>
            </button>
          {/each}
        </div>
      </div>
    </div>
  {/if}

  <!-- Cart -->
  {#if currentDisplay == 2}
    <div
      class="flex flex-col items-center justify-between w-full h-full gap-2 p-4"
    >
      <div id="itemsContainer" class="w-4/5 h-full flex-col flex">
        <div class="w-full h-full flex flex-col">
          <img src={dino} class="h-50 mx-auto" alt="" />

          <div class="space-y-5">
            <h2 class="text-8xl font-bold text-black/80">Your cart items</h2>

            <!-- Items -->
            <div class="space-y-5">
              {#each cartItems as cartItem}
                <div
                  class="w-full p-5 h-50 flex gap-5 text-3xl font-bold text-black/70 rounded-4xl"
                >
                  <img
                    src={cartItem.image.filename}
                    alt=""
                    class="h-full rounded-3xl"
                  />

                  <div class="flex flex-col gap-3 justify-between w-full py-3">
                    <div class="flex justify-between w-full">
                      <div>
                        <p>{cartItem.name}</p>
                        <div
                          class="text-sm text-black/30 w-120 text-nowrap overflow-hidden"
                        >
                          {cartItem.description}
                        </div>
                      </div>
                      <p class="text-4xl">€ {cartItem.price}0</p>
                    </div>

                    <div class="flex items-center gap-5">
                      <button
                        id="purchaseButton"
                        class="w-auto h-auto rounded-2xl bg-[var(--secondary)] px-6 py-3 text-2xl font-bold text-black/80"
                        >Delete</button
                      >
                      <button
                        id="purchaseButton"
                        class="w-auto h-auto rounded-2xl bg-[var(--secondary)] px-6 py-3 text-2xl font-bold text-black/80"
                        >Duplicate</button
                      >
                    </div>
                  </div>
                </div>
              {/each}

              <div
                class="flex flex-row justify-between text-black/80 text-4xl font-bold"
              >
                <span>Total:</span>
                <span>€ {totalPrice}</span>
              </div>
            </div>
          </div>
        </div>

        <button
          id="purchaseButton"
          class="w-auto h-auto rounded-4xl bg-[var(--secondary)] p-4 text-5xl font-bold text-black/80"
          >Checkout</button
        >
      </div>
    </div>
  {/if}

  <!-- Bottom bar -->
  <div class="h-23 bg-transparent flex items-center justify-between px-4">
    <div class="flex items-center space-x-4">
      <!-- Cancel Order -->
      <button
        on:click={() => {
          if (currentDisplay == 2) {
            currentDisplay = 1;
            return;
          }

          goto("/");
        }}
        class="flex items-center text-black/70 gap-2 rounded-4xl bg-[var(--secondary)] p-4 cursor-pointer"
      >
        <img src={arrowLeft} class="opacity-70 h-5 mt-0.5" alt="" />
        <span class="font-bold text-xl">
          {#if currentDisplay == 1}
            Cancel order
          {:else}
            Go back
          {/if}
        </span>
      </button>

      <!-- Langauge -->
      <button
        class="flex items-center text-black/70 gap-2 rounded-4xl bg-[var(--secondary)] p-4 cursor-pointer"
      >
        <img src={globe} class="opacity-70 h-5 mt-0.5" alt="" />
        <span class="font-bold text-xl">ENG</span>
      </button>
    </div>

    <div class="flex items-center space-x-4">
      {#if currentDisplay == 1}
        <!-- View cart -->
        <button
          on:click={() => {
            currentDisplay = 2;
          }}
          class="flex items-center text-black/70 gap-2 rounded-3xl bg-[var(--secondary)] p-4 cursor-pointe"
        >
          <img src={basket} class="opacity-70 h-5 mt-0.5" alt="" />
          <span class="font-bold text-xl">View cart</span>
        </button>

        <!-- Preview text -->
        <div class="flex items-center text-black/70 font-bold text-xl gap-4">
          <div class="flex flex-row gap-2 items-center">
            <img src={cart} class="opacity-70 h-5 mt-0.5" alt="" />
            <span>2 items</span>
          </div>
          <span class="ml-2">€ 4.50</span>
        </div>
      {/if}
    </div>
  </div>
</div>
