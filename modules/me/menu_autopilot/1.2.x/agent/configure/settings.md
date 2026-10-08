<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Menu Autopilot

Two places: the **settings page** (which menus are managed + defaults) and the **per-link "Menu Autopilot: children of …" section** on the menu-link edit form (turn a link into a dynamic parent).

## Settings page

Route `menu_autopilot.settings_form` at `/admin/structure/menu/autopilot` (Structure → Menu Autopilot). Permission: `administer menu autopilot`. Saving reconciles immediately.

Config object `menu_autopilot.settings` (schema `config/schema/menu_autopilot.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `managed_menus` | sequence of menu machine names | `['main']` | Only these menus are ever synced. A dynamic-parent descriptor saved on a link in an unmanaged menu is stored but never acted on. |
| `default_sort` | string | `title_asc` | Default child sort for new dynamic parents. One of `title_asc`, `title_desc`, `created_desc`, `created_asc`, `preserve`. |
| `default_limit` | integer | `0` | Default max children (`0` = unlimited). |

Set via drush: `drush config:set menu_autopilot.settings managed_menus.0 main` etc., or edit the form.

## Per-link dynamic parent

Edit any link in a managed menu → open the details section titled **"Menu Autopilot: children of [that item]"** (added by `hook_form_menu_link_content_form_alter`). The controls are never shown on a link the module generated (a managed child); such links show a short notice pointing the editor back to the parent instead. Fields, keyed under the `menu_autopilot` form value, persisted onto the link's internal `menu_autopilot` map base field as `['source' => [...]]`:

- **`source_type`** (select — "Children come from"): `none` (nothing / curated by hand — clears the descriptor), `term` (nodes tagged with a taxonomy term), `bundle` (all nodes of a content type), `manual` (hand-picked node list).
- **`existing_children`** (radios — policy for children already under the parent):
  - `adopt` (default) — reuse hand-created links that already point at a source node; leave curated extras alone.
  - `adopt_prune` — reuse matches, and delete unmanaged extras not in the source.
  - `add` — only generate links for source nodes that have no child yet; change nothing existing.
  - `replace` — delete all unmanaged children, then build the managed set from scratch.
  A live-updating help block explains the selected option.
- **`reparent_matches`** (checkbox): move unmanaged links from elsewhere in the same menu that already point at a source node under this parent, then apply the policy above. Links owned by another automatic parent are left alone.
- **`reference_field`** (term source, required): select of node fields that reference taxonomy terms (auto-discovered; no machine-name typing).
- **`term`** (term source, required): the taxonomy term entity autocomplete.
- **`bundle`** (select): required for `bundle` source; optional extra filter for `term`.
- **`nodes`** (manual source, required): tagged node autocomplete, in order; unpublished nodes are skipped.
- **`sort`** (term/bundle — "Sort children by"): `title_asc` | `title_desc` | `created_desc` | `created_asc` | `preserve`. **`preserve` ("Keep current order")** leaves existing child weights alone so you can drag children on the menu overview; new items append after the current maximum weight. The other options rewrite weights on every sync. Manual sources always follow the hand-picked node order and ignore `preserve`.
- **`limit`** (term/bundle, number, min 0): max children, `0` = unlimited.
- **`title_pattern`** (textfield — "Child menu label"): optional token pattern for the child label, e.g. `[node:title]` or `[node:title] [node:field_subtitle]`. Blank = node title. Replacement is plain-text (`Token::replacePlain`), so characters such as `&` are stored literally, not HTML-escaped; unreplaced tokens are cleared. URIs are never tokenized. A token-tree browser link is shown when the Token module is installed.

Validation enforces the required fields per source type (term needs `reference_field` + `term`; bundle needs `bundle`; manual needs at least one node); errors are attached inline to the offending element.

After saving, the entity-save hook reconciles the parent's children. Managed children are recreated, re-titled, re-ordered, and pruned automatically on later content publish/update/unpublish/delete.

## Menu overview and node form

- On the overview of a managed menu (`menu_edit_form`), a help note explains that automatic children's labels and order are controlled on the parent's Menu Autopilot section, not by renaming/dragging the child on the overview.
- On a node edit form, a page that appears in a managed menu as an automatic child shows a read-only "Menu link" notice; core's menu_ui widget is hidden for it so editing the node's other fields does not clobber the managed link's title, weight, or parent.
