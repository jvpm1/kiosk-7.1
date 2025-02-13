<script>
  import "../app.css";
  import logo from "../lib/img/logo-picture-text.webp";
  import bgimage from "../lib/img/vegatbles.jpg";
  import dino from "../lib/img/logo-picture.webp";
  import { fade } from 'svelte/transition';
  let showModal = false;
</script>

<div id="container" class="relative flex flex-col items-center gap-12 min-h-screen" style="background-image: url({bgimage}); background-size: cover; background-position: center;">
  <img alt="The project logo" class="w-48 mt-24" src={logo} />
  <button class="bg-green-600 text-white text-3xl font-bold py-2 px-4 rounded-xl shadow-2xl border-gray-600/40 border-1" on:click={() => showModal = true}>
    START YOUR ORDER
  </button>
</div>

{#if showModal}
  <div class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 min-h-screen" style="background-image: url({bgimage}); background-size: cover; background-position: center;" transition:fade>
    <div class="bg-white p-8 rounded shadow-lg">
      <h2 class="text-2xl mb-4">Choose your option</h2>
      <form>
        <div class="mb-4">
          <a href="landingpage">Eat in</a>
        </div>
        <div class="mb-4">
          <a href="landingpage">Eat out</a>
        </div>
      </form>
    </div>
  </div>
{/if}
