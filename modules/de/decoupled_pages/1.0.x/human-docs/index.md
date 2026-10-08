# Decoupled Pages — manual setup guide

**Decoupled Pages** (`decoupled_pages`) provides a quick, simple way to create
Drupal routes that serve **single‑page applications (SPAs)** — a JavaScript app
written in React, Vue, Ember, or any similar framework — at a Drupal path. It is a
tool for **progressive decoupling**: rather than making your whole site headless,
you keep Drupal rendering most pages and hand a specific route (or set of routes)
over to a client‑side app.

This is a **developer‑oriented** module: you use it by defining routes in your own
module's `*.routing.yml`, not by clicking through an admin form. The route
definition looks almost normal, except that instead of a `_controller` or `_form`
requirement you set a **`_decoupled_page_main`** requirement whose value is the
name of an asset library containing your SPA (for example `your_module/name`). When
someone visits that path, Decoupled Pages renders the page shell of your active
theme and drops an empty `<div id="decoupled-page-root">` into the main content
region; your JavaScript attaches to that element and takes over rendering.

A few route options make it practical for real apps. `_decoupled_page_paths` lets
you register the additional client‑side routes your SPA defines, so users can link
directly to them and Drupal will still serve your app. `_decoupled_page_assets`
attaches extra CSS/JS libraries beyond your main one. And `_decoupled_page_data`
passes configuration (such as an API base path) to your JavaScript via `data-*`
attributes on the root element. The module also ships a `decoupled_pages_test`
submodule and a pre‑defined `decoupled_pages/route_test` library you can point a
route at to confirm the wiring before you build your own.

One important security note carried over from the module's own documentation:
setting a route's `_access: 'TRUE'` makes that route **accessible to everyone**.
Access to a decoupled page is governed by the route's normal access requirements —
define them deliberately. The SPA's *data* access (typically fetched over
JSON:API/REST) is a separate concern, governed by those APIs' own access controls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings form** — it is configured entirely through route
definitions in code, as summarized above and in "How to use it" below. There is
therefore no separate Configuration section in this guide.

## Where it lives in the admin menu

Decoupled Pages adds no admin page and no menu item. You work with it from your
custom module's `*.routing.yml` and `*.libraries.yml` files.

## How to use it

1. **Define a route** in your module's `*.routing.yml`. Use a
   `_decoupled_page_main` requirement pointing at your SPA's asset library instead
   of a `_controller`/`_form`:

   ```yaml
   your_module.foo:
     path: /some/path/of/your-choosing
     defaults:
       _decoupled_page_main: your_module/my_app
     requirements:
       _access: 'TRUE'   # WARNING: this makes the route public to everyone
   ```

2. **Provide the asset library** in `your_module.libraries.yml` (or use the bundled
   `decoupled_pages/route_test` library to test first). Rebuild the cache
   (`drush cr`) and enable your module so the route becomes available.

3. **Attach your JavaScript** to the root element the module renders:

   ```js
   const root = document.getElementById('decoupled-page-root');
   ```

4. **Customize as needed** with route options: `_decoupled_page_paths` (register
   your SPA's own client‑side routes), `_decoupled_page_assets` (extra CSS/JS
   libraries), and `_decoupled_page_data` (pass config as `data-*` attributes;
   dashed keys become camelCase in `root.dataset`).
