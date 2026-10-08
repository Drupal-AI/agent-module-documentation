<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference selection plugins (no config dependency)

These are instances of **core's `EntityReferenceSelection` plugin type** (openy_er does not define a
new plugin type or manager). They live in `src/Plugin/EntityReferenceSelection/` and mirror core's
default selection handlers, but store the allowed-bundle list under `target_bundles_no_dep` instead
of `target_bundles` so that `EntityReferenceItem::calculateDependencies()` never records a config
dependency on the referenced bundle.

## The plugins

| id | Class | Extends | group | Label (Field UI "Reference method") |
|---|---|---|---|---|
| `default_no_dep` | `DefaultSelectionNoDependency` | core `DefaultSelection` | `default (openy)` | Default (openy) |
| `default_no_dep:node` | `NodeSelectionNoDependency` | core `NodeSelection` + trait | `default_no_dep` | Node selection (openy) |
| `default_no_dep:block_content` | `BlockSelectionNoDependency` | core `NodeSelection` + trait | `default_no_dep` | Block selection (openy) |

- `default_no_dep` uses the core `DefaultSelectionDeriver`, so per-entity-type derivatives
  (`default_no_dep:node`, `default_no_dep:block_content`, and any others the deriver produces) are
  what actually get selected for a field.
- `DefaultSelectionNoDependency` is **intentionally empty** (`DefaultSelectionNoDependency.php:27`);
  its only job is to register the `default (openy)` group label so the handlers appear as a set in
  the "Reference method" select.
- Note `BlockSelectionNoDependency` extends core `NodeSelection` (not a block-specific class), but is
  scoped to `entity_types = {"block_content"}` via its annotation.
- `NodeSelectionNoDependency` renames the bundle checkboxes to *Content types*
  (`NodeSelectionNoDependency.php:29`).

## `SelectionNoDependencyTrait` (`SelectionNoDependencyTrait.php`)

Shared by the node/block handlers. What it changes vs. core:

- **`defaultConfiguration()`** — adds `target_bundles_no_dep` (default `NULL`), keeps `target_bundles`
  present but the form forces it to `[]`, plus `sort` (`field` `_none`, `direction` `ASC`),
  `auto_create` (`FALSE`), `auto_create_bundle` (`NULL`).
- **`buildConfigurationFormAlter()`** — renders a required `checkboxes` element `target_bundles_no_dep`
  from the entity type's bundle info (natsorted), and sets `target_bundles` to a `#type => value`
  of `[]` (so nothing is ever written to the dependency-bearing key). `auto_create_bundle`'s options
  are intersected with the checked no-dep bundles and only shown when more than one is selected.
- **`validateConfigurationForm()`** — if the user checks nothing, `target_bundles_no_dep` is stored as
  `NULL` ("all bundles referenceable") rather than `[]`.
- **`validateReferenceableNewEntities()`** — when auto-creating, filters new entities to those whose
  `bundle()` is in `target_bundles_no_dep` (all allowed when it is `NULL`).
- **`buildEntityQuery()`** — same query core builds, but conditions on `target_bundles_no_dep`:
  `NULL` ⇒ no bundle filter; `[]` ⇒ forced-empty result (`condition(id, NULL, '=')`); array ⇒
  `condition(bundle, [...], 'IN')`. It calls `->accessCheck(TRUE)`, adds the `{entity_type}_access`
  and `entity_reference` query tags, and applies the configured `sort`. (Entity access is respected —
  the no-dependency change is purely about config dependencies, not access.)

## How a field ends up using one (Field UI, from README)

1. On the reference field's settings form, set **Reference method** from *Default* to a
   **`… (openy)`** handler.
2. Re-check the same bundles you had selected (labelled *Content types* for nodes, *Bundles*
   otherwise) — these are now stored under `target_bundles_no_dep`.
3. Save, then export the config / feature. The exported `field.field.*.yml` will have
   `handler: default_no_dep:node` (etc.) and `handler_settings.target_bundles_no_dep: {…}`, and its
   `dependencies` block will **not** list the individual bundle configs.
4. Add `openy_er` to the owning module/feature's `dependencies`.

## Resulting field config shape

```yaml
# field.field.<entity_type>.<bundle>.<field_name>.yml
settings:
  handler: default_no_dep:node
  handler_settings:
    target_bundles_no_dep:
      article: article
      page: page
    sort:
      field: _none
      direction: ASC
    auto_create: false
    auto_create_bundle: null
# dependencies: no reference to node.type.article / node.type.page
```
