# Referencing config terms from a field

The module defines **no field type, widget, or formatter**. You reference config terms with a core
`entity_reference` field whose `target_type` is `config_terms_term`, and the module supplies the
selection handler that scopes options to a chosen vocabulary.

## Selection plugin

`Drupal\config_terms\Plugin\EntityReferenceSelection\TermSelection`
(`@EntityReferenceSelection` id `default:config_terms_term`, `entity_types = {"config_terms_term"}`,
group `default`), extending core `DefaultSelection`.

- Adds a required **`target_vocab`** radios setting (the vocabulary machine name) to the field's
  reference-selection form; options come from `VocabStorage::getVocabsList()`.
- Config terms have **no `bundle` entity key**, so `target_bundles` does not apply; the handler
  overrides `buildEntityQuery()` to filter by `vid == target_vocab` (and forces an empty result with
  `condition('vid', '-')` when unset). Queries run with `accessCheck(TRUE)` and are tagged
  `config_terms_term_access` + `entity_reference`.
- `getReferenceableEntities()` with no match/limit returns `['config_terms_term' => TermStorage::getTermOptions($vid)]`
  (depth-dashed labels); the autocomplete (match) path uses the access-checked query.

Selection-handler schema key: `entity_reference_selection.default:config_terms_term`
(`target_vocab`, `target_bundles` nullable, `auto_create`).

## Create such a field with drush/PHP

```php
// Field storage: an entity_reference targeting config_terms_term.
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_category',
  'entity_type' => 'node',
  'type' => 'entity_reference',
  'settings' => ['target_type' => 'config_terms_term'],
])->save();

// Field instance: use the module's selection handler, pinned to one vocabulary.
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_category',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Category',
  'settings' => [
    'handler' => 'default:config_terms_term',
    'handler_settings' => ['target_vocab' => 'document_type'],
  ],
])->save();
```

Use core's autocomplete or options widgets and the core entity-reference formatter to display them.
For listing/filtering these references in Views, enable `config_terms_views` (see views/filter.md).

> Note: the config schema also declares `field.formatter.settings.entity_reference_rss_category`, but
> no formatter plugin ships in 2.0.0 — it is a schema remnant, not a usable formatter.
