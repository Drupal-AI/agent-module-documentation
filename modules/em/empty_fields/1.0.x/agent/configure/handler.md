<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set empty-value behavior on a field

No configure route. You choose the behavior on a field's formatter, per view mode, on *Manage
display* (or directly in the `entity_view_display` config).

## Where it is stored

`hook_field_formatter_third_party_settings_form()` adds an **"Empty value behavior"** select to
each field's formatter settings. The choice is stored on the field's display component:

```
core.entity_view_display.<entity_type>.<bundle>.<view_mode>
  content.<field>.third_party_settings.empty_fields:
    handler: text            # the EmptyField plugin id ('' = default/none)
    settings:                # plugin-specific settings (schema: empty_fields.settings.<handler>)
      empty_text: 'N/A'      # e.g. for the 'text' handler
```

Shipped handler plugin ids:

| Handler | Behavior | Settings |
|---|---|---|
| `nbsp` | Renders a non-breaking space (`&nbsp;`). | none |
| `text` | Renders custom text run through the token system (`\Drupal::token()->replace`, tokens for the entity type + `user`). | `empty_text` (textarea) |
| `broken` | Hidden fallback used when a saved handler no longer exists; not selectable. | — |

`handler` is `''` (the "- Default -" option) when empty-field replacement is off for that field.

## Via the UI

1. Bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. Open a field's format settings (the cog).
3. Set **Empty value behavior** to e.g. "Display custom text", fill **Display Custom Text**, then
   Update + Save.

## Via drush php:eval

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_subtitle');
$c['third_party_settings']['empty_fields']['handler'] = 'text';
$c['third_party_settings']['empty_fields']['settings'] = ['empty_text' => 'No subtitle'];
$vd->setComponent('field_subtitle', $c)->save();
```

For the `nbsp` handler just set `handler => 'nbsp'` with no `settings`.

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_subtitle.third_party_settings
```

## How it renders

`hook_entity_display_build_alter()` iterates the built fields; for any field that
`isEmpty()`, is view-accessible, and whose formatter has an `empty_fields.handler`, it
instantiates the plugin with the saved `settings` and replaces the field build with the plugin's
`react()` output (themed as a normal `field` so the label/wrapper still render). Only empty
fields are affected; fields with a value render normally.
