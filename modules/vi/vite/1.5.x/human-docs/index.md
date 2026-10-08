# Vite — manual setup guide

**Vite** (`vite`) connects Drupal's asset-library system to a
[Vite](https://vitejs.dev) frontend build. Instead of committing pre-built,
hand-managed CSS/JS to your theme, you declare the **source** files
(`src/main.ts`, `src/style.scss`) in a normal library definition, and the module
rewrites those paths at runtime to Vite's hashed production output — or, during
development, to a running Vite dev server so you get hot module reload (HMR). That
lets a Drupal theme or module use a modern build (TypeScript, SCSS, JSX,
code-splitting) with the workflow frontend developers expect.

The clever part is that it slots into Drupal's existing libraries rather than
replacing them. You opt a library in, and the module reads Vite's `manifest.json`
to swap each source path for the built chunk, automatically pulling in the chunk's
associated CSS and imports (and emitting JS as ES modules). If the Vite dev server
is reachable it points assets there instead and injects the Vite HMR client. You
can opt in at several levels — a whole theme/module, a single library, or exclude
one asset — and tune everything (build directory, manifest path, CDN base URL,
dev-server URL) through YAML and `settings.php`.

This is a **developer / theme-build tool**, so its "configuration" lives entirely
in your `.info.yml`, `*.libraries.yml` and `settings.php` files — there is no admin
UI, permission, config entity or Drush command (`configure: null`). This guide
covers installation plus a summary of how to turn Vite on; the full set of config
keys, the PHP service and the Twig helper are in the sibling
[`agent/`](../agent/start.md) docs, the terse token-cheap references written for an
AI coding agent. Vite requires Drupal 10.3+ or 11, has no submodules, and adds no
PHP libraries (the actual `vite` tooling is a Node dev dependency of your theme,
not a Composer package).

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and a note on the Node-side Vite tooling).

## Where it lives in the admin menu

Nowhere. Vite has no admin page or settings form. You configure it in code:
`.info.yml`, `*.libraries.yml` and `settings.php`.

## How to use it

The workflow, in brief:

1. **Set up Vite in your theme/module's frontend tooling** (a `package.json` with
   `vite`, a `vite.config.*`, your `src/` files) and produce a build with a
   manifest — by default in `dist/` with the manifest at
   `dist/.vite/manifest.json`.

2. **Point your library at the source files and opt it in.** In
   `*.libraries.yml`, reference the `src/` paths and add `vite: true`:

   ```yaml
   global-styling:
     vite: true
     js:
       src/script.ts: {}
     css:
       component:
         src/scss/style.scss: {}
   ```

   To turn Vite on for *every* library in a theme, put this in the theme's
   `.info.yml` instead:

   ```yaml
   vite:
     enableInAllLibraries: true
     enableInAllComponents: true   # also covers SDC component libraries
   ```

   You can exclude a single asset inside an otherwise Vite-managed library with
   `some/static/script.js: {vite: false}`.

3. **For production**, run your Vite build so the manifest and hashed `dist`
   output exist; Drupal then serves those built files.

4. **For development with HMR**, start the Vite dev server. The module
   auto-detects it on `http://localhost:5173`; when it's up, assets point at the
   dev server and the HMR client is injected. Because Drupal caches library
   definitions, run `drush cr` after starting or stopping the dev server or after
   changing your YAML.

Global defaults and per-extension/per-library overrides — dev-server URL, build
directory (`distDir`), manifest path, a CDN `baseUrl`, forcing the dev server on
or off — all go in `$settings['vite']` in `settings.php`. Beyond libraries, a
`getChunk()` PHP method and a `vite_get_chunk_path()` Twig function resolve a
single built asset path (say an image) outside a library. See the
[`agent/`](../agent/start.md) docs for every key and the resolution order.
