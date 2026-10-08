<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Menu Autopilot

Two places: the **settings page** (which menus are managed + defaults) and the **per-link "Menu Autopilot: children of …" section** on the menu-link edit form (turn a link into a dynamic parent).

## Settings page

Route `menu_autopilot.settings_form` at `/admin/structure/menu/autopilot` (Structure → Menu Autopilot). Permission: `administer menu autopilot`. Form: `Drupal\menu_autopilot\Form\MenuAutopilotSettingsForm` (a `ConfigFormBase`, so core's form CSRF token applies). Saving reconciles immediately (`submitForm()` calls `NavSyncManager::reconcile()`).

![Menu Autopilot settings form](../../../../../../../screenshots/menu_autopilot/1.4.x/settings-form.png)

Config object `menu_autopilot.settings` (schema `config/schema/menu_autopilot.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `managed_menus` | sequence of menu machine names | `['main']` (install default) | Only these menus are ever synced. A dynamic-parent descriptor saved on a link in an unmanaged menu is stored but never acted on. **An explicit empty list means no menus** (1.4.1); only a missing value falls back to `main`. |
| `default_sort` | string | `title_asc` | Default child sort for new dynamic parents. One of `title_asc`, `title_desc`, `created_desc`, `created_asc`, `preserve`. |
| `default_limit` | integer | `0` | Default max children (`0` = unlimited). |

`NavSyncManager::managedMenus()` reads this key. Set via drush: `drush config:set menu_autopilot.settings managed_menus.0 main` etc., or edit the form.

## Per-link dynamic parent

Edit any link in a managed menu → open the details section titled **"Menu Autopilot: children of [that item]"** (added by `menu_autopilot_form_menu_link_content_form_alter()` in `menu_autopilot.module`). The controls are never shown on a link the module generated (a managed child); such links show a short notice pointing the editor back to the parent instead. Fields, keyed under the `menu_autopilot` form value, persisted onto the link's internal `menu_autopilot` map base field as `['source' => [...]]` by the entity builder `_menu_autopilot_link_form_builder()`:

- **`source_type`** (select — "Children come from"): `none` (nothing / curated by hand — clears the descriptor and releases owned children), `term` (nodes tagged with a taxonomy term), `bundle` (all nodes of a content type), `manual` (hand-picked node list). The `term` option and its widgets appear only when Taxonomy is installed.
- **`existing_children`** (radios — policy for children already under the parent):
  - `adopt` (default) — reuse hand-created links that already point at a source node; leave curated extras alone.
  - `adopt_prune` — reuse matches, and delete unmanaged extras not in the source.
  - `add` — only generate links for source nodes that have no child yet; change nothing existing.
  - `replace` — delete all unmanaged children, then build the managed set from scratch.
  A live-updating help block (`aria-live`) explains the selected option.
- **`reparent_matches`** (checkbox): move unmanaged links from elsewhere in the same menu that already point at a source node under this parent, then apply the policy above. Links owned by another automatic parent are left alone.
- **`reference_field`** (term source, required): select of node fields that reference taxonomy terms, auto-discovered by `_menu_autopilot_reference_field_options()` (no machine-name typing).
- **`term`** (term source, required): the taxonomy term entity autocomplete.
- **`bundle`** (select): required for `bundle` source; optional extra filter for `term`.
- **`nodes`** (manual source, required): tagged node autocomplete, in order; unpublished nodes are skipped.
- **`sort`** (term/bundle — "Sort children by"): `title_asc` | `title_desc` | `created_desc` | `created_asc` | `preserve`. **`preserve` ("Keep current order")** leaves existing child weights alone so you can drag children on the menu overview; new items append after the current maximum weight. The other options rewrite weights on every sync. Manual sources always follow the hand-picked node order and ignore `preserve` (`NavSyncManager::preservesEditorOrder()`).
- **`limit`** (term/bundle, number, min 0): max children, `0` = unlimited.
- **`title_pattern`** (textfield — "Child menu label"): optional token pattern for the child label, e.g. `[node:title]` or `[node:title] [node:field_subtitle]`. Blank = node title. Replacement is plain-text (`Token::replacePlain`, `clear => TRUE`), so characters such as `&` are stored literally and unreplaced tokens are cleared. URIs are never tokenized. A token-tree browser link is shown when the Token module is installed.

Validation (`_menu_autopilot_link_form_validate()`) enforces the required fields per source type (term needs `reference_field` + `term`; bundle needs `bundle`; manual needs at least one node); errors are attached inline to the offending element.

After saving, the entity-save hook reconciles the parent's children. Managed children are recreated, re-titled, re-ordered, and pruned automatically on later content publish/update/unpublish/delete.

## Disabled automatic children

A parent's Menu Autopilot section lists any of its automatic children that are currently disabled (`_menu_autopilot_disabled_children_summary()`, capped at 20). Two cases are distinguished: a child another module disabled *during a sync save* (marked `disabled_by_save`; a later sync run by an account that may enable menu links re-enables it) and a child an editor disabled (stays disabled until an editor re-enables it). Saving the child's own link form with *Enabled* unchecked converts a `disabled_by_save` child to an editor choice.

## Menu overview and node form

- On the overview of a managed menu (`menu_edit_form`), `menu_autopilot_form_menu_edit_form_alter()` adds a help note that automatic children's labels and order are controlled on the parent's Menu Autopilot section, not by renaming/dragging the child on the overview.
- On a node edit form, `menu_autopilot_form_node_form_alter()` + `_menu_autopilot_node_form_after_build()` hide core's menu_ui widget for a page that appears as an automatic child (showing a read-only "Menu link" notice) so editing the node's other fields does not clobber the managed link's title, weight, or parent; the node's reconcile is deferred until after menu_ui's own submit handler.
