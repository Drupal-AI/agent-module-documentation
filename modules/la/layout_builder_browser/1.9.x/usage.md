<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Browser replaces Layout Builder's "Choose a block" list with a curated, searchable browser in which a site builder decides exactly which blocks editors may place, grouped into named categories with optional preview images.

---

The module takes over core's `layout_builder.choose_block` route: a route subscriber (priority `-110`, so it wins over other modules) repoints the controller at `BrowserController::browse`. That controller only builds the custom browser when the current section storage plugin id is listed in `layout_builder_browser.settings:enabled_section_storages` (shipped default: `overrides`); otherwise it delegates straight back to core's `ChooseBlockController`, so the takeover is opt-in per storage type. The curated list is made of two config entity types: `layout_builder_browser_blockcat` (a category — label, weight, `opened`, optional `image_path`/`image_alt`) and `layout_builder_browser_block` (one allowed block — `block_id` referencing a block plugin id, `category`, `label`, `weight`, and its own optional preview image). Only entities with `status: true` are shown, categories are sorted by weight, and a category with no matching visible blocks is dropped entirely. A block plugin that has no `layout_builder_browser_block` entity simply never appears, which is how the module restricts choice. Beyond the explicit list, `auto_added_reusable_block_content_bundles` can append a whole `block_content` bundle as its own auto-generated "Reusable *X*" category. A `use_modal` setting swaps the off-canvas dialog for a centred modal (adding `data-dialog-type: dialog` via `hook_link_alter` and stripping the AJAX submit handler in `hook_form_alter`), and `hook_layout_builder_browser_alter()` lets other modules rewrite the finished render array. Administration lives at `/admin/config/content/layout-builder-browser` and is gated by core's `administer site configuration` — the module defines no permissions of its own.

---

- Restrict which blocks content editors can add in Layout Builder to an approved shortlist.
- Group placeable blocks into meaningful categories like "Hero", "Media", "Promotions" instead of core's provider-based list.
- Give each placeable block a thumbnail preview so editors pick layouts visually rather than by name.
- Give a whole category one shared preview image that all its blocks inherit.
- Rename a block in the chooser (e.g. show "Two-column promo" instead of "Inline block: Bp Columns").
- Control the order blocks appear in the chooser with per-block and per-category weights.
- Collapse rarely used categories by default and leave the common one open via the `opened` flag.
- Enable the curated browser only for per-entity layout overrides while leaving the default-layout screen on core's list.
- Enable it for both `defaults` and `overrides` so site builders and editors see the same curated set.
- Temporarily disable a single block in the chooser without deleting its configuration (`status: false`).
- Retire a category for a season by disabling it rather than deleting it and its blocks.
- Show the block chooser in a centred modal instead of the narrow off-canvas tray for image-heavy previews.
- Surface every reusable custom block of a given `block_content` bundle automatically as its own category.
- Keep newly created reusable blocks appearing in the browser without editing configuration each time.
- Hide low-level `field_block:*` plugins from editors while keeping them available to developers.
- Ship an editorial block palette as exported configuration so all environments offer the same choices.
- Stage a new component by adding its browser block entity only after the design is approved.
- Build a design-system component picker on top of Layout Builder + inline block types.
- Add a search-by-name filter over a long curated block list for faster placement.
- Alter the finished browser render array from a custom module with `hook_layout_builder_browser_alter()`.
- Change the browser's filter placeholder text or force categories closed from custom code.
- Audit which blocks are exposed to editors by listing the `layout_builder_browser_block` config entities.
- Point browser preview images at theme-provided screenshots (e.g. `/themes/mytheme/images/lbb/hero.jpg`).
- Curate different palettes per environment by overriding `layout_builder_browser.settings` in `settings.php`.
- Migrate a legacy pre-1.x category configuration to standalone block entities via the module's update hooks.
- Prevent editors from placing site-wide administrative blocks into content layouts.
