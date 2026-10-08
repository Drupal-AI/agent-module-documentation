<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the field

There is **no admin settings page** (`configure` = null). All configuration is per field
instance and per display, on the bundle's *Manage fields* / *Manage form display* /
*Manage display* pages.

## 1. Add the field

Add a field of type **Field Token Value** to any fieldable bundle (node, user, term, media…).
Storage columns: a single `value` (`text`, big). The field type id is `field_token_value`.

## 2. Field instance settings (the important part)

On the field's settings form (`FieldTokenValueItem::fieldSettingsForm`):

| Setting | Key | Meaning |
|---|---|---|
| Field value | `field_value` | The token string, e.g. `[node:title] — [node:changed]`. Max 1024 chars. A **Token browser** (`token_tree_link`) is shown for the entity's token type. Validated with `token_element_validate`. |
| Remove empty tokens | `remove_empty` | If on (default), unresolved tokens are cleared from the output (`Token::replace(..., ['clear' => TRUE])`). If off, unresolved token markers remain. |

Stored in config at `field.field.<entity>.<bundle>.<field>.settings.field_value` /
`.settings.remove_empty`. Field storage default value lives under `field.value.field_token_value`.

The **widget** (`field_token_value_default`) renders the value as a **hidden** form element — editors
never type it; it exists only to ensure the presave runs. So the value appears only *after* save.

## 3. Formatter settings (Manage display)

Formatter `field_token_value_text` (`FieldTokenValueTextFormatter`):

| Setting | Key | Meaning |
|---|---|---|
| Wrapper | `wrapper` | HTML wrapper to render the value in (from the wrapper list — `p`, `div`, `span`, `h1`–`h6`, `blockquote`, `strong`, `em`, `pre`, `section`, `small`, `sub`, `sup`, `s`, `i`, `no_tag`, …). Empty = paragraph `<p>` default. See [plugins/wrappers.md](../plugins/wrappers.md). |
| Link field value to entity | `link` | Wrap the output in a link to the entity's canonical URL (skipped for new/link-less entities). |

## Drush / scripted setup

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_display_title', 'entity_type' => 'node', 'type' => 'field_token_value',
])->save();
FieldConfig::create([
  'field_name' => 'field_display_title', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Display title',
  'settings' => ['field_value' => '[node:title] ([node:nid])', 'remove_empty' => TRUE],
])->save();
```

The value is (re)generated on the next save of each entity — see [api/generator.md](../api/generator.md).
