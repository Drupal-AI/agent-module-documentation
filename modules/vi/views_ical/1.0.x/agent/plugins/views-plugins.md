# Views iCal — Views plugins

These are plugins **for** core Views (they implement `@ViewsDisplay` / `@ViewsStyle` /
`@ViewsRow`); the module does **not** define a new plugin *type* of its own. You select them
in the Views UI, or they appear as `display_options` in the `views.view.*` config entity.

## Display

| id | Class | Notes |
|---|---|---|
| `ical` | `Plugin/views/display/IcalDisplay` (extends core `Feed`) | "iCal display". `uses_route = TRUE`, `returns_response = TRUE`. Adds a **`filename`** option; when set, `render()` adds a `Content-Disposition: attachment; filename="…"` header. Category relabelled "iCal Settings". |

## Style plugins (`display_types = {"feed"}`)

| id | Class | Notes |
|---|---|---|
| `ical_wizard` | `Plugin/views/style/IcalWizard` | **Recommended.** "iCal Style Wizard". Builds VEVENTs via `eluceo/ical`. Injected with `entity_field.manager` and the `views_ical.helper` service; its settings form maps view fields to iCal properties (uses `date_field` in options). `theme = views_view_icalwizard`. |
| `ical` | `Plugin/views/style/Ical` | "Legacy iCal style". `uses_row_plugin = TRUE`. Attaches an `application/calendar` alternate link. `theme = views_view_ical`. |

## Row plugins (`display_types = {"feed"}`, both extend core `Fields`)

| id | Class | Notes |
|---|---|---|
| `ical_fields_wizard` | `Plugin/views/row/IcalFieldsWizard` | **Recommended.** "iCal fields row wizard". Reads the style's `date_field` option, resolves the field's storage definition, and renders VEVENTs. Has optional integration with `smart_date` / `smart_date_recur` for recurring events. `theme = views_view_ical_fields`. |
| `ical_fields` | `Plugin/views/row/IcalFields` | "Legacy iCal Fields row". Thin subclass of core Fields; you label each field per RFC 5545. |

## Templates (theme hooks, overridable)

- `views-view-ical.html.twig` (`views_view_ical`) — legacy style; preprocess sets
  `text/calendar` header and the calendar title (view title or site name + slogan).
- `views-view-icalwizard.html.twig` (`views_view_icalwizard`) — wizard style.
- `views-view-ical-fields.html.twig` (`views_view_ical_fields`) — both row plugins.

## Service

- `views_ical.helper` → `Drupal\views_ical\ViewsIcalHelper` (`ViewsIcalHelperInterface`) —
  helper used by the wizard style/row to build event components; call `setView()` / `getHelper()`.

There is no configuration outside a view: to inspect a configured feed, read the view's config
(`drush config:get views.view.<id>`) and look at each display's `display_plugin`, `style.type`
and `row.type`.
