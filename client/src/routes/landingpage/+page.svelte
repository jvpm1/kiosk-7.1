<script lang="ts">
  // Imports
  import dino from "../../lib/img/logo-picture.webp";
  import { onMount } from "svelte";

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

  interface Item {
    productData: Product;
    amount: number;
  }

  interface ImageModule {
    default: string;
  }

  // Values
  let cartItems: Item[] = [];
  let productsData: Product[] = [];
  let categories: string[] = [];
  let selectedCategory: string = "";

  const images = import.meta.glob("../../lib/img/menu/*.jpg", { eager: true });

  // Core values
  let currentDisplay: number = 1; // 1 = items, 2 = cart

  // Functions
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

  function addCartItem(productData: Product) {}

  function selectCategory(category: string) {
    selectedCategory = category;
  }
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
        class="col-span-1 bg-background p-4 h-full bg-[var(--secondary)]"
      >
        <h2 class="text-2xl font-bold mb-4">Categories</h2>
        <ul>
          {#each categories as category}
            <li class="mb-2">
              <a
                href="#"
                on:click={() => selectCategory(category)}
                class="text-lg font-bold text-black hover:underline"
                >{category}</a
              >
            </li>
          {/each}
        </ul>
      </div>

      <div id="categoriecontainer" class="flex flex-col h-full">
        <div class="flex flex-row items-start">
          <img alt="The project dino" class="w-48 mt-24" src={dino} />
        </div>

        <div id="productscontainer" class="grid grid-cols-3 gap-4">
          {#each productsData.filter((productData) => productData.category.name === selectedCategory) as productData (productData.id)}
            <button
              class="bg-white p-4 rounded shadow flex flex-col gap-2"
              on:click={() => addCartItem(productData)}
            >
              <div class="h-full">
                <img
                  alt={productData.name}
                  class="w-full h-32 object-cover rounded"
                  src={productData.image.filename}
                />
                <h3 class="text-xl font-bold">{productData.name}</h3>
              </div>

              <!-- <p class="text-gray-700">{product.description}</p> -->
              <p class="text-green-600 font-semibold">${productData.price}</p>
            </button>
          {/each}
        </div>
      </div>
    </div>
  {/if}

  <!-- Cart -->
  {#if currentDisplay == 2}
    <div class="flex w-full h-full"></div>
  {/if}

  <div
    class="h-[50px] border-t bg-white flex items-center justify-between px-4"
  >
    <div class="flex items-center space-x-4">
      <button class="flex items-center text-gray-600">
        <span>← Cancel order</span>
      </button>
      <button class="flex items-center text-gray-600">
        <span>ENG</span>
      </button>
    </div>
    <div class="flex items-center space-x-4">
      <button class="flex items-center text-gray-600">
        <span>View cart</span>
      </button>
      <div class="flex items-center text-gray-600">
        <span>2 items</span>
        <span class="ml-2">€ 4.50</span>
      </div>
    </div>
  </div>
</div>
