<script lang="ts">
  // Images
  import dino from "$lib/img/logo-picture.webp";
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
  import personArmsUp from "$lib/img/bootstrap/person-arms-up.svg";

  // Imports
  import { onMount } from "svelte";
  import { goto } from "$app/navigation";
  import Icon from "@iconify/svelte";
  import { fade } from "svelte/transition";

  // Interfaces
  interface Product {
    id: number;
    name: string;
    description: string;
    price: string;
    image: {
      filename: string;
      description: string;
    };

    category: {
      name: string;
      description: string;
    };

    calories: number;
  }

  interface ImageModule {
    default: string;
  }

  // Values
  let cartItems: Product[] = [];
  let productsData: Product[] = [];
  let categories: string[] = [];
  let selectedCategory: string = "";
  let showPopup: boolean = false;
  let selectedProduct: Product | null = null;

  const images = import.meta.glob("../../lib/img/menu/*.jpg", { eager: true });

  // Core values
  let currentDisplay: number = 1; // 1 = items, 2 = cart
  let babyMode: boolean = false;
  let totalPrice: number = 0;
  let totalInCart: number = 0;

  // Functions
  function getAmountInCart(productData: Product) {
    let num = 0;
    cartItems.forEach((_productData: Product) => {
      if (_productData.id != productData.id) {
        return;
      }

      num++;
    });
    return num;
  }

  function updateCartValues() {
    let num = 0;
    cartItems.forEach((productsData: Product) => {
      num += Number(productsData.price);
    });
    totalPrice = Math.floor(num * 100) / 100;
    totalInCart = cartItems.length;
  }

  function deleteCartItem(productData: Product) {
    let alreadyFound = false;

    cartItems = cartItems.filter((_productData: Product) => {
      if (alreadyFound) return true;

      const isSame = productData.id == _productData.id;
      if (isSame) {
        alreadyFound = true;
      }
      return !isSame;
    });

    updateCartValues();
  }

  function addCartItem(productData: Product) {
    cartItems = [...cartItems, productData];

    updateCartValues();
  }

  function getImagePath(filename: string): string {
    const imagePath = `../../lib/img/menu/${filename}`;
    return (images[imagePath] as ImageModule)?.default || "";
  }

  function openPopup(product: Product) {
    selectedProduct = product;
    showPopup = true;
  }

  function closePopup() {
    showPopup = false;
    selectedProduct = null;
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

  function getStrokeDasharray(value: number, max: number): string {
    const radius = 50;
    const circumference = 2 * Math.PI * radius;
    const progress = (value / max) * circumference;
    return `${progress} ${circumference - progress}`;
  }

  // Remove this
  // This is for debugging
  updateCartValues();
</script>

<!-- Main display -->
<div
  id="mainDisplay"
  class="w-full h-screen flex flex-col absolute bg-[var(--background)] justify-end *:transition-all *:overflow-hidden {showPopup
    ? 'blurred'
    : ''}"
