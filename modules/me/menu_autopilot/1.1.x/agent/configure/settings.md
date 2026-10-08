<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Menu Autopilot

Two places: the **settings page** (which menus are managed + defaults) and the **per-link "Automatic children" section** on the menu-link edit form (turn a link into a dynamic parent).

## Settings page

Route `menu_autopilot.settings_form` at `/admin/structure/menu/autopilot` (Structure → Menu Autopilot). Permission: `administer menu autopilot`. Saving reconciles immediately.

Config object `menu_autopilot.settings` (schema `config/schema/menu_autopilot.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `managed_menus` | sequence of menu machine names | `['main']` | Only these menus are ever synced. A dynamic-parent descriptor saved on a link in an unmanaged menu is stored but never acted on. |
| `default_sort` | string | `title_asc` | Default child sort for new dynamic parents. One of `title_asc`, `title_desc`, `created_desc`, `created_asc`. |
| `default_limit` | integer | `0` | Default max children (`0` = unlimited). |

Set via drush: `drush config:set menu_autopilot.settings managed_menus.0 main` etc., or edit the form.

## Per-link "Automatic children" (dynamic parent)

Edit any link in a managed menu → open **Automatic children** (added by `hook_form_menu_link_content_form_alter`). The controls are never shown on a link the module generated (a managed child). Fields, keyed under the `menu_autopilot` form value, persisted onto the link's internal `menu_autopilot` map base field as `['source' => [...]]`:

- **`source_type`** (select): `none` (curated by hand — clears the descriptor), `term` (nodes tagged with a taxonomy term), `bundle` (all nodes of a content type), `manual` (hand-picked node list).
- **`existing_children`** (radios — NEW in 1.1; policy for children already under the parent):
  - `adopt` (default) — reuse hand-created links that already point at a source node; leave curated extras alone.
  - `adopt_prune` — reuse matches, and delete unmanaged extras not in the source.
  - `add` — only generate links for source nodes that have no child yet; change nothing existing.
  - `replace` — delete all unmanaged children, then build the managed set from scratch.
- **`reparent_matches`** (checkbox — NEW in 1.1): move unmanaged links from elsewhere in the same menu that already point at a source node under this parent, then apply the policy above. Links owned by another automatic parent are left alone.
- **`reference_field`** (term source, required): select of node fields that reference taxonomy terms (auto-discovered; no machine-name typing).
- **`term`** (term source, required): the taxonomy term entity autocomplete.
- **`bundle`** (select): required for `bundle` source; optional extra filter for `term`.
- **`nodes`** (manual source, required): tagged node autocomplete, in order; unpublished nodes are skipped.
- **`sort`** (term/bundle): `title_asc` | `title_desc` | `created_desc` | `created_asc`.
- **`limit`** (term/bundle, number, min 0): max children, `0` = unlimited.
- **`title_pattern`** (textfield): optional token pattern for the child label, e.g. `[node:title]` or `[node:field_nav_title]`. Blank = node title. URIs are never tokenized.

Validation enforces the required fields per source type (term needs `reference_field` + `term`; bundle needs `bundle`; manual needs at least one node); errors are attached inline to the offending element.

After saving, the entity-save hook reconciles the parent's children. Managed children are recreated, re-titled, re-ordered, and pruned automatically on later content publish/update/unpublish/delete.
