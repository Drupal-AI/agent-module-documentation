# Configuration — scope of lineage saving

All behaviour is driven by one config object, edited on one form. There is no per-field widget setting
and no per-vocabulary flag stored on the vocabulary entity — everything lives in
`taxonomy_set_lineage.settings`.

## Form & route

- Route/form: `taxonomy_set_lineage.taxonomy_set_lineage_vocabulary_form` →
  `/admin/config/content/taxonomy_set_lineage` (menu link under *Configuration › Content authoring*).
- Access: core permission `administer taxonomy` (declared in `taxonomy_set_lineage.routing.yml`).
- Form class: `Drupal\taxonomy_set_lineage\Form\TaxonomySetLineageForm` (extends `ConfigFormBase`,
  form id `taxonomy_set_lineage_vocabulary_form`, editable config `taxonomy_set_lineage.settings`).

## Config keys (`taxonomy_set_lineage.settings`)

Each key is a `sequence` of `string` (see `config/schema/taxonomy_set_lineage.schema.yml`). The form
`array_filter`s + `array_values`es every checkbox group, so stored values are flat lists of the checked
ids only.

| Key | Form element | Stored value | Meaning |
|---|---|---|---|
| `vocabulary` | checkboxes, **`#required` TRUE** | vocabulary machine ids (vids) | The vocabularies lineage is saved for. Nothing happens if empty. |
| `entities` | checkboxes | entity type ids (e.g. `node`) | Optional. Limit to these entity types. |
| `bundles` | checkboxes | bundle ids (e.g. `article`) | Optional. Limit to these bundles (does not require the entity type to be selected). |
| `fields` | checkboxes | field-config ids `entity_type.bundle.field_name` | Optional. Limit to these exact field instances. |

## How the four keys combine (matches the presave hook and the action)

- `vocabulary` **must** be non-empty or the module does nothing (`if (!empty($vocabulary))`).
- If `entities`, `bundles` **and** `fields` are **all empty**: the module scans **all**
  `entity_reference` fields on the saved entity whose target is `taxonomy_term` and whose selection
  handler references one of the `vocabulary` ids — i.e. lineage applies everywhere those vocabularies
  are referenced.
- If any of `entities` / `bundles` / `fields` is set, they act as an **OR** of independent narrowings
  (each block runs on its own): the entity qualifies if its entity type is in `entities`, **or** its
  bundle is in `bundles`, **or** it has a listed field in `fields`. A qualifying field must still target
  the active `vocabulary` (verified via the field's `handler_settings.target_bundles`, or, for
  view-based selection handlers, the vocabularies in the referenced View's `vid` filter — see
  `_taxonomy_set_lineage_get_view_vocabularies()`).

## Option sourcing (what the form offers)

The form builds its `entities`/`bundles`/`fields` options from `field_storage_config` entities of type
`entity_reference` with `settings.target_type = taxonomy_term`, then loads their `field_config`
instances (`TaxonomySetLineageForm.php:102-160`). So only entity types/bundles/fields that actually have
a taxonomy-term reference field appear as options; `fields` options are labelled `<label> <small>(id)</small>`.

## Notes for agents

- To configure from code, write the four keys directly, e.g.
  `\Drupal::configFactory()->getEditable('taxonomy_set_lineage.settings')->set('vocabulary', ['tags'])->set('entities', [])->set('bundles', [])->set('fields', [])->save();`
- View-based entity-reference selection ("Views: Filter by an entity reference view") is supported: the
  active vocabularies are read from the View display's `vid` filter (falling back to the `default`
  display) rather than from `target_bundles`.
