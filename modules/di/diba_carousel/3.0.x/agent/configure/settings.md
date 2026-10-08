<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: block settings

There is **no module settings form and no `configure` route**. All configuration is per block
instance, stored in the block config entity under `settings:` and validated by the config schema
`block.settings.diba_carousel` (`config/schema/diba_carousel.schema.yml`). Set it through the
block-layout UI, or by editing the block config entity directly with drush/PHP.

## Settings keys (defaults from `defaultConfiguration()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `entity_selected` | string | `node` | Fieldable content-entity type id to source slides from. |
| `content_types` | sequence(string) | `[]` | Bundle ids to include; empty = all bundles. |
| `publishing_options` | sequence(string) | `['status' => 1]` | Boolean fields required = 1: `status`, `promote`, `sticky`, plus `custom_pub` option ids (nodes). |
| `skip_content_without_image` | bool | `false` | Require the image field to be non-null. |
| `image` | string | `field_image` | Image field machine name (type `image`). |
| `image_multi_strategy` | string | `first` | Multivalue image handling: `first` / `last` / `rand` / `all` (all = one slide per image). |
| `image_style` | string | `''` | Image style id; empty = original file. |
| `title` | string | `title` | Title field (type `string`). Output is `strip_tags()`-ed. |
| `url` | string | `canonical` | Title link: `canonical`, `image_file`, a link-field name, or empty. |
| `url_image` | string | `''` | Image link: same option set as `url`. |
| `description` | string | `body` | Description field (`text`, `text_long`, `text_with_summary`, `string`, `string_long`, `entity_reference`). |
| `description_allow_html` | bool | `false` | If off, description is `strip_tags()`-ed; if on, HTML is preserved (see note). |
| `description_see_more_link` | bool | `false` | Append a "See more" link to the entity canonical. |
| `description_truncate` | int | `300` | Max characters (word-boundary truncate); `0` = unlimited. |
| `order_field` | string | `created` | Sort field (`integer`, `created`, `changed`, `datetime`, `string`). |
| `order_direction` | string | `DESC` | `ASC` / `DESC` / `RANDOM`. |
| `limit` | int | `5` | Max entities queried. |
| `filter_by_field` | string | `''` | One field to filter on; empty = no filter. |
| `filter_by_field_operator` | string | `=` | `=`,`<>`,`CONTAINS`,`>`,`>=`,`<`,`<=`, or date ops `date_g/ge/l/le`. |
| `filter_by_field_value` | string | `''` | Filter value; supports `[query:arg]` and `[argument:N]` request tokens. |
| `carousel_style` | string | `default` | `default` (Bootstrap) or `diba` (left captions; attaches the CSS library). |
| `show_indicators` | bool | `true` | Show carousel indicator dots (only if >1 slide). |
| `show_controls` | bool | `true` | Show prev/next controls (only if >1 slide). |
| `more_link` | url | `''` | Optional URL for a "more" link under the carousel. |
| `more_link_text` | string | `See more` | Text for `more_link`. |
| `items_by_slide` | int | `1` | Columns per slide: `1,2,3,4,6,12` (uses `col-sm-{12/n}`). |
| `data_interval` | int | `5000` | Autoplay delay in ms; `0` disables autocycling. |
| `image_class` | string | `img-fluid` | Class on `<img>`. |
| `wrapper_class` | string | `''` | Class on the outer block wrapper. |
| `row_class` | string | `''` | Class on the `.row` (multi-column slides). |
| `col_class` | string | `''` | Class on each `.col`. |
| `title_class` | string | `''` | Class on the caption `<h2>`. |
| `description_class` | string | `''` | Class on the caption description `<div>`. |

`label_display` defaults to `false` (standard block key).

## Note on `description_allow_html`
Default is **off**, which strips tags from the description. When you turn it on, the description
field's raw stored value is preserved and truncation tries to re-close open tags
(`Html::normalize`). Only enable it for content whose editors you already trust with unfiltered
HTML.

## Set via drush / PHP
The block instance is a `block` config entity (id chosen when you place it, e.g.
`block.block.<theme>_dibacarousel`). Inspect and edit its `settings`:

```bash
drush config:get block.block.MY_BLOCK_ID settings
```

```php
$block = \Drupal::entityTypeManager()->getStorage('block')->load('MY_BLOCK_ID');
$settings = $block->get('settings');
$settings['entity_selected'] = 'node';
$settings['content_types']   = ['article' => 'article'];
$settings['image']           = 'field_image';
$settings['image_style']     = 'large';
$settings['title']           = 'title';
$settings['description']     = 'body';
$settings['limit']           = 8;
$settings['order_field']     = 'created';
$settings['order_direction'] = 'DESC';
$settings['carousel_style']  = 'diba';
$block->set('settings', $settings)->save();
```

Because the whole configuration lives in the block entity, a placed carousel exports and imports
with `drush cex` / `drush cim` like any other block.
