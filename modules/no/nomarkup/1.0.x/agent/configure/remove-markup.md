<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remove markup on a field

No settings page. You enable it per field, per view mode, on the entity's **Manage display**
page, or directly in the `entity_view_display` config.

## Where the setting is stored

Config entity: `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`
Path within it:

```yaml
content:
  <field_name>:
    type: string          # any formatter
    settings: { ... }
    third_party_settings:
      nomarkup:
        enabled: true
        separator: '|'        # multi-value join, default NoMarkupInterface::DEFAULT_SEPARATOR
        referenced_entity: false
```

- `enabled` (bool) — render the field with no wrapper markup.
- `separator` (string, default `|`) — used only when the field is multi-value; joins values.
- `referenced_entity` (string/bool) — **only** offered when the formatter is
  `entity_reference_entity_view` on an `entity_reference` field; also strips the referenced
  entity's markup.

## Via the UI

1. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`),
   pick the view mode.
2. Click the gear/cog on a field's row.
3. Tick **Remove field markup** (and set a *Multi-value separator* if the field is multi-value;
   tick *Remove markup on the referenced entity* for a Rendered-entity reference formatter).
4. **Update**, then **Save**. The summary then reads "The field will render without markup."

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_body');                     // existing formatter component
$c['third_party_settings']['nomarkup']['enabled'] = TRUE;
$c['third_party_settings']['nomarkup']['separator'] = ', ';
$vd->setComponent('field_body', $c)->save();
```

Turn it off by setting `enabled` to `FALSE` (or unsetting the `nomarkup` key) and saving.

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_body
# look for third_party_settings.nomarkup.enabled: true
```

## Config schema

`field.formatter.third_party.nomarkup` — `enabled` (bool), `separator` (string),
`referenced_entity` (string), validated as part of the display config.
