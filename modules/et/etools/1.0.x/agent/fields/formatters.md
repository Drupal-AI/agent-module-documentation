<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatters

Four `@FieldFormatter` plugins in `src/Plugin/Field/FieldFormatter/`. Select each per view-display on
*Structure → (bundle) → Manage display* (click the gear for its settings). None adds permissions,
routes, or config schema; formatter settings save in the view-display config.

## `etools_er_subset` / `etools_err_subset` — Rendered entity (subset)

- `EntityReferenceSubsetFormatter` (id `etools_er_subset`, `field_types = { entity_reference }`)
  extends core `EntityReferenceEntityFormatter`.
- `ERRSubsetFormatter` (id `etools_err_subset`, `field_types = { entity_reference_revisions }`)
  extends `entity_reference_revisions`'s `EntityReferenceRevisionsEntityFormatter` — so
  **the `entity_reference_revisions` module must be installed** to use this one (undeclared in
  `etools.info.yml`). Use it for Paragraphs-style fields.
- Both are thin wrappers that `use EntityReferenceSubsetTrait` (`Traits/EntityReferenceSubsetTrait.php`);
  the trait supplies all behaviour and the parent supplies the actual "rendered entity" output.

Settings (from the trait's `defaultSettings()`), added on top of the parent's:

| Setting | Default | Meaning |
|---|---|---|
| `allowed_bundles` | `''` | Comma-separated bundle machine names allowed to display (e.g. `page,article`); empty = all bundles. |
| `allowed_count` | `1` | Max number of referenced items to display; `0` = all (capped internally at 9999). |

`getEntitiesToView()` (trait) takes the parent's list, and when a restriction is set, keeps entities
whose `bundle()` is in `allowed_bundles` (or any, if empty) until `allowed_count` is reached, then
stops. With no bundle filter and `allowed_count` = 0 it returns the parent's full list unchanged.
`settingsSummary()` appends the two values to the parent summary.

## `etools_entity_reference_link` — Etools Entity Link

`EtoolsEntityReferenceLinkFormatter` (id `etools_entity_reference_link`,
`field_types = { entity_reference }`), extends `EntityReferenceFormatterBase`. Renders each
referenced entity's **label as a link** to a fixed destination carrying the entity id as a query
parameter — useful to link to a listing page with a filter pre-applied.

Settings (`defaultSettings()`):

| Setting | Default | Meaning |
|---|---|---|
| `destination` | `/` | Base URL; parsed with `Url::fromUserInput()`. Accepts `/path` or `https://example.com`. Required. |
| `query_param_key` | `tag` | Query-string key that receives the entity id. Required. |

`viewElements()` builds, per referenced entity, a `#type => link` element with `#title` = label,
`#url` = the destination, and `#options[query][<query_param_key>]` = `entity->id()`. New (unsaved)
entities render as `#plain_text` label. Entity cache tags are attached. `settingsSummary()` shows the
`DESTINATION?QUERY_KEY=ENTITY_ID` pattern. Access is `checkAccess()` → `$entity->access('view label')`.

Result pattern: `<a href="/DESTINATION?QUERY_KEY=ENTITY_ID">Label</a>`.

## `etools_text_linked` — Text linked

`TextLinkedFormatter` (id `etools_text_linked`, `field_types = { string }`), extends core
`StringFormatter`; DI-injects `entity_type.manager` and `etools.entity` (`create()`). Renders a
string field as text linked to a URL taken from a **companion link field** on the same entity.

Settings (`defaultSettings()`):

| Setting | Default | Meaning |
|---|---|---|
| `link_field` | `''` | Machine name of a link field on the entity. Required. |

`getUrl()` calls `EtoolsEntity::getFieldDisplay($entity, link_field, ['link'])` and takes the first
item's `#url` when it is a `Url` object. `viewElements()` then renders each string value as
`#type => link` (title = the text, url = that URL) when a URL was found, or as plain text when the
link field is empty. `settingsSummary()` shows which field provides the URL.
