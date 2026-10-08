<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Pathauto entity parent

## Enable

```
composer require drupal/pathauto_entity_parent
drush en pathauto_entity_parent -y
```

Pulls in `pathauto` (which requires `token`, `path`) and core `node`. `hook_install` runs an
entity-definition update that installs the `pathauto_entity_parent` base field on nodes; the field
exists on **all** node bundles from that moment, but stays hidden until a bundle is selected below.

## Select which content types can be nested

Settings form: **Administration » Configuration » Search and metadata » Pathauto entity parent**
(`/admin/config/search/parent`, route `pathauto_entity_parent.settings_form`, permission
**administer site configuration**).

- The form is a single **checkboxes** element listing every node content type.
- Config object: `pathauto_entity_parent.settings`, key **`bundles`** (a sequence of bundle
  machine names).
- **De-selecting** a previously-checked bundle triggers `StorageHelper::removeValueFromBundles()`,
  which NULLs the `pathauto_entity_parent` value on every node of those bundles
  (`UPDATE node_field_data`). Existing parent relationships for that type are **erased**, not just
  hidden — re-checking does not bring them back.

## What appears on the node form

For a node whose bundle is checked, `FormAlterHooks` alters `node_<bundle>_form` /
`node_<bundle>_edit_form`:

- The **Parent** autocomplete (entity-reference to node) is **moved into the URL alias (`path`)
  fieldset** rather than sitting as a standalone field.
- It is **disabled unless** Pathauto's *Generate automatic URL alias* checkbox is ticked
  (`#states` bound to `path[0][pathauto]`). Turning off automatic aliases greys out the parent
  picker, since a manual alias is used verbatim and the prepend never runs.

For a node whose bundle is **not** checked, the field is present in storage but the widget's
`#access` is `FALSE`, so editors never see it.

## Generating the nested alias

Aliases are produced by Pathauto as usual; there is **no separate pattern to configure** in this
module. When you save (or bulk-regenerate) a node in a checked bundle that has a parent set,
`hook_pathauto_pattern_alter` prepends the parent's **already-stored** alias to that node's
Pathauto pattern. So with a normal `[node:title]` pattern, a child of `/services` becomes
`/services/<title>`.

Operational notes:

- The **parent must have an alias first** — generate top-down, or run a bulk regeneration at
  *Configuration » Search and metadata » URL aliases » Bulk generate* after setting parents.
- Children are **not** auto-regenerated when a parent's alias changes (no dependency tracking).
  After renaming/moving a parent, bulk-regenerate the affected content.
- Install the **`redirect`** module so old URLs keep working when hierarchy changes.

## Uninstall

`drush pmu pathauto_entity_parent -y` runs `hook_uninstall`, which removes the base field via an
entity-definition update. Parent values are dropped with the field.
