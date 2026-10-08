<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Page Title Block (advanced_title_block) — agent index

A single **block plugin** that renders the current page/node title as a hero header with a background
color, background image and subtitle text. Values are either fixed per block instance or pulled from
the current node's fields. Depends on core **`block`** and **`image`**. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Version 1.0.8.

- **The block plugin, its settings form, config objects, and how the header is built** →
  [blocks/advanced-title-block.md](blocks/advanced-title-block.md)

## What it actually is

- One block plugin: `AdvancedTitleBlock` (id **`advanced_title_block`**, admin label *"Advanced Page
  Title Block"*), in `src/Plugin/Block/AdvancedTitleBlock.php`, extending `BlockBase`. Placed and
  configured through the normal block UI (`administer blocks`).
- One settings form: `AdvancedTitleBlockForm` (`src/Form/AdvancedTitleBlockForm.php`,
  `ConfigFormBase`) at route **`advanced_title_block.settings`**
  (`/admin/config/user-interface/advanced-title-block`, permission **`administer site
  configuration`**), menu link under *Configuration → User interface*. It edits one field
  (`available_colors`) in config object **`advanced_title_block.settings`**.
- One theme hook `advanced_title_block` (`advanced_title_block.module` → `hook_theme()`), template
  `templates/advanced-title-block.html.twig`, CSS library `advanced_title_block/global`.
- **No permissions of its own, no Drush, no submodules, no services.** Config schema exists for both
  the block instance settings and the site settings (`config/schema/advanced_title_block.schema.yml`).

## Mechanism (from source)

- `blockForm()` builds the per-instance config: `text` (subtitle textarea), `color` (select whose
  options come from `available_colors`), a `background` details group with a `managed_file` `image`
  (jpg/png/jpeg, uploaded to `public://background/`) and a `title` (alt text), plus `entity_image`
  and `entity_text` selects populated by `getFields()` — which loads `field_storage_config` entities
  of the matching field types on the `node` entity type.
- `build()` resolves, in order: the background image URI (node image field → media `field_media_image`
  → fixed uploaded file), the subtitle text (node field → fixed `text`), and the title (node title on
  node routes, else `title_resolver->getTitle()`), then renders `#theme => 'advanced_title_block'`
  with `#title`, `#text`, `#color`, `#image` (a generated file URL) and `#image_title`.
- Cache contexts `url.path` + `url.query_args` (per-URL); no cache tags for the referenced node.

## Config objects

- `block.settings.advanced_title_block` (per-instance): `text`, `color`, `background.image`,
  `background.title`, `entity_image`, `entity_text`.
- `advanced_title_block.settings` (site): `advanced_title_block.available_colors` — a `;`-separated
  HEX list (default `#000000;#222222;#444444;#eeeeee;#ffffff`).

## Notes / caveats

- `build()` references `TranslatableMarkup` without a `use` import (`src/Plugin/Block/...` line ~293);
  that branch only runs for a non-node route whose title is a `TranslatableMarkup`, where it would
  error — a latent bug, not a security issue.
- The settings form's `validateForm()` is an empty `@todo`; `available_colors` is stored verbatim.
- `README.md` says "provides no configuration options" — outdated; the settings form and the
  block form both configure it.
