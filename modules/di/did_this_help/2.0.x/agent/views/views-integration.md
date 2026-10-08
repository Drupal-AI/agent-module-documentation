<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration & the feedback report

## Report View (shipped config)
`config/install/views.view.did_this_help.yml` — View id `did_this_help`, base table
`did_this_help`, base field `id`.

- **Access:** `perm` → `view did this help reports`.
- **Page display `page_1`:** path `admin/reports/did-this-help`, menu link under
  *Reports* (`system.admin_reports`), title "Did this help? report".
- **Table style**, mini pager (100/page), sorted by `created` DESC.
- **Fields:** path, title (linked to `{{ path }}`, label "Page Title"), choice ("Yes/No"),
  choice_no ("Answer"), message, created ("Created date"), and user name via the `uid`
  relationship.
- **Exposed filters:** User (`uid`, in), Page Title (`title`, contains), Page URL (`path`,
  contains), and Yes/No `choice` (in, using the module's custom filter plugin).

Depends on core modules `views` and `user` (declared in the View's config dependencies).

## Views data
`Drupal\did_this_help\Hook\DidThisHelpViewsHooks::viewsData()`
(`src/Hook/DidThisHelpViewsHooks.php`, `#[Hook('views_data')]`, autowired service). Declares the
`did_this_help` base table (base field `id`) and exposes each column as field/sort/filter/argument:
`id` (numeric), `path`/`title`/`choice_no`/`message` (string), `uid` (numeric + relationship to
`users_field_data`), `choice` (filter id `did_this_help`), `created` (date).

`hook_views_api()` is provided by `DidThisHelpHooks::viewsApi()` (api 3, path `<module>/views`).
`did_this_help.views.inc` and `did_this_help.module` hold `#[LegacyHook]` shims that delegate to the
autowired hook services (`did_this_help.services.yml`); the real implementations use `#[Hook(...)]`
attributes.

## Custom filter plugin
`Drupal\did_this_help\Plugin\views\filter\DidThisHelp`
(`src/Plugin/views/filter/DidThisHelp.php`), `@ViewsFilter("did_this_help")`, extends `InOperator`.
`getValueOptions()` returns a fixed `['yes' => 'Yes', 'no' => 'No']` list, giving the exposed
filter a clean Yes/No selector for the `choice` column.

## Building your own view
Create any View on the `did_this_help` base table to build blocks, data-export (CSV) displays, or
dashboards over collected feedback; join to users through the shipped `uid` relationship. Fields use
the standard Views field handlers (output escaped by Views), so stored values render safely.
Gate custom displays with the `view did this help reports` permission (or a stricter one).
