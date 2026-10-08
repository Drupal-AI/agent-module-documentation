<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: the `search_api_sorts_widget` config entity and admin form

## Config entity type

`src/Entity/SearchApiSortsWidget.php` defines a `@ConfigEntityType`:

- `id = "search_api_sorts_widget"`, `config_prefix = "search_api_sorts_widget"`,
  `admin_permission = "administer search_api"`.
- Exported keys: `id`, `display_id`, `status`, `autosubmit`, `autosubmit_hide`, `sorts`, `weight`.
- One entity per Search API **display**; the entity `id` is the escaped display plugin id
  (see `ConfigIdEscapeTrait` from search_api_sorts — dots in the display id are escaped for config
  entity ids). `getDisplayId()` returns the stored `display_id`.
- Schema: `config/schema/search_api_sorts_widget.schema.yml` — `status`/`autosubmit`/`autosubmit_hide`
  booleans, and a `sorts` sequence of `{ weight:int, field_name:string, label_asc:label,
  label_desc:label }`.

## Admin form — `ManageSortFieldsForm` (src/Form/ManageSortFieldsForm.php)

Route `search_api_sorts_widget.search_api_display.sorts_widget`
(`/admin/config/search/search-api/index/{search_api_index}/sorts_widget/{search_api_display}`),
requirement `_permission: 'administer search_api'`.

- `getSettings()` loads the config entity for the display, **creating and saving an empty one**
  (in the site default language) if none exists yet — so visiting the tab materialises the entity.
- Widget settings fieldset: **Active** (`status`), **Autosubmit** (`autosubmit`),
  **Hide submit button** (`autosubmit_hide`).
- A drag-and-drop `#type => table` of sortable fields. Rows are built from the index's sort-eligible
  fields — it starts with a synthetic `search_api_relevance` ("Relevance") row, then every index
  field whose type is not `text` and not a `list<...>` multi-value (those can't be sorted). Only
  fields whose corresponding `search_api_sorts_field` is **enabled** (status true) are shown as
  editable rows. Each row: a `weight` element, an escaped field label (`Html::escape`), and
  `label_asc` / `label_desc` textfields.
- If `config_translation` is installed and the site is multilingual, a "Translate" link column is
  added per row (routes to `entity.search_api_sorts_widget.config_translation_overview`).
- **Validation** (`validateForm`): when the widget is Active, each `label_asc` / `label_desc` must be
  ≤ 80 characters (`validateLabel`).
- **Submit** (`submitForm`): saves `id`, `display_id`, `status`, `autosubmit`, `autosubmit_hide`, and
  the whole `sorts` table onto the entity, then a status message. (A large legacy per-field block is
  commented out — the current code stores everything on the single display-level entity.)

## Other routes / links

- `entity.search_api_index.sorts_widget`
  (`/admin/config/search/search-api/index/{search_api_index}/sorts_widget`) →
  `AdminController::displayListing`: lists the Search API **displays** attached to the index with a
  "Manage sorts widget" operation link each. `_permission: 'administer search_api'`.
- `entity.search_api_sorts_widget.edit_form`
  (`/admin/config/search/search-api/sorts-widget/{search_api_sorts_widget}`) →
  `AdminController::redirectEditForm`: strips any `destination` query param (so a
  config_translation-added destination doesn't defeat it) and redirects to the display's
  ManageSortFieldsForm. `_permission: 'administer search_api'`.
- Local tasks (`*.links.task.yml`): a "Sorts widget" tab under the Search API index.
- Contextual link (`*.links.contextual.yml`): "Manage sort fields" on the search_api_sorts block,
  pointing at the search_api_sorts sorts route.

## Permission caveat

`search_api_sorts_widget.permissions.yml` declares **`administer search_api_sorts_widget`**, but no
route or entity in this module references it. Every admin surface here is gated by core Search API's
**`administer search_api`** permission instead. Grant that to editors who should configure the widget;
the module's own permission is effectively inert in 1.0.0-beta5.
