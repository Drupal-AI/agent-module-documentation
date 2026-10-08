<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Running a bundle conversion

Convert Bundles has **no settings page** — you never "configure" it, you *run* it. There are
three entry points, all backed by the same multi-step wizard `ConvertBundlesForm`.

## The auto-created actions

On install (`convert_bundles_install`) and lazily via `hook_entity_operation_alter`, the
module creates one configured action per entity type that has **2 or more bundles**:

- Config entity id: `system.action.convert_bundles_on_<entity_type>` (e.g. `…on_node`,
  `…on_taxonomy_term`, `…on_media`, `…on_paragraph`).
- `plugin: convert_bundles_action_base`, `type: <entity_type>`.
- Inspect: `drush config:get system.action.convert_bundles_on_node`.

Because these are ordinary core actions, the conversion is available anywhere actions are —
the `/admin/content` bulk-operations dropdown, Views Bulk Operations, and Rules.

## Entry point 1 — one entity (the "Convert Bundle" tab)

A `RouteSubscriber` + local-task deriver add a **Convert Bundle** tab to each entity's
canonical page at `/{entity_type}/{id}/convertbundles` (route
`entity.<entity_type>.convert_bundles`), gated by the `convert <entity_type> bundle`
permission. It stashes the entity in the `convert_bundles_ids` private tempstore and redirects
to the wizard.

## Entry point 2 — several entities (bulk action)

On `/admin/content` (or any VBO view) tick rows, choose **Convert … Entity Bundles** from the
action dropdown, Apply. `ConvertBundlesActionBase::executeMultiple()` stores the selected ids
in tempstore and the confirm form (`convert_bundles.form`, `/admin/convert_bundles`) opens.

## Entry point 3 — a whole bundle

Go to **Configuration → Content authoring → Convert Bundles**
(`/admin/config/content/convert_bundles`, route `convert_bundles.admin`). Pick an entity type
and a source bundle to load *all* entities of that bundle.

## The wizard steps (all three entry points converge here)

1. **Choose the target bundle** you are converting to.
2. **Map fields.** For each non-base source field, pick a target field to copy its value into.
   Targets are filtered to fields whose main-property **data type matches** the source, plus
   two special options:
   - `remove` — discard the source field's value.
   - `append_to_body` — append the value (labelled) to the target's `body` field; an
     entity-reference to a `media` item is appended as a `<drupal-media …>` embed.
3. **Convert.** A Batch rewrites the bundle column and copies mapped values (see
   [../api/mechanism.md](../api/mechanism.md)).

## Doing it without the UI

There is no Drush command. Programmatically you can call the static helpers on
`Drupal\convert_bundles\ConvertBundles` (see [../api/mechanism.md](../api/mechanism.md)), or in
simple cases rewrite the bundle column and re-save. The persistent config you can export is
only the `system.action.convert_bundles_on_*` entities — there is no per-conversion config.
