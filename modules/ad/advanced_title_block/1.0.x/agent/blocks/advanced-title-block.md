<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Advanced Page Title Block plugin

## Install & enable

```bash
composer require drupal/advanced_title_block
drush en advanced_title_block -y
```

Dependencies: core **`block`** and **`image`**. No sub-modules, no permissions of its own, no Drush.
(The `composer.json` shipped in the project is mislabeled `drupal/hero_banner`; the real package is
`drupal/advanced_title_block`.)

## Place the block

Plugin id **`advanced_title_block`**, admin label *"Advanced Page Title Block"*
(`src/Plugin/Block/AdvancedTitleBlock.php`, `@Block`). Place it like any block:
*Structure → Block layout → Place block* into a region (usually a header/hero region), or via Layout
Builder. Placement/configuration needs **`administer blocks`**.

## Per-instance settings (`blockForm()` / `blockSubmit()`)

Stored in the block config as `block.settings.advanced_title_block`:

| Key | Form element | Meaning |
|---|---|---|
| `text` | textarea (maxlength 640) | Fixed subtitle text shown under the title. |
| `color` | select, **required** | Background color; options come from the site `available_colors` list. Default `#000000`. |
| `background.image` | `managed_file` (jpg/png/jpeg) | Fixed background image, uploaded to `public://background/`. Marked permanent on save. |
| `background.title` | textfield (maxlength 640) | Background image alt text / caption. |
| `entity_image` | select | Name of a **node** `image` or `entity_reference` field to source the background from (empty = use the fixed image). |
| `entity_text` | select | Name of a **node** `text`/`text_long`/`text_with_summary`/`string`/`string_long` field to source the subtitle from (empty = use fixed `text`). |

`getFields(array $types, 'node')` builds the two selects by loading `field_storage_config` entities
(`status = 1`, `deleted = FALSE`) of the requested types on the `node` entity type — so only
node fields appear. `blockSubmit()` loads the uploaded file and calls `setPermanent()->save()`; if no
file was uploaded it logs an error to the `Advanced Title Block` logger channel.

## How `build()` renders the header

Order of resolution (`src/Plugin/Block/AdvancedTitleBlock.php::build()`):

1. **Background image URI** — if `entity_image` is set and the route has a `node`:
   - field type `image` → the referenced file's URI, alt from the field's `title`;
   - otherwise (entity_reference to media) → `entity->field_media_image->entity` file URI;
   - if the node lacks the field/value → fall back to the fixed `background.image` + `background.title`.
   Otherwise it uses the fixed uploaded image.
2. **Subtitle text** — if `entity_text` is set and the route has a `node` with that field, the field's
   first value; otherwise the fixed `text`.
3. **Title** — the node title on node routes; otherwise `title_resolver->getTitle($request, $route)`.

It returns a render array:

```php
'#theme' => 'advanced_title_block',
'#title' => $title,
'#text' => $text,
'#color' => $this->configuration['color'],
'#image' => \Drupal::service('file_url_generator')->generateString($uri),
'#image_title' => $image_title,
```

`getCacheContexts()` returns `['url.path', 'url.query_args']`. Note it adds **no cache tags for the
referenced node**, so a header sourced from a node field will not auto-invalidate when that node
changes until the per-URL cache expires.

### Template

`templates/advanced-title-block.html.twig` attaches library `advanced_title_block/global`
(`css/advanced-title-block.css`) and, when `title` is set, prints a `.advanced-page-title` wrapper with
inline `background-color` / `background-image` style, an `<h1>` title, an optional `.lead` paragraph
for `text`, and an `.img-caption` with `image_title`. All variables render through Twig's default
autoescaping. Override the template or the CSS library in your theme to restyle.

## Site settings form

Route **`advanced_title_block.settings`** → `/admin/config/user-interface/advanced-title-block`
(`AdvancedTitleBlockForm`, permission **`administer site configuration`**; menu under
*Configuration → User interface*). It edits one value:

- `advanced_title_block.available_colors` in config object **`advanced_title_block.settings`** — a
  `;`-separated list of HEX colors (default `#000000;#222222;#444444;#eeeeee;#ffffff`). Each entry
  becomes an option in the block form's `color` select.

`config/schema/advanced_title_block.schema.yml` defines schema for both
`block.settings.advanced_title_block` (the instance settings) and `advanced_title_block.settings`
(the color list).

## Operate it

- Curate the palette first at the settings form, then place the block and pick a color per instance.
- For a per-node header, choose an `entity_image` and/or `entity_text` field that exists on the
  content types where the block is shown, and leave a fixed image/text as the fallback.
- Uploaded backgrounds live under `public://background/`; the directory is prepared on form build.
