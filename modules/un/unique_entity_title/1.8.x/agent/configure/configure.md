# Configure — Unique Entity Title

There is **no admin settings form and no `configure` route**. Uniqueness is a per-bundle
opt-in flag stored as a `third_party_settings` value under the `unique_entity_title`
namespace, key `enabled` (boolean). Only `node` content types and `taxonomy_term`
vocabularies are supported.

## Where the setting appears (UI)

- **Content type**: edit a content type at `/admin/structure/types/manage/{type}`.
  In the "additional settings" vertical tabs there is a **"Unique entity title settings"**
  section with a checkbox **"Enable unique title for this bundle"**.
- **Vocabulary**: edit a vocabulary at `/admin/structure/taxonomy/manage/{vid}`.
  A **"Unique vocabulary name settings"** section shows a checkbox
  **"Require unique term names"**.

Saving the form writes `enabled: true|false` into the entity's third-party settings
(handled by an entity builder for node types and a submit handler for vocabularies).

## Config keys / schema

Third-party settings live on the bundle config entity, not in a dedicated settings object:

- `node.type.{type}.third_party.unique_entity_title.enabled` (boolean)
- `taxonomy.vocabulary.{vid}.third_party.unique_entity_title.enabled` (boolean)

(An empty `unique_entity_title.settings` config object also exists but holds no active keys.)

## Enable via Drush / PHP (no UI)

Set the flag on a content type:

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('article');
$type->setThirdPartySetting('unique_entity_title', 'enabled', TRUE);
$type->save();
```

Set the flag on a vocabulary:

```php
$vocab = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->load('tags');
$vocab->setThirdPartySetting('unique_entity_title', 'enabled', TRUE);
$vocab->save();
```

Run either with `drush php:eval '<code>'`. There are no Drush commands specific to
this module.

## How enforcement works

- The module attaches a `UniqueEntityTitle` constraint to the node `title` field and the
  taxonomy_term `name` field (via `hook_entity_base_field_info_alter()` and
  `hook_entity_bundle_field_info_alter()`).
- The validator only adds a violation when the entity's bundle has `enabled` set.
- Uniqueness is an entity query scoped to the same bundle; the value is `trim()`-ed and
  the current entity is excluded (so re-saving an existing entity is allowed).
- Empty values are skipped.
- Error message: `%label "%value" is already in use. It must be unique.` where `%label`
  is the (possibly overridden) Title field label for nodes, or `Name` for terms.
- Because it is a field constraint, it fires on entity edit forms and on any entity
  validation path (entity API, JSON:API, REST).

## Migration note

`unique_entity_title_update_8001` (run via `drush updatedb`) migrates legacy per-vocabulary
keys (`{vid}_taxonomy_unique`) out of the old `unique_entity_title.settings` config into
per-vocabulary third-party settings. Only relevant when upgrading from an older release.
