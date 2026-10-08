# Log listing & CSV export (Views)

The module ships one View, config `views.view.elogger` (id **`elogger`**, base table `elog`),
installed from `config/install`.

| Display | Machine name | Type | Path / output |
|---------|--------------|------|---------------|
| Event logs (page) | `elogs` | page | `/admin/reports/elogger` — the admin log listing. |
| Data export | `eloger_export` | `data_export` (views_data_export) | attached export producing `elogger.csv`. |
| Master | `default` | default | base display. |

- The page listing shows the `elog` rows (message, event type, module, user, IP, etc. — field set
  from [../api/logger.md](../api/logger.md)) with exposed filters. `hook_form_alter` converts the
  exposed **module** and **event_type** filters into select dropdowns populated from
  `elogger.settings:modules` and the service's event types.
- `hook_views_pre_render` renders each row's stored `diff` into a diff table and `form_data` into a
  collapsible jsonpanel (library `elogger/elogger-jsonpanel`).
- **views_bulk_operations** provides bulk actions (e.g. bulk delete) on the listing;
  **views_data_export** provides the `elogger.csv` export display.
- Deleting an entry (`ElogDeleteForm`) redirects back to `view.elogger.elogs`.

Access to the page/listing is governed by the `view event log entity` permission
(see [../permissions/permissions.md](../permissions/permissions.md)).

The install file reimports this View in `elogger_update_9101`; `elogger_update_9103` added the
`ip` and `user_agent` base fields to the `elog` entity.
