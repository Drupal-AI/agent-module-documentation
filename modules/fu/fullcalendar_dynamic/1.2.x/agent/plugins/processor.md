# Fullcalendar Dynamic — processor plugin, AJAX event source, services

## Processor plugin type
`fullcalendar_dynamic.services.yml` registers a plugin manager
`plugin.manager.fullcalendar_dynamic_processor` →
`Drupal\fullcalendar_dynamic\Plugin\FullcalendarViewProcessorManager` (extends `DefaultPluginManager`):

- Discovery subdir: `Plugin/FullcalendarViewProcessor`.
- Alter hook: `fullcalendar_view_fullcalendar_view_processor_info`.
- Cache key: `fullcalendar_view_fullcalendar_view_processor_plugins`.
- **Note (inherited from the upstream `fullcalendar_view` project):** the manager is constructed with
  interface `Drupal\fullcalendar_view\Plugin\FullcalendarViewProcessorInterface` and annotation
  `Drupal\fullcalendar_view\Annotation\FullcalendarViewProcessor` — i.e. it references the
  `fullcalendar_view` namespace, not `fullcalendar_dynamic`. Those base classes ship with the separate
  `fullcalendar_view` module. In a plain `fullcalendar_dynamic`-only install there are no such plugins,
  so this plugin type is effectively vestigial unless you also provide those base classes/annotation.
  Instances (when present) run via a `process()` call from
  `template_preprocess_views_view_fullcalendar_enanced()`.

For most integrations, prefer altering the View style options or the event data in a preprocess hook
over implementing this plugin type.

## AJAX event source route
`/fullcalendar-view/events` (route `fullcalendar_dynamic.event_source`, `_access: 'TRUE'`) →
`CalendarEventSourceController::ajaxView(Request)` (extends core `views\Controller\ViewAjaxController`).
It mirrors core's Views AJAX controller:

- reads POST `view_name`, `view_display_id`, `view_args`, `view_path`, `view_dom_id`, `pager_element`,
  plus FullCalendar's `start` / `end` / `timeZone`;
- loads the View entity (404 if missing) and **enforces access**: it only renders when
  `$view->access($display_id)` is TRUE, otherwise throws `AccessDeniedHttpException` (403). So although
  the route itself is open (like core `views.ajax`), the View display's own access plugin governs
  what is returned.
- If the style has a `date_filter`, it injects a `datetime` **between** filter with the request's
  `start`/`end` as min/max so only events in the visible window are queried, then `$view->preview()`s
  the display and returns the events built by `fullcalendar_dynamic.view_preprocess`->`prepareEntries()`
  as a `JsonResponse`.

(Security note: the View arguments arrive from the request and are passed to `$view->preview()` exactly
as core's Views AJAX controller does — core binds contextual arguments as query placeholders. The
`start`/`end` values feed a standard datetime filter value. No SQL is hand-built here.)

## Helper services
| Service | Class | Role |
|---|---|---|
| `fullcalendar_dynamic.timezone_conversion_service` | `TimezoneService` | Convert stored datetimes to display timezone. |
| `fullcalendar_dynamic.taxonomy_color` | `TaxonomyColor` (needs `entity_type.manager`) | Resolve term → color for event coloring. |
| `fullcalendar_dynamic.view_preprocess` | `FullcalendarViewPreprocess` | Build event array + `drupalSettings.fullCalendarView`. |
