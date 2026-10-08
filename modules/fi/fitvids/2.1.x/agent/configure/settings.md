<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FitVids settings

One config object, `fitvids.settings`, edited at *Configuration → Media → FitVids*
(`/admin/config/media/fitvids`, route `fitvids.admin`, permission `administer fitvids`).

## Keys (schema `fitvids.settings`)

| key | form field | default | meaning |
|---|---|---|---|
| `selectors` | Video containers | `.node` | CSS selectors of containers whose videos become fluid |
| `custom_vendors` | Additional video providers | `https://youtu.be` | extra iframe `src` prefixes to treat as videos |
| `ignore_selectors` | Ignore these videos | `` (empty) | selectors whose videos are left untouched |

Each value is **newline-separated** (one selector / provider per line). At page-attach time
`fitvids_page_attachments()` converts them to comma-joined JS strings; a custom vendor line
`https://vimeo.com` becomes the selector `iframe[src^="https://vimeo.com"]` (the built-in
`iframe[src^="https://youtu.be"]` is always included).

## Read / set with drush

```bash
drush cget fitvids.settings
drush cset fitvids.settings selectors '.content' -y
drush cset fitvids.settings custom_vendors "https://youtu.be
https://vimeo.com" -y
drush cset fitvids.settings ignore_selectors '.slick-slider' -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('fitvids.settings')
  ->set('selectors', ".content")
  ->set('custom_vendors', "https://youtu.be\nhttps://vimeo.com")
  ->set('ignore_selectors', ".slick-slider")
  ->save();
```

## Runtime

The three settings are pushed to `drupalSettings.fitvids.{selectors,custom_vendors,
ignore_selectors}` and consumed by `js/init-fitvids.js`, which calls FitVids.js on the
matched containers. The library JS is loaded from `/libraries/fitvids/jquery.fitvids.js`
(place the FitVids.js file there). Libraries: `fitvids/fitvids` (the plugin) and
`fitvids/init` (init + core/jquery, core/drupal, core/drupalSettings).

## Permission

`administer fitvids` — gates the settings form (title/description "Administer the FitVids
module"). No other permissions.
