<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Switch a link field to "Link with target"

The module has **no configure route** (`configure: null`) and no global settings page.
Everything happens on the link field's own *Manage form display*, or directly in the
`entity_form_display` config.

## 1. Select the widget

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`

```yaml
content:
  <field_name>:
    type: link_target_field_widget   # instead of core's link_default
    settings:
      placeholder_url: ''
      placeholder_title: ''
      available_targets: {}          # empty/false-y => all four targets offered
```

Via the UI: go to the bundle's *Manage form display* (e.g.
`/admin/structure/types/manage/<bundle>/form-display`), change the link field's widget to
**Link with target**, then **Update** and **Save**.

## 2. Restrict which targets are offered (widget setting)

Click the gear/cog on the field's row to open `available_targets`, a checkboxes list with the
four hard-coded options the plugin defines
(`Drupal\link_target\Plugin\Field\FieldWidget\LinkTargetFieldWidget::getTargets()`):

| Key | Label |
|---|---|
| `_self` | Current window (`_self`) |
| `_blank` | New window (`_blank`) |
| `parent` | Parent window (`_parent`) |
| `top` | Topmost window (`_top`) |

Tick a subset to limit the per-item dropdown to those; leave all unchecked to offer all four
(the widget's `getSelectedOptions(TRUE)` falls back to every target when none are selected).
This is stored as an ordinary **widget setting** (not a third-party setting) —
`content.<field>.settings.available_targets` — validated by the module's own schema
(`field.widget.settings.link_target_field_widget`, extending
`field.widget.settings.link_default`).

Via `drush php:eval`:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_example_url', [
  'type' => 'link_target_field_widget',
  'settings' => ['placeholder_url' => '', 'placeholder_title' => '', 'available_targets' => ['_blank' => '_blank']],
])->save();
```

Read it back:

```bash
drush cget core.entity_form_display.node.article.default content.field_example_url
# look for settings.type == link_target_field_widget and settings.settings.available_targets
```

## 3. The per-link target editors actually pick

This is **not config** — it lives on the entity as field data. Once the widget is active,
each link item's edit row gets a "Select a target" `<select>` populated from the allowed
targets (plus "- None -"). Whatever an editor picks is saved into that link value's
`options.attributes.target`, alongside the URL and title, in the field's own storage — the
same `options` array core's Link field type already uses for attributes. There is nothing
extra to read back in config; inspect the entity's field value directly, e.g.:

```php
$item = $node->get('field_example_url')->first();
$target = $item->options['attributes']['target'] ?? NULL;
```

## Caveat baked into the code

The plugin's own target keys are `_self`, `_blank`, `parent`, `top` — note `parent` and `top`
are **not** prefixed with an underscore even though the labels say "(`_parent`)"/"(`_top`)".
Whatever key is checked is written verbatim into `options.attributes.target`, so a link saved
with `parent` produces `target="parent"`, not the HTML-standard `target="_parent"`. Only
`_self` and `_blank` round-trip to valid HTML5 target keywords as shipped.
