<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The dashboard entity + module settings

## The `dashboard` config entity

Config entity type `dashboard` (class `Drupal\dashboards\Entity\Dashboard`), stored as
`dashboards.dashboard.<id>`. It is a Layout Builder section list (`SectionListInterface`).

Exported fields (`config_export`):

| Field | Meaning |
|---|---|
| `id` | Machine name. |
| `admin_label` | Human label (entity key `label`). |
| `category` | Grouping/category string. |
| `sections` | Layout Builder `Section[]` (the widgets placed on the dashboard). |
| `frontend` | If TRUE, the dashboard is exposed on the front end (not only admin). Default FALSE. |
| `weight` | Ordering (entity key `weight`) — e.g. order in the toolbar tray. |

Routes (from the entity annotation):
- `entity.dashboard.collection` → `/admin/structure/dashboards` (list; the module's `configure` route).
- `entity.dashboard.add_form` → `/admin/structure/dashboards/add`.
- `entity.dashboard.edit_form` → `/admin/structure/dashboards/manage/{dashboard}`.
- `entity.dashboard.canonical` → `/dashboard/{dashboard}` (the rendered dashboard).
- `entity.dashboard.entity_permissions_form` → `.../permissions`.
- Layout Builder editor via the `layout_builder` form handler; "Personalize" (override) via a
  user-specific section storage.

## Create / read via drush php:eval

```php
$dashboard = \Drupal\dashboards\Entity\Dashboard::create([
  'id' => 'ops_overview',
  'admin_label' => 'Ops Overview',
  'category' => 'Operations',
  'weight' => 0,
  'frontend' => FALSE,
  'sections' => [],            // add Layout Builder sections/components to place widgets
]);
$dashboard->save();

$d = \Drupal::entityTypeManager()->getStorage('dashboard')->load('ops_overview');
$d->label();                   // admin_label
$d->get('category');
```

Read config: `drush cget dashboards.dashboard.ops_overview`. Placing widgets is normally done in the
Layout Builder UI (add block `dashboards_block:dashboard:<plugin_id>` into a section).

## Module settings

Config `dashboards.settings` (form route `dashboards.dashboards_settings_form` →
`/admin/system/dashboards-settings`, permission `administer dashboards`). Drives chart colors
(see the `ChartTrait`):

| Key | Default | Meaning |
|---|---|---|
| `colormap` | `summer` | Colormap name (jet, hsv, viridis, plasma, …). |
| `alpha` | `40` | Transparency percent (20–100). |
| `shades` | `15` | Number of colors in the map (min 15). |

```bash
drush cset dashboards.settings colormap viridis -y
```