>
  <!-- Items -->
  {#if currentDisplay == 1}
    <div
      id="landingpagecontainer"
      class="flex w-full {babyMode ? 'h-[700px]' : 'h-full'}"
    >
      <!-- Sidebar -->
      <div
        id="sidebar"
        class="bg-background rounded-br-4xl overflow-y-scroll p-4 bg-[var(--secondary)] w-[256px] flex flex-col items-center"
      >
        <ul class="space-y-5">
          {#each categories as category}
            <li>
              <button
                onclick={() => selectCategory(category)}
                class="w-full text-center p-10 rounded-3xl flex flex-col items-center {selectedCategory ===
                category
                  ? 'bg-[var(--lightorange)]'
                  : 'bg-transparent'}"
              >
                <img
                  src={getCategoryImage(category)}
                  alt={category}
                  class="w-20 h-20 mb-2 rounded-xl"
                />
                <span class="text-lg font-bold text-black">{category}</span>
              </button>
            </li>
          {/each}
        </ul>
      </div>

      <div
        id="categoriecontainer"
        class="flex flex-col h-full w-full overflow-y-scroll"
      >
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
                <p class="text-lg font-bold text-center">
                  {productsData.find(
                    (product) => product.category.name === selectedCategory
                  )?.category.description}
                </p>
              </div>
            {/if}
          </div>
        </div>

       <!-- productcontainer -->
        <div id="productscontainer" class="grid grid-cols-3 gap-12 mx-8">
          {#each productsData.filter((productData) => productData.category.name === selectedCategory) as productData (productData.id)}
            {@const isInCart = cartItems.find(
              (_productData) => _productData.id == productData.id
            )}
            <button
              class="bg-white rounded shadow flex flex-col items-start product-button"
              onclick={() => addCartItem(productData)}
            >
              {#if isInCart}
                <div in:fade class="absolute z-10 p-1">
                  <div
                    class="rounded-full bg-white font-bold min-w-6 h-6 shadow-2xl flex items-center justify-center px-2"
                  >
                    {getAmountInCart(productData)}
                  </div>
                </div>
              {/if}

              <div class="h-58 w-full">
                <img
                  alt={productData.name}
                  class="w-full h-38 object-cover rounded-t"
                  src={productData.image.filename}
                />
                <h3 class="text-xl font-bold pt-2">{productData.name}</h3>
              </div>
              <div class="flex flex-row">
                <p class="pl-3 pb-3 text-green-600 font-semibold">
                  ${productData.price}
                </p>
                <div class="ml-32">
                  <!-- svelte-ignore a11y_click_events_have_key_events -->
                  <!-- svelte-ignore a11y_no_static_element_interactions -->
                  <div
                    onclick={() => openPopup(productData)}
                    class="cursor-pointer"
                  >
                    <Icon icon="carbon:information" width="24" height="24" />
                  </div>
                </div>
              </div>
            </button>
          {/each}
        </div>
      </div>
    </div>
  {/if}

  <!-- Cart -->
  {#if currentDisplay == 2}
    <div
      class="flex flex-col items-center justify-between w-full gap-2 p-4 {babyMode
        ? 'h-[700px]'
        : 'h-full'}"
    >
      <div id="itemsContainer" class="w-4/5 h-full flex-col flex">
        <div class="w-full h-full flex flex-col overflow-y-scroll">
          <img src={dino} class="h-50 mx-auto" alt="" />

          <div class="space-y-5">
            <h2 class="text-8xl font-bold text-black/80">Your cart items</h2>

            <!-- Items -->
            <div class="space-y-5 max-h-[60vh] overflow-y-scroll">
              {#each cartItems as productData}
                <div
                  class="w-full p-5 h-50 flex gap-5 text-3xl font-bold text-black/70 rounded-4xl"
                >
                  <img
                    src={productData.image.filename}
                    alt={productData.name}
                    class="h-full rounded-3xl"
                  />

                  <div class="flex flex-col gap-3 justify-between w-full py-3">
                    <div class="flex justify-between w-full">
                      <div>
                        <p>{productData.name}</p>
                        <div
                          class="text-sm text-black/30 w-120 text-nowrap overflow-hidden"
                        >
                          {productData.description}
                        </div>
                      </div>
                      <p class="text-4xl">€ {productData.price}</p>
                    </div>

                    <div class="flex items-center gap-5">
                      <button
                        onclick={() => deleteCartItem(productData)}
                        class="w-auto h-auto rounded-2xl bg-[var(--secondary)] px-6 py-3 text-xl font-bold text-black/80"
                        >Delete</button
                      >
                      <button
                        onclick={() => addCartItem(productData)}
                        id="purchaseButton"
                        class="w-auto h-auto rounded-2xl bg-[var(--secondary)] px-6 py-3 text-xl font-bold text-black/80"
                        >Duplicate</button
                      >
                    </div>
                  </div>
                </div>
              {/each}
            </div>
            <div class="w-full h-0.5 bg-black/20"></div>

            <div
              class="flex flex-row justify-between text-black/80 text-4xl font-bold"
            >
              <span>Total:</span>
              <span>€ {totalPrice}</span>
            </div>

            <div class="w-full h-0.5 bg-black/20"></div>
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
        onclick={() => {
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

      <!-- Babymode -->
      <button
        onclick={() => {
          babyMode = !babyMode;
        }}
        class="flex items-center text-black/70 gap-2 rounded-4xl bg-[var(--secondary)] p-4 cursor-pointer"
      >
        <img src={personArmsUp} class="opacity-70 h-5 mt-0.5" alt="" />
      </button>
    </div>

    <div class="flex items-center space-x-4">
      {#if currentDisplay == 1}
        <!-- View cart -->
        <button
          onclick={() => {
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
            <span>{totalInCart} items</span>
          </div>
          <span class="ml-2">€ {totalPrice}</span>
        </div>
      {/if}
    </div>
  </div>
</div>

<!-- Popup -->
{#if showPopup && selectedProduct}
  <div
    class="fixed inset-0 flex items-center justify-center bg-opacity-50 z-50"
  >
    <div class="bg-white p-8 rounded-lg shadow-lg w-1/2 relative">
      <h2 class="text-3xl font-bold mb-4 text-center">
        {selectedProduct.name}
      </h2>
      <img
        src={selectedProduct.image.filename}
        alt={selectedProduct.name}
        class="w-full h-48 object-cover rounded-lg mb-4"
      />
      <p class="mb-4 text-lg text-gray-700">{selectedProduct.description}</p>
      <p class="mb-4 text-lg font-semibold">Price: ${selectedProduct.price}</p>
      <div class="flex flex-col items-center justify-center mb-4">
        <svg width="120" height="120" class="relative">
          <circle
            cx="60"
            cy="60"
            r="50"
            stroke="#e6e6e6"
            stroke-width="10"
            fill="none"
          />
          <circle
            cx="60"
            cy="60"
            r="50"
            stroke="#4CAF50"
            stroke-width="10"
            fill="none"
            stroke-dasharray="0 314"
            stroke-linecap="round"
            transform="rotate(-90 60 60)"
            class="progress-circle"
            style="--progress-dasharray: {getStrokeDasharray(
              selectedProduct.calories,
              500
            )};"
          />
        </svg>
        <span class="absolute text-xl font-bold mt-2"
          >{selectedProduct.calories} cal</span
        >
      </div>
      <button
        onclick={closePopup}
        class="bg-[var(--primary)] text-white px-4 py-2 rounded-lg w-full mt-4"
      >
        Close
      </button>
    </div>
  </div>
{/if}
