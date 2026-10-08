<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# asin — field type, widget, formatters, Views

All under `Drupal\asin\…`. `asin.module` is empty; Views data is in `asin.views.inc`; config schema in
`config/schema/asin.schema.yml`.

## Field type `asin` — `Plugin\Field\FieldType\AmazonField`

- `@FieldType(id="asin", default_widget="asin_text", default_formatter="asin_plain")`.
- `schema()`: single column `asin` varchar(32) NOT NULL. `propertyDefinitions()`: string property `asin`.
- `isEmpty()`: true when `asin` is null/empty.
- `defaultFieldSettings()`: `locale => 'US'`. `fieldSettingsForm()` renders a **required** `locale`
  select whose options are only Amazon locales that already have an associate ID configured
  (`amazon_pa.settings` → `amazon_locale_<L>_associate_id`, via `AmazonPaUtils::amazon_pa_data_cache()`).
- Schema `field.field_settings.asin` (mapping `locale: string`) and `field.asin.asin` (default value).

## Widget `asin_text` — `Plugin\Field\FieldWidget\AmazonFieldWidget`

- Textfield, `#size 30`, `#maxlength 15`, `#element_validate => [[$this,'validate']]`.
- Previews the stored title: `amazon_pa_item_lookup_from_db($value, $locale)` → `#markup` of `['title']`.
- `validate()`: empty → set ''. Otherwise looks the ASIN up — web
  (`amazon_pa_item_lookup_from_web`) when `update.amazon_update_on_node_edit == 1`, else cache
  (`amazon_pa_item_lookup`); if the result is empty it sets a form error *"This is not a valid Amazon ASIN"*.
  (Note: `amazon_pa_item_lookup`'s 2nd arg is `$force_lookup` (bool), but the widget passes `$locale`
  there — a pre-existing upstream arg-order quirk.)

## Formatters (`Plugin\Field\FieldFormatter\*`)

Common pattern in `viewElements()`: resolve `$locale` from field setting or
`amazon_default_locale`, `$item = amazon_pa_item_lookup(trim($asin), FALSE, $locale)[$asin]`, then a
render array `['#theme' => <hook>, '#item' => $item, '#attached' => ['library' => ['amazon_pa/amazon_pa']]]`.

| id | class | output |
|---|---|---|
| `asin_plain` | Plaintext | raw ASIN string as `#markup` |
| `asin_detailpageurl` | PageUrl | affiliate product URL |
| `asin_details` | Detail | theme `amazon_details` (inline detail block) |
| `asin_sbutton` | SButton | sales/deal badge button |
| `asin_thumbnail_small` / `_medium` / `_large` | ThumbnailSmall/Medium/Large | product thumbnail |
| `asin_thumbnail_medium_title` | ThumbnailMediumTitle | thumbnail + title |
| `asin_gallery_small` / `_medium` / `_large` | GallerySmall/Medium/Large | image gallery |
| `asin_gallery_medium_details` | GalleryMediumDetails | gallery + details |
| `asin_widget` | Widget | Amazon-style image+text widget |

All theme hooks are defined by the parent module's `amazon_pa_theme()`; product strings are XSS-filtered
in `template_preprocess_amazon_pa_item()` before rendering.

## Views (`asin.views.inc`)

- `asin_views_data()`: `amazon_item` = base table (single-column key `asin`); field/sort/filter/argument
  handlers for all product columns; `amazon_item_image` and `amazon_item_participant` declared with joins
  on `asin`; `amazon_item_image.url` uses the custom handler `views_handler_field_amazon_image`.
- `AmazonImage` (`Plugin\views\field\AmazonImage`, `@ViewsField("views_handler_field_amazon_image")`):
  overrides `ensureMyTable()` to LEFT-JOIN `amazon_item_image` filtered by the `image_size` option
  (`smallimage`/`mediumimage`/`largeimage`); options `image_size`, `link_format` (`plain`/`amazon`),
  `presentation_format` (`markup`/`plain_url`); `render()` builds a core `image` render array or the plain
  URL and, for `link_format=amazon`, wraps it in `Link::fromTextAndUrl($image, Url::fromUri($detailpageurl))`.
- `asin_field_views_data()` (`hook_field_views_data`): adds a `standard` relationship from an `asin` field
  to base `amazon_item` (base_field `asin`).

## Test

Kernel test `tests/src/Kernel/Field/AsinFormatterTest.php` covers formatter output.
