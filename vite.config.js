import { defineConfig } from "vite";
import postcss from "@tailwindcss/postcss";

export default defineConfig({
  css: {
    postcss: {
      plugins: [postcss()],
    },
  },
});
