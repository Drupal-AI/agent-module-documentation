import { resolve } from 'node:path';
import { defineConfig } from 'vite';

// Relative base so the built site works under a GitHub project-pages path
// (https://user.github.io/<repo>/) without hard-coding the repo name.
export default defineConfig({
  base: './',
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        dashboard: resolve(__dirname, 'dashboard.html'),
      },
    },
  },
});
