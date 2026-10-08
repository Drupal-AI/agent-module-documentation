# taxonomy_max_depth — configuration

There is **no dedicated settings page** (`configure` is null). The limit is set per vocabulary.

## Where the setting lives

`VocabularyFormAlterer` adds a **Maximum ancestor depth** select to the vocabulary add/edit form
(`taxonomy_vocabulary_form`, at *Structure → Taxonomy → {vocabulary} → Edit*):

- Options: `0 (no hierarchy)`, then `1`–`10`.
- `#empty_option` = **Unlimited**, `#empty_value` = `''` (no restriction).

On save, an `#entity_builders` callback writes the value through `VocabularySettingsWriter`:

- A chosen number → `setThirdPartySetting('taxonomy_max_depth', 'max_depth', $n)`.
- Empty / Unlimited → `unsetThirdPartySetting(...)` (removes the key entirely).

## Where it is stored

As a third-party setting on the `taxonomy_vocabulary` config entity — exported with your config:

```yaml
# taxonomy.vocabulary.tags.yml
third_party_settings:
  taxonomy_max_depth:
    max_depth: 2
```

Config schema (`config/schema/taxonomy_max_depth.schema.yml`):

```yaml
taxonomy.vocabulary.*.third_party.taxonomy_max_depth:
  type: mapping
  mapping:
    max_depth:
      type: integer
      label: 'Max ancestor depth'
```

## Set it from code / Drush

```php
$vocab = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->load('tags');
\Drupal::service('taxonomy_max_depth.vocabulary_settings_writer')
  ->setMaxAncestorDepth($vocab, 2); // pass NULL to clear (unlimited)
$vocab->save();
```

## How enforcement works

`TermFormAlterer` reads the vocabulary's `max_depth` and, if set, appends a `#validate` handler to
the term form (`taxonomy_term_form`):

- **`max_depth === 0`** → any non-empty parent triggers the error *"Terms are not allowed to have
  ancestors on this vocabulary."* (vocabulary is forced flat).
- **`max_depth >= 1`** → the validator counts the ancestor depth the term's *newly added* parents
  would give it (via `TermTreeDepthHelper::getMaxAncestorDepth()`); if it exceeds the cap it errors
  on the `parent` field. For an existing term it then loads the term's child subtree
  (`getMaxDescendantDepth()`) and errors if any descendant would be pushed past the cap by the move.

`TermOverviewFormAlterer` applies the same limit to the drag-and-drop term overview screen.

**Important:** validation is only wired into these forms. Terms saved directly via the entity API
(`$term->save()`) are **not** validated against `max_depth` — enforce it yourself if you create
terms in code.
