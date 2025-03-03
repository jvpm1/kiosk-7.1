<script>
  import "../app.css";
  import logo from "../lib/img/logo-picture-text.webp";
  import bgImage1 from "../lib/img/vegatbles.jpg";
  import bgImage2 from "../lib/img/woodbackground.jpg";
  import { fade } from "svelte/transition";

  let showModal = false;
</script>

<div
  id="container"
  class="relative flex flex-col items-center gap-12 min-h-screen background-animation"
  style="background-size: cover; background-position: center;"
>
  <img alt="The project logo" class="w-96 mt-[50%] opacity-0 animate-fade-in" src={logo} />
  
  <button
    class="text-animation bg-gradient-to-r from-[var(--green3)] via-[var(--green2)] to-[var(--primary)] bg-clip-text text-transparent text-5xl font-black"
    on:click={() => (showModal = true)}
  >
    START YOUR ORDER
  </button>
</div>

{#if showModal}
  <div
    class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 min-h-screen modal-background"
    transition:fade
  >
    <div class="bg-white p-8 rounded shadow-lg space-y-10">
      <h2 class="text-5xl">Choose your option</h2>
      <form
        class="text-white flex gap-6 flex-col font-bold *:bg-green-600 *:p-7 *:rounded-3xl text-5xl"
      >
        <a href="landingpage?t=1"><span>Eat in</span></a>
        <a href="landingpage?t=2"><span>Eat out</span></a>
      </form>
    </div>
  </div>
{/if}

