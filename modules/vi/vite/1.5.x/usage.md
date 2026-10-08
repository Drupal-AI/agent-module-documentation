Vite wires Drupal's asset-library system to a [Vite](https://vitejs.dev) frontend build: you declare source asset paths (`src/script.ts`, `src/style.scss`) in a library and the module rewrites them to Vite's hashed `dist` output at runtime (or to the Vite dev server for hot module reload).

---

The module implements `hook_library_info_alter()` and, through the `vite.vite` service, rewrites any asset library opted in to Vite. For each such library it reads Vite's `manifest.json` (default `dist/.vite/manifest.json`) and swaps each source path for the built chunk, pulling in the chunk's associated CSS and imports; JS is emitted as `type="module"`. If the Vite dev server is reachable (auto-probed at `http://localhost:5173/@vite/client`, or forced via the `useDevServer` setting) it instead points assets at the dev server and injects the `vite/vite-dev-client` (`@vite/client`) library plus any declared `devDependencies`, giving HMR. Opt-in is layered: a whole theme/module via `vite.enableInAllLibraries` / `vite.enableInAllComponents` in its `.info.yml`, a single library via `vite: true` (or a `vite:` config map) in `*.libraries.yml`, a single asset via `{vite: false}` to exclude it, and global defaults/overrides via `$settings['vite']` in `settings.php`. Per-library keys include `enabled`, `viteRoot`, `distDir`, `manifestPath`, `baseUrl`, `devServerUrl`, and `devDependencies` (a deprecated `manifest` key still works). Beyond libraries, the `getChunk($extension, $library, $chunk)` service method and the `vite_get_chunk_path()` Twig function resolve a single built asset path (e.g. an image) outside a library definition. There is no admin UI, permission, config entity, or Drush command — everything is driven by info/library YAML and settings.php. It also documents workarounds (source-form `Drupal.t()` usage or `vite-plugin-preserve-drupal-t`) so JS translation extraction survives minification.

---

- Use a modern Vite/Rollup build (TypeScript, SCSS, JSX, code-splitting) for a Drupal theme's assets.
- Reference source files (`src/main.ts`) in a `.libraries.yml` and let Vite's hashed `dist` output be served in production.
- Turn on Vite for every library in a theme with `vite.enableInAllLibraries: true` in the theme `.info.yml`.
- Turn on Vite for every SDC component library with `vite.enableInAllComponents: true`.
- Opt a single asset library into Vite with `vite: true` in `theme.libraries.yml`.
- Exclude one static asset inside a Vite-managed library with `some/script.js: {vite: false}`.
- Get hot module reload during development by starting the Vite dev server (auto-detected on port 5173).
- Point the module at a custom dev-server URL/port with the `devServerUrl` setting.
- Force dev-server use on or off per environment with `$settings['vite']['useDevServer']` (`'auto'`, `true`, `false`).
- Serve built assets from a CDN by setting `baseUrl` for a library.
- Put the Vite root outside the Drupal app root (monorepo) using `viteRoot: '/..'`.
- Point at a non-default build output directory with `distDir` (e.g. `web/libraries/dist`).
- Use a custom manifest filename/location with `manifestPath` relative to `distDir`.
- Resolve a single built asset path (e.g. a logo/image) in PHP with `\Drupal::service('vite.vite')->getChunk(...)`.
- Resolve a built asset path in a Twig template with `{{ vite_get_chunk_path('theme', 'global', 'assets/logo.svg') }}`.
- Automatically attach a chunk's associated CSS (from the manifest) whenever its JS entry is used.
- Wire a React app with the `@react-refresh` preamble via `devDependencies` loaded only in dev mode.
- Apply Vite settings globally or per module/theme/library through `$settings['vite']['overrides']`.
- Migrate a legacy asset pipeline to Vite incrementally, one library at a time.
- Keep Drupal's JS translation extraction working under minification using `vite-plugin-preserve-drupal-t`.
- Ship SDC components whose source `.pcss.css`/`.ts` files are compiled by Vite via `libraryOverrides`.
- Use the deprecated `manifest:` key for backward compatibility with an existing Vite setup.
