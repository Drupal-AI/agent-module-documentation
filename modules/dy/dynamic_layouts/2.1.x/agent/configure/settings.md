# Global settings

Before any layout can be added, Dynamic Layouts needs its **global settings** saved once. These live
on a singleton config entity `dynamic_layout_settings` with fixed id `settings`
(`config/install/dynamic_layouts.dynamic_layout_settings.settings.yml` ships it empty).

- Route: `dynamic_layout.dynamic_layout_settings` → `/admin/config/dynamic-layouts/settings`
  (form `\Drupal\dynamic_layouts\Form\SettingsForm`, form id `dynamic_layouts_settings_form`).
- Permission: `admin dynamic layouts`.
- On install a status message links here; the layout list shows a warning until a frontend library is chosen.

## Fields (SettingsForm)

| Field (`#name`) | Type | Notes |
|---|---|---|
| `frontend_library` | select, required | `bootstrap` (Bootstrap v4) or `custom`. |
| `column_prefix` | textfield | Only for `custom`. The CSS width-class prefix; a `-` is appended (Bootstrap uses `col`). Forced to `col` when library = bootstrap. |
| `grid_column_count` | select | Only for `custom`. `6`, `8`, or `12`. Forced to `12` for bootstrap. |

Changing frontend library, prefix, or grid count **purges all configured column-width numbers on every
existing layout** (`DynamicLayoutSettings::purgeColumnWidthNumbers()`), so reconfigure column widths after.

## Storage / schema

The three values are stored **serialized** inside a single `settings` text field, not as separate keys.
Schema (`config/schema/dynamic_layouts.schema.yml`, type `dynamic_layouts.dynamic_layout_settings.*`):

```yaml
mapping:
  id: {type: string}
  label: {type: label}
  settings: {type: text}   # PHP serialize() of {frontend_library, column_prefix, grid_column_count}
```

`config_export` keys on the entity: `id`, `label`, `settings`.

## Read / set from PHP

Prefer the entity accessor methods (they own the serialize/unserialize):

```php
/** @var \Drupal\dynamic_layouts\DynamicLayoutSettingsInterface $s */
$s = \Drupal::entityTypeManager()->getStorage('dynamic_layout_settings')->load('settings');
$s->getFrontendLibrary();      // 'bootstrap' | 'custom' | NULL
$s->getColumnPrefix();         // e.g. 'col'
$s->getGridColumnCount();      // e.g. '12'
$s->getFrontendColumnClasses();// [1=>1,2=>2,...] width options for the column modal
$s->setFrontendLibrary('custom');
$s->setColumnPrefix('col');
$s->setGridColumnCount('12');
$s->save();
```

`unserialize()` is called with `['allowed_classes' => FALSE]`, so the field only ever yields scalars/arrays.

## Requirements check

`hook_requirements()` (runtime) warns if library = `bootstrap` but the contrib `bootstrap_library`
module (v4.x) is not installed — the layout will not render its grid classes on the front end otherwise.
`bootstrap_library` is an optional runtime aid, not a declared dependency.
