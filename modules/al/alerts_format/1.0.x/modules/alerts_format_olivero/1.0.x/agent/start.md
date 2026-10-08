<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alerts Format - Olivero (alerts_format_olivero) — agent index

Olivero-theme presentation submodule of **Alerts Format**. Version **1.0.0-beta1**. Core
`^10 || ^11`. License GPL-2.0-or-later. Package **Recipes Support**.
**Depends on** `alerts_format:alerts_format`.

## What it actually is

- **One hook.** `alerts_format_olivero_views_pre_render(ViewExecutable $view)` in
  `alerts_format_olivero.module`: when `$view->id() == 'alerts'`, it appends the asset library
  `alerts_format_olivero/olivero_display` to `$view->element['#attached']['library']`.
- **The library** (`alerts_format_olivero.libraries.yml`, `olivero_display`) pulls in
  `css/olivero-display.css` (component) and `js/alerts-dismiss.js`, depending on `core/drupal`
  and `core/once`.
- **Ships block config** `config/install/block.block.views_block__alerts_block_1.yml`: places
  `views_block:alerts-block_1` (from `views.view.alerts`) in the **Olivero header** region.
- Provides no routes, permissions, services, plugins, schema, or configuration form.

## The pieces

- **`css/olivero-display.css`** — makes `.block-views-blockalerts-block-1 .alert-banner`
  full-viewport-width in the Olivero header, with `@media` breakpoints and a
  `body.gin--vertical-toolbar` offset; styles banner links and the `messages__close` button;
  positions an "add" button from the View header.
- **`js/alerts-dismiss.js`** — `Drupal.behaviors.alertsDismiss` (guarded by `once`):
  - `augmentAlert()` creates a `<button class="messages__close">` with a visually-hidden
    `Drupal.t('Dismiss Alert')` label and appends it to each `div.alert-banner`'s first child.
  - On click it sets the banner's `parent.style.display = "none"`, pushes `parent.id` into a
    `dismissed` array, and writes it to `localStorage`.
  - On load it hides banners whose ids are in `localStorage['dismissed']`, and prunes ids with no
    matching element unless the page is a single alert node (`body.page-node-type-alert`).
  - **Client-side only** — no server request, no state change; dismissed state lives per browser.

## Operating notes

- Enable after the parent module: `drush en alerts_format_olivero -y` (pulls in `alerts_format`).
  Meaningful only with the Olivero theme and the Alerts recipe's `alerts` View present.
- Parent (severity colors) is documented at
  [../../../../agent/start.md](../../../../agent/start.md).
