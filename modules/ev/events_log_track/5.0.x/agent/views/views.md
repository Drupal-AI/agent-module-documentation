# Views integration

`EventLogTrackViewHooks::viewsData()` (`hook_views_data`) exposes the `event_log_track` table
as a Views base table.

- **Base**: `event_log_track`, base field `lid`, group *Event Log Track*.
- **Implicit join**: to `users_field_data` on `uid`.
- **Relationship** `uid` → *User* (`users_field_data`).
- **Fields / filters / sorts / arguments** on: `lid` (numeric), `type` (standard; filter is
  `in_operator` with options callback `EventLogTrackApi::getHandlerOptions`), `operation`
  (standard; `in_operator` options callback `EventLogTrackApi::getHandlerOptionsOperations`),
  `ref_char` (string), `ref_numeric` (numeric), `description` (string), `ip` (string),
  `created` (date). So the *Type* and *Operation* exposed filters auto-list exactly the
  handlers/operations the enabled submodules registered.

## Bundled view

`config/optional/views.view.event_log_track.yml` provides view `event_log_track`:
- Page display at `admin/reports/events-track` (menu item under *Reports*).
- Access: permission `access event log track`.
- Table style, 25/page pager, DESC by `lid`; exposed filters for type, operation, user name,
  description, IP, ref_char, ref_numeric, and a `created` between/grouped date filter.
- Columns: LID, Type, Operation, Name (ref_char), ID (ref_numeric), Description, user Name, IP,
  Created. Empty text: "No events found."

Because it is in `config/optional`, the view is only installed when Views is enabled; it can be
freely re-arranged or cloned. Some submodules add extra Views relationships onto the base table
(e.g. `event_log_track_node` adds `elt_node_join` → `node_field_data`, `event_log_track_media`
adds `elt_media_join` → `media_field_data`), letting a view join the logged entity by
`ref_numeric` where `type` matches.
