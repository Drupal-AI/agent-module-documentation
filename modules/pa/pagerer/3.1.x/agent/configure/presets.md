<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Pagerer: presets, overrides, URL, Views

Config UI: `/admin/config/user-interface/pagerer` (route `entity.pagerer_preset.collection`,
permission `administer site configuration`). All state is config, so it is exportable.

## Presets (`pagerer_preset` config entities)

- Config name: `pagerer.preset.<id>` (config_prefix `preset`, entity type id `pagerer_preset`).
- Exported keys: `id`, `label`, `panes`.
- `panes` is a map of three panes:

```yaml
panes:
  left:   { style: none, config: {} }
  center: { style: standard, config: {} }   # a fresh preset defaults to this
  right:  { style: none, config: {} }
```

Each pane's `style` is a style plugin id (`standard`, `basic`, `progressive`, `adaptive`,
`multipane`) or `none` (empty pane). `config` overrides that style's defaults (from
`pagerer.style.<id>` → `default_config`); on save, `PagererPreset::preSave()` validates each
pane's config against `pagerer.style_config.<style>` and drops keys not in the schema.

### Create a preset (drush php:eval)

```php
$storage = \Drupal::entityTypeManager()->getStorage('pagerer_preset');
$preset = $storage->create(['id' => 'my_pager', 'label' => 'My pager']);
$preset->set('panes', [
  'left'   => ['style' => 'none', 'config' => []],
  'center' => ['style' => 'progressive', 'config' => []],
  'right'  => ['style' => 'basic', 'config' => []],
]);
$preset->save();
```

In the UI: *Add pager* → name it → on the edit form pick a style for the left/center/right
panes; each pane has an "action" button to configure that style's options
(quantity, display mode pages/items/item_ranges, labels, separators, first/prev/next/last links).

## Replace the core pager site-wide

`pagerer.settings:core_override_preset` (default `core` = no override). Set it to a preset id to
render every core pager with that preset:

```bash
drush cset pagerer.settings core_override_preset my_pager -y
```

`pagerer_element_info_alter()` then swaps the `pager` element's `#theme` to `pagerer` using that
preset. Set it back to `core` to restore the default pager.

## URL querystring settings

Route `pagerer.url_settings` (`/admin/config/user-interface/pagerer/url_settings`), config
`pagerer.settings:url_querystring`:

| Key | Meaning | Default |
|---|---|---|
| `core_override` | Replace core's `page` query key with Pagerer's | `FALSE` |
| `querystring_key` | The replacement key (e.g. `pg`) | `pg` |
| `index_base` | Page number base in URLs: `0` or `1` (one-based) | `0` |
| `encode_method` | Querystring encoding method | `none` |

Example — turn `?page=0` into `?pg=1`:

```bash
drush cset pagerer.settings url_querystring.core_override 1 -y
drush cset pagerer.settings url_querystring.index_base 1 -y
drush cset pagerer.settings url_querystring.querystring_key pg -y
```

## Use a preset as a Views pager

In a View's *Pager* settings choose **"Paged output, Pagerer"** (Views pager plugin id
`pagerer`), then select the preset to use. This lets one view use a Pagerer preset independent
of the site-wide core override.
