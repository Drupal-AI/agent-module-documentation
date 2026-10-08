# Configure: choosing Iconify collections

**Route:** `iconify_icons.settings` → `/admin/config/iconify_icons/settings`
**Access:** core permission `administer site configuration`
**Form:** `Drupal\iconify_icons\Form\Settings` (form id `iconify_icons_settings`, extends `ConfigFormBase`)
**Config object:** `iconify_icons.settings`

## What the form does

On build it calls `IconifyApi::getCollections()` (fetched from the Iconify API, cached — see
[api/services.md](../api/services.md)) and renders every collection as a selectable **card**,
grouped into collapsible `details` per Iconify category, plus a client-side text/category filter
(JS behavior `IconifyIconsWidgetCollectionsFilter`, library `iconify_icons/default`). Each card
shows up to 6 sample icons (loaded as `<img>` from the API), the icon count, and a license note.
If the API is unreachable the form shows a warning and lists nothing (the service swallows its own
exceptions and returns `[]`).

On submit (`submitForm()`) it collects the checked collection ids from every category group into a
flat list and stores it, then clears the field-type plugin cache and runs
`drupal_flush_all_caches()` (so the generated icon packs are rebuilt).

## The stored config

Single key: **`collections`** — an array keyed by collection id, value = collection id
(e.g. `{ mdi: mdi, 'fa-solid': 'fa-solid' }`). Consumed by `hook_icon_pack_alter()` to generate
icon packs (see [plugins/icon-extractor.md](../plugins/icon-extractor.md)).

There is **no `config/schema`** shipped for this key, and no default `config/install` file.

## Set it without the UI

Drush:

```bash
drush config:set iconify_icons.settings collections.mdi mdi -y
drush config:set iconify_icons.settings 'collections.fa-solid' fa-solid -y
drush cr   # rebuild so the generated icon packs pick up the change
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('iconify_icons.settings')
  ->set('collections', ['mdi' => 'mdi', 'fa-solid' => 'fa-solid'])
  ->save();
drupal_flush_all_caches();
```

Collection ids are the Iconify prefixes listed at <https://icon-sets.iconify.design/>.
