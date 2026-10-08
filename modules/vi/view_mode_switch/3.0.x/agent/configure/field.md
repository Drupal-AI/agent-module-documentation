<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure a View Mode Switch field

No admin settings page — everything is field configuration on a bundle.

## Field type & its two settings

Field type id: **`view_mode_switch`** (cardinality 1, default widget `view_mode_switch`,
default formatter `view_mode_switch_default`).

| Level | Setting | Config location | Meaning |
|---|---|---|---|
| Storage | `origin_view_modes` | `field.storage.<entity>.<field>` → `settings.origin_view_modes` (sequence) | The view mode(s) this field **takes over**. When the entity is viewed in one of these, the module switches to the editor's chosen mode. |
| Instance | `allowed_view_modes` | `field.field.<entity>.<bundle>.<field>` → `settings.allowed_view_modes` (sequence, **required**) | The view modes an editor is **allowed to switch to** on the edit form. |

Both are lists of view-mode machine names for the field's target entity type (e.g. `full`,
`teaser`). The instance's allowed view modes become field config dependencies
(`calculateDependencies()` adds each `entity_view_mode` as a config dependency).

## Add via drush php:eval

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_vms',
  'entity_type' => 'node',
  'type' => 'view_mode_switch',
  'settings' => ['origin_view_modes' => ['full']],   // takes over the 'full' view mode
])->save();

FieldConfig::create([
  'field_name' => 'field_vms',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Display as',
  'settings' => ['allowed_view_modes' => ['teaser' => 'teaser', 'full' => 'full']],
])->save();
```

Then place the widget on the form display and (optionally) a formatter on the view display:

```php
\Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default')
  ->setComponent('field_vms', ['type' => 'view_mode_switch'])->save();
```

## Widget & formatters

- Widget `view_mode_switch` — renders the editor's choice among `allowed_view_modes`.
- Formatter `view_mode_switch_default` — shows the chosen view mode's human label.
- Formatter `view_mode_switch_machine_name` — shows the chosen view mode's machine name.

## Read it back

```bash
drush cget field.storage.node.field_vms settings.origin_view_modes
drush cget field.field.node.article.field_vms settings.allowed_view_modes
```

The actual per-entity choice is stored as the field's value on each node (a view-mode machine
name); the switch happens at render time — see [api/mechanism.md](../api/mechanism.md).
