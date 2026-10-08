<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cision Total Mentions block

`Drupal\cision\Plugin\Block\CisionTotalMentionsBlock` in
`src/Plugin/Block/CisionTotalMentionsBlock.php`. Attribute-defined:

```php
#[Block(
  id: 'cision_cision_total_mentions',
  admin_label: 'Cision Total Mentions',
  category: 'Cision',
)]
```

Implements `ContainerFactoryPluginInterface`; injects the `cision.api` service. Place it via Block layout
or Layout Builder.

## Block configuration (`blockForm` / `blockSubmit`)
Config keys (schema `block.settings.cision_cision_total_mentions`):
- `sid` — the Cision search id; a `select` whose options come from `Api::getSearchesOptions()`.
- `start_date`, `end_date` — free-text, any `strtotime()`-parseable string (default `last year` / `now`);
  validated in `blockValidate()`.
- `max_results` — integer cap (default 8).
- `remove_duplicates` — checkbox; drops later mentions with a duplicate lowercased title.
- `image_style` — an existing image style machine name (options from `ImageStyle::loadMultiple()`).
- `placeholder_image` — a `managed_file` upload (png/jpg/jpeg) under `public://cision_placeholder_images`;
  marked permanent on submit. Its default is derived from the `cision.settings:placeholder_image_id`
  Media entity's `field_media_image`.

## Rendering (`build()`)
1. Calls `Api::getTotalMentions($sid, strtotime(start), strtotime(end), 0, round(max_results * 1.3))`
   (over-fetches to survive filtering). Returns `[]` if not an array.
2. Filters mentions to those whose `url` passes `FILTER_VALIDATE_URL` and starts with `https`.
3. Optional duplicate-title removal.
4. Builds a new `embed/embed` `Embed(new Crawler(new CurlClient()))` (timeout 10s) and calls
   `getMulti(...$urls)` to discover metadata (image, language) for each mention URL; on exception the
   list is emptied.
5. Derives an `imageURL` from the discovered image host/path (only kept if it ends `.jpg/.jpeg/.png`),
   trims to `max_results`, and loads the placeholder file uri.
6. Returns a render array `#theme => 'cision_item_list'` with `#items` (each: `mediaType`, `lang`,
   `title`, `date`, `url`, `imageURL`), `#image_style`, `#placeholder_image`, cache `max-age = 3600`,
   and attached library `cision/cision`.

## Theme
Hook `cision_item_list` (declared in `cision.module` `cision_theme()`), template
`templates/cision-item-list.html.twig`. Each item renders an anchor card (`target="_blank"`) with the
thumbnail (through `imagecache_external` for remote urls or `image_style` for the placeholder), media
type, date, and a `truncate(100)` title. All fields render through Twig auto-escaping.
