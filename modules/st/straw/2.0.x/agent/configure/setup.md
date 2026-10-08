<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a field to use Straw

Straw needs **two** settings on an existing entity-reference field that targets **taxonomy
terms**. There is no global config.

## Step 1 — field reference method (field settings)

Set the field's reference method / selection handler to **Straw selection** (plugin id
`straw`). In config this is on the `field.field.*` entity:

```yaml
settings:
  handler: 'straw'
  handler_settings:
    target_bundles: { my_vocab: my_vocab }
    auto_create: true        # optional: enables the ">>" new-term creation
```

## Step 2 — form widget (Manage form display)

On the bundle's *Manage form display*, set the field's widget to **Autocomplete (Straw
style)** — widget id `super_term_reference_autocomplete_widget`:

```yaml
content:
  field_topics:
    type: super_term_reference_autocomplete_widget
    settings: { match_operator: CONTAINS, size: 60, placeholder: '' }
```

Both must be in place: the `straw` handler feeds hierarchy-aware matches; the widget renders
them with the `>>` ancestry.

## Behaviour once configured

- Existing values display as the full path, e.g. `Travel >> Europe >> France`.
- Autocomplete searches the **whole hierarchy**, so same-named leaves are disambiguated by
  their parents.
- If the field allows term creation (`auto_create` / "Create referenced entities if they don't
  already exist"), typing `Parent >> Child` creates every missing term in the path, each
  parented to the previous one. Existing ancestors are reused, not duplicated.

## Scripted setup (drush php:eval)

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_topics');
$fc->setSetting('handler', 'straw')->save();

$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_topics', ['type' => 'super_term_reference_autocomplete_widget'])->save();
```

Read back: `drush cget field.field.node.article.field_topics settings.handler` and
`drush cget core.entity_form_display.node.article.default content.field_topics.type`.
