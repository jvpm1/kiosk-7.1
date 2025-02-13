<script lang="ts">
    import dino from "../../lib/img/logo-picture.webp";
    import { onMount } from 'svelte';

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

    let data: Product[] = [];
    let categories: string[] = [];
    let selectedCategory: string = '';

    // Function to dynamically import all images
    const images = import.meta.glob('../../lib/img/menu/*.jpg', { eager: true });

    function getImagePath(filename: string): string {
        const imagePath = `../../lib/img/menu/${filename}`;
        return images[imagePath]?.default || '';
    }

    onMount(async () => {
        const response = await fetch('https://u230061.gluwebsite.nl/kiosk/api/v1/products/', {
            method: "GET",
            mode: "cors"
        });
        data = await response.json();

        // Map the images to the products
        data = data.map(product => {
            product.image.filename = getImagePath(product.image.filename);
            return product;
        });

        // Extract unique categories
        categories = [...new Set(data.map(product => product.category.name))];
        selectedCategory = categories[0]; // Set the initial selected category

    });

    function selectCategory(category: string) {
        selectedCategory = category;
    }
</script>

<pre>
    <!-- {JSON.stringify(data, null, 2)} -->
</pre>

<div class="bg-green-600 rounded p-1"><a href="/" class="text-4xl rounded p-1">Eat in</a></div>
<div id="landingpagecontainer" class="grid grid-cols-4 grid-rows-2 w-screen h-screen">
    <div id="sidebar" class="col-span-1 bg-gray-200 p-4">
        <h2 class="text-2xl font-bold mb-4">Categories</h2>
        <ul>
            {#each categories as category}
                <li class="mb-2">
                    <a href="#" on:click={() => selectCategory(category)} class="text-lg text-blue-600 hover:underline">{category}</a>
                </li>
            {/each}
        </ul>
    </div>
    <div id="categoriecontainer" class="col-span-3 grid grid-cols-3 gap-4">
        <div class="flex flex-row items-start col-span-3">
            <img alt="The project dino" class="w-48 mt-24" src={dino} />
        </div>
        <div id="productscontainer" class="col-span-3 grid grid-cols-3 gap-4">
            {#each data.filter(product => product.category.name === selectedCategory) as product (product.id)}
                <div class="bg-white p-4 rounded shadow">
                    <img alt={product.name} class="w-full h-32 object-cover rounded" src={product.image.filename} />
                    <h3 class="text-xl font-bold">{product.name}</h3>
                    <!-- <p class="text-gray-700">{product.description}</p> -->
                    <p class="text-green-600 font-semibold">${product.price}</p>
                </div>
            {/each}
        </div>
    </div>
</div>