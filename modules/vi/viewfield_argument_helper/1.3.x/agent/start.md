<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Viewfield Argument Helper (viewfield_argument_helper) — agent index

Content-entry assistance for the **Viewfield** widget's contextual-argument text field. It does not
change how Viewfield stores or renders the argument — the value stays a hand-composed string — it
attaches a lookup/autocomplete UI so an editor can find the entity **ids** a view's contextual
filters accept. Requires `views` and `viewfield`. Version **1.3.3**, core `^9.4 || ^10 || ^11`,
package `Views`. Settings at **`/admin/config/vah/settings`** (`configure` =
`viewfield_argument_helper.settings`).

## The problem
Viewfield exposes a view display's contextual filters as one raw string, e.g. `204,95/72` (terms 204
OR 95 on argument 1, node 72 on argument 2). Nothing in the form tells the editor how many arguments
exist, what entity type each takes, or what ids are valid — and a wrong id fails silently (the view
returns nothing, which reads as "no content" rather than "misconfigured"). This module surfaces the
candidate entities so the editor can compose the string correctly. It is an authoring aid only: the
editor still types the final `,`/`+`/`/` string, and the module does **not** auto-inject the host
entity's id into the view.

## Mechanism (from source)
- **`.module`** — hooks into the `viewfield_select` widget:
  - `hook_field_widget_third_party_settings_form` adds a per-field **`vah_helper_type`** select
    (`lookup` legacy table, or `autocomplete`), defaulting to the site config `default_widget`.
  - `hook_field_widget_single_element_viewfield_select_form_alter` (gated by the
    `use viewfield argument helper` permission) injects a **"Filtering options"** slots fieldset and
    attaches the `lookup` or `autocomplete` library plus `drupalSettings` module path.
- **`src/Lookup.php`** (service `viewfield_argument_helper.lookup`) — `getArgumentOptions($view_id,
  $display_id)` loads the view, `initHandlers()`, iterates `$view->argument` (contextual-filter
  plugins) and per slot:
  - `match` on plugin id: `string_list_field` → allowed-values list; default → entity lookup.
  - `guessEntityType()`: `taxonomy_index_tid`→`taxonomy_term`, `node_nid`→`node`; otherwise reads the
    referenced field definition's `target_type` / `handler_settings.target_bundles`.
  - `getAllowedBundles()`: intersects the argument validator's `bundles` with the field's target
    bundles, then `getEntities()` → `storage->loadByProperties()` → maps each to `id / name / label
    (label (bundle))`.
- **`src/Controller/LookupController.php`** — three JSON endpoints: `lookup` (renders a filterable
  table), `autocomplete` (value/label options), `slotInfo` (raw slot data).
- **`viewfield_argument_helper.routing.yml`** — the three data routes require
  `_permission: 'use viewfield argument helper'` and are `_admin_route`; the settings form requires
  `administer site configuration`.
- **`viewfield_argument_helper.api.php`** — five alter hooks: `_entity_type_alter`, `_bundles_alter`,
  `_entities_alter`, `_lookup_element_alter`, `_autocomplete_options_alter`.
- **Libraries** — `lookup` (jQuery table-filter) and `autocomplete` (Choices.js), both bundled.

## Config / permissions
- Config object `viewfield_argument_helper.settings` → single key `default_widget`
  (`lookup`|`autocomplete`). Schema in `config/schema/`.
- Permission **`use viewfield argument helper`** — gates the widget UI and all three JSON routes. Its
  own description states it lets a role "view IDs, labels, and bundles for entities ... even if they
  do not have permission to view those entities." Grant deliberately.

## Gotchas
- Purely editorial: no front-end output, no formatter, no auto-argument-injection.
- Depends on the `viewfield_select` widget specifically; no effect on other Viewfield widgets.
- Candidate lists reflect the view's **argument validation** config — loose validation = a large,
  unfiltered entity list.
- `LookupController::lookup` reads `$opt['bundle']`, but `Lookup::entityLabelMapper` never sets a
  `bundle` key (only `id`/`name`/`label`/`entity`), so the table's Bundle column is empty — cosmetic
  bug, not functional.
