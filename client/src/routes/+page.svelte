<script>
  import { goto } from '$app/navigation';
  import "../app.css";
  import logo from "../lib/img/logo-picture-text.webp";
  import bgImage1 from "../lib/img/vegatbles.jpg";
  import bgImage2 from "../lib/img/woodbackground.jpg";
  import gif from "../lib/img/taphere.gif";
</script>

<!-- svelte-ignore a11y_click_events_have_key_events -->
<!-- svelte-ignore a11y_no_static_element_interactions -->
<div
  id="container"
  class="relative flex flex-col items-center gap-12 min-h-screen background-animation"
  style="background-size: cover; background-position: center;"
  on:click={() => goto('landingpage')}
>
  <img
    alt="The project logo"
    class="w-112 mt-[40%] opacity-0 animate-fade-in"
    src={logo}
  />

  <div
    class="text-animation bg-gradient-to-r from-[var(--green3)] via-[var(--green2)] to-[var(--primary)] bg-clip-text text-transparent text-7xl font-black"
  >
    START YOUR ORDER
  </div>

  <img
    alt="Tap here"
    class="w-64 mt-4"
    src={gif}
  />
</div>
