<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Sorts Widget (search_api_sorts_widget) — agent index

Converts the **Search API Sorts** block from a list of sort links into a single "Sort by"
`<select>` dropdown (plus an optional Sort button). It provides **no block of its own** —
it *alters* `search_api_sorts`'s existing `search_api_sorts_block` derivative block. Requires
`search_api_sorts` and core `block`. Version **1.0.0-beta5** (beta). Core `^10 || ^11`.

## Mechanism (read the source, not the guess)
- `search_api_sorts_widget.module` implements `hook_block_view_search_api_sorts_block_alter()`,
  adding a `#pre_render` callback `BlockViewAlter::preRender`.
- `src/BlockViewAlter.php` (a `TrustedCallbackInterface`) replaces `$build['content']` with a
  rendered `WidgetForm`, passing the block's original content (the sort **links**) and the block's
  `#derivative_plugin_id` (which identifies the Search API display).
- `src/Form/WidgetForm.php` loads the `search_api_sorts_widget` **config entity** keyed to the
  escaped derivative id. If it is missing or its `status` is off, it returns the **original link
  list unchanged** — the widget is opt-in per display. When active it builds a `#type => select`
  named `sort_by`: options are the admin labels (`label_asc` / `label_desc`) with values
  `"$field|asc"` / `"$field|desc"`; `#default_value` is the *inverse* of the current active sort
  so the option toggles direction. `autosubmit` adds `onChange="this.form.submit();"`;
  `autosubmit_hide` hides the "Sort" submit button with inline CSS.
- `WidgetForm::submitForm()` splits `sort_by` into `[field, order]`, finds the matching **trusted
  sort link** (`#items[*]['#sort_field'] == field`) from the block, takes *that link's* `#url`,
  sets its `order` query param to the chosen direction, and `setRedirectUrl(Url::fromUserInput(...))`.
  The redirect **path comes from the trusted sort link**, not from user input; only the `order`
  value is user-supplied and it is URL-encoded into the query.

## Admin / config surface
- Config entity type: `search_api_sorts_widget` (`src/Entity/SearchApiSortsWidget.php`),
  `admin_permission = "administer search_api"`, one per display. Fields: `status`, `autosubmit`,
  `autosubmit_hide`, `sorts[]` (`weight`, `field_name`, `label_asc`, `label_desc`). Schema in
  `config/schema/search_api_sorts_widget.schema.yml`.
- `src/Form/ManageSortFieldsForm.php` — the per-display admin form ("Active", "Autosubmit",
  "Hide submit button", and a drag-and-drop table of asc/desc labels per enabled sort field;
  labels are validated to ≤ 80 chars).
- Routes (`*.routing.yml`), all gated by **`administer search_api`**:
  `/admin/config/search/search-api/index/{index}/sorts_widget` (listing, `AdminController::displayListing`),
  `.../sorts_widget/{display}` (the form), and an `edit_form` redirect helper for config_translation
  (`AdminController::redirectEditForm`). A "Sorts widget" local task hangs off the index.
- **Note:** the module declares `administer search_api_sorts_widget` in `*.permissions.yml`, but
  nothing in the routing or the entity actually uses it — access is governed by `administer search_api`.

## Setup (what an operator does)
1. Enable this module (pulls in `search_api_sorts` + `block`).
2. On the Search API index, enable the desired sorts on the **Sorts** tab (search_api_sorts).
3. On the **Sorts widget** tab, tick **Active**, optionally **Autosubmit** / **Hide submit button**,
   and fill in ascending/descending labels. Save.
4. Place (or keep) the **search_api_sorts** block for that display in Block Layout — this module
   rewrites its content automatically.

## Solution docs
- [blocks/sort-widget-block.md](blocks/sort-widget-block.md) — how the block alter + widget form work at runtime.
- [config/admin-configuration.md](config/admin-configuration.md) — the config entity and per-display admin form.
