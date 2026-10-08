<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Retain (ignore) config during distribution imports

## The settings config

Config object: **`config_distro_ignore.settings`** (has schema). Three sequences:

```yaml
all_collections: []       # config names ignored in EVERY collection
default_collection: []    # config names ignored in the default collection
custom_collections: []    # config names ignored per non-default collection (nested by collection parts)
```

Default (install) values are all empty. Each entry is a config name that may use **shell
wildcards** (`*`, `?`) and an optional **`::<md5-hash>`** suffix (`HASH_SEPARATOR = '::'`) so the
item is ignored **only while** its data hashes to that value (`md5(serialize($data))`); with no
suffix it is ignored unconditionally.

Read / edit it:

```bash
drush cget config_distro_ignore.settings
```

```php
$cfg = \Drupal::configFactory()->getEditable('config_distro_ignore.settings');
$list = $cfg->get('all_collections');       // e.g. ['system.site', 'views.view.*']
$list[] = 'field.field.node.article.body';
$cfg->set('all_collections', array_values(array_unique($list)))->save();
```

## The filter plugin

`DistroIgnoreFilter` — `@ConfigFilter` id `config_distro_ignore`, `weight = 10000`,
`storages = {"config_distro.storage.distro"}`. It runs when the distribution storage is built
(through the **config_distro_filter** bridge, which is why this module depends on it).

For a config name matched by the ignore lists:
- `filterRead()` / `filterReadMultiple()` return the **active** storage's value (so the site
  keeps its version rather than the distribution's),
- `filterExists()` / `filterListAll()` keep ignored items visible.

Matching: `all_collections` matches unconditionally; per-collection lists use `shouldIgnore()`
(wildcards → regex) and, if a `::hash` is present, only ignore while `md5(serialize($data))`
equals that hash.

## The UI

| Route | Path | Purpose |
|---|---|---|
| `config_distro_ignore.settings` (the `configure` route) | `/admin/config/development/configuration/distro/ignore` | `SettingsForm` — manage the ignore lists. |
| `config_distro_ignore.add_item` | `/admin/config/development/configuration/distro/ignore/add/{config_name}/{collection}` | `AddIgnoredConfigForm` — add one item to the ignore list. |

Both require the parent permission **`synchronize distro configuration`**. The module also adds a
**"Retain configuration"** operation link to every row on Config Distro's import form
(`config_distro_import_form`) via `hook_form_FORM_ID_alter()`, linking to `add_item`.

## Notes

- This module has **no** permission of its own — it reuses `config_distro`'s
  `synchronize distro configuration`.
- Requires `config_distro_filter` to be enabled; without the bridge the filter is registered but
  never applied to the distro storage.
- Ignoring is one-directional: it keeps the **active** value, effectively dropping the
  distribution's proposed change for that item.
