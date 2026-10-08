# Switch a reference field to an "unpublished" handler

There is no settings page. You configure this per entity-reference field by choosing its
selection handler (the "Reference method").

## Handler ids

| Handler id | Target entity type | UI label |
|---|---|---|
| `unpublished` | node | "Unpublished Default" |
| `unpublished_media` | media | "Unpublished Media" |
| `unpublished_taxonomy_term` | taxonomy_term | "Unpublished Taxonomy term" |

## In the UI

1. Edit the entity-reference field (its field settings / *Manage fields* → field edit form).
2. Under **Reference type → Reference method**, select the matching "Unpublished …" option.
3. Optionally set the allowed bundles (the field is relabelled "Content types" / "Media
   types" / "Vocabularies").
4. Save. Unpublished entities of the chosen bundles now appear in the field's
   autocomplete/select.

## In field configuration / code

The choice is stored on the **field config** (`field.field.<entity>.<bundle>.<field>`) under
`settings.handler`:

```yaml
# field.field.node.article.field_related:
settings:
  handler: unpublished          # was e.g. 'default:node'
  handler_settings:
    target_bundles: { article: article }
```

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_related');
$field->setSetting('handler', 'unpublished')->save();
echo $field->getSetting('handler'); // 'unpublished'
```

The field **storage**'s `target_type` (node / media / taxonomy_term) must match the handler's
entity type. No other configuration is needed — the handler simply omits the published-only
condition that core's default handlers add.
