# Configure Synonyms

Everything lives under **Structure → Synonyms configuration** (`/admin/structure/synonyms`,
route `synonyms.overview`, permission `administer synonyms`). The overview lists every eligible
entity type/bundle with links to manage its providers and behaviors.

## Permissions

| Permission | Restrict access | Gates |
|---|---|---|
| `administer synonyms` | (not flagged restricted) | The overview, add/edit/delete Synonym provider config entities. |

Two routes instead require core **`administer site configuration`**: the global settings form and the
per-bundle *Manage behaviors* form.

## 1. Synonym provider config entities (`synonym.*`)

A **Synonym** config entity binds a provider plugin to one entity-type/bundle/field.

- Add: `/admin/structure/synonyms/{entity_type}/{bundle}/add` (route `synonym.entity_type.bundle.add_form`).
- Edit / delete: `/admin/structure/synonyms/{synonym}` and `.../delete`.
- Stored fields (`config_export`): `id`, `provider_plugin`, `base_provider_plugin`, `provider_configuration`
  (a mapping, at minimum `wording`).

The shipped `field` / `base-field` providers are **derivatives**: one plugin instance per supported
field on the bundle. "Supported" = the field's type is in the `FieldTypeToSynonyms` map (text,
entity_reference, integer, number, float, decimal, email, telephone — alter it with
`hook_synonyms_field_type_to_synonym_alter()`).

Example — synonyms of `taxonomy_term` "tags" from a text field via Drush:

```php
\Drupal::entityTypeManager()->getStorage('synonym')->create([
  'id' => 'tags_alt_label',
  'provider_plugin' => 'field.taxonomy_term.tags.field_alt_label',   // base_id.entity.bundle.field
  'base_provider_plugin' => 'field',
  'provider_configuration' => ['wording' => '@synonym is a synonym of @entity_label'],
])->save();
```

(Use the *Add provider* UI to discover exact derivative IDs for your site rather than guessing.)

## 2. Global settings (`synonyms.settings`)

Route `synonyms.settings` → `/admin/structure/synonyms/settings` (perm `administer site configuration`).
Config `synonyms.settings` (config entity) keys:

| Key | Default | Meaning |
|---|---|---|
| `wording_type` | `default` | Which wording strategy to use when formatting a synonym for display. |
| `wording_type_label` | `Default wording` | Human label of the selected wording type. |

## 3. Behaviors (per entity type + bundle)

Route `behavior.entity_type.bundle` → `/admin/structure/synonyms/behavior/{entity_type}/{bundle}`
(perm `administer site configuration`). Behaviors are services tagged `synonyms_behavior` and are
contributed by the submodules (autocomplete, select, search). Enabling one writes a config named
`synonyms_<behavior_id>.behavior.<entity_type>.<bundle>` with:

| Key | Meaning |
|---|---|
| `status` | Whether the behavior is enabled for this entity type/bundle. |
| `wording` | Behavior-specific wording string, e.g. `@synonym is the @field_label of @entity_label`. |

Check it in code with `\Drupal::service('synonyms.provider_service')->serviceIsEnabled($entity_type, $bundle, $behavior_id)`.

## Production note

The README notes the Synonyms UI/config forms are mainly a dev-time convenience — once your `synonym.*`
configs and behaviors are set, that admin surface can be uninstalled on production while synonyms keep
working through the exported config.
