Recurring Events Views replaces the default entity list builders for event series, event instances and registrations with configurable Views, so all listings become fully customizable with no extra setup.

---

Enabling this submodule swaps the hard-coded list builders for shipped Views: `views.view.recurring_events_event_instances` and `views.view.recurring_events_event_series` (config/install), plus an optional `views.view.recurring_events_registrations` (config/optional) when the registration submodule is present. It has no routes, services, permissions or settings of its own — it is pure Views configuration plus a small `.module` of glue. `hook_local_tasks_alter` re-points the per-instance registrations tab (and user registrations tab) to the registrations View when available. Because registration can be per-series or per-instance, `hook_views_query_alter` and `hook_views_pre_render` adjust the registrations View's query and title: for instance registration it filters to the current `eventinstance_id`, and for series registration to the parent `eventseries_id` (using the registration creation service's `getRegistrationType()`). Admin Views ship with sensible defaults and exposed filters; front-end series listings show only current/future events. The default Views can be freely customized afterward. Depends on `views` and `recurring_events`.

---

- Replace the default event series list with a customizable View.
- Replace the default event instances list with a customizable View.
- Replace the default registrations list with a View (when registration is enabled).
- Add exposed filters (date, type, status) to event listings without code.
- Show only current/future events on front-end series listings by default.
- Re-point the per-instance registrations tab to the registrations View.
- Correctly scope the registrations View for series-vs-instance registration.
- Retitle the registrations View per instance date or per series automatically.
- Customize columns, sorting and pagers of any events listing via the Views UI.
- Build admin dashboards of events/registrations from the provided base Views.
- Provide separate front-end and admin listing displays.
- Embed an events listing block using a View display.
- Add contextual filters to list a specific series' instances.
- Export the shipped Views as config and adapt them per site.
- Avoid writing custom list-builder code for event displays.
- Give editor roles tailored, permission-aware event listings.
