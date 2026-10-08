<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up the metadata group

Field Group Metadata has **no configuration UI, settings, permissions or routes of its own**. Its
entire behaviour is triggered by one convention: a Field Group whose machine name is exactly
`group_metadata`.

## The one setup step

1. Enable `field_group` and `field_group_metadata` (`drush en field_group_metadata -y` pulls in
   `field_group`).
2. Go to the entity's **Manage form display** (e.g. `admin/structure/types/manage/article/form-display`).
3. **Add group** → choose a group type such as *Details* or *Tab*, give it a label, and set its
   **machine name to `group_metadata`**. This is the only name that works — the README's sole
   troubleshooting entry is "ensure the technical name is `group_metadata`; other groups won't be
   moved."
4. Drag the metadata fields into that group and save.

On the next render of that form, the group appears in the right-hand **advanced** sidebar (the same
vertical-tabs column as *Authoring information* and *Revision log*), not in the main content stack.

The choice of which group is metadata therefore lives in **field_group's own form-display config**,
so it exports and deploys with `drush cex` / `drush cim`; this module stores nothing.

## Exactly what happens (`src/FieldGroupMetadataPreRenderer.php`)

`field_group_metadata_form_alter()` adds a `#pre_render` callback to any form that has a non-empty
`$form['#fieldgroups']['group_metadata']` **and** whose `$form_id` does not begin with `media_`
(media forms are deliberately excluded). At pre-render, `FieldGroupMetadataPreRenderer::preRender()`:

- moves `$element['group_metadata']` into `$element['advanced']['group_metadata']` and sets its
  `#weight` to `-1000` (so it sorts above core's tabs), then unsets the original;
- if the form has `$element['actions']` (save/preview/delete buttons), copies them to
  `$element['advanced']['actions']` with `#weight 1000` so they remain reachable within the sidebar.

`hook_module_implements_alter()` re-orders this module's `hook_form_alter()` to run **after**
`field_group`'s, because it relies on field_group having already assembled `#fieldgroups`.

## Scope and caveats

- **Any entity form** (node, taxonomy term, user, custom content entity) with a `group_metadata`
  group is affected — it is not limited to nodes — except forms whose id starts with `media_`.
- The target form must actually have an `advanced` vertical-tabs region for the placement to look
  right; standard content entity forms do.
- To standardise placement across content types, just name the group `group_metadata` on each one.
- **Removal is safe:** uninstalling leaves the group rendering normally in the main content area.
  No data is lost — the module only rearranges the render array.
- `composer.json` declares `"minimum-stability": "dev"`; account for it when resolving versions in a
  strict project.
