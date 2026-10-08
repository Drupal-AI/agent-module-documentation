# Event subscriber: ExportRedirectSubscriber

Service `xls_views_data_export.export_redirect` (registered in
`xls_views_data_export.services.yml`, constructed with `@current_route_match`):

```
Drupal\xls_views_data_export\EventSubscriber\ExportRedirectSubscriber
```

Subscribes to `KernelEvents::REQUEST` at priority **-64** (chosen so it runs after the route match
is resolved and request formats are populated).

## What it does

`exportRedirect(RequestEvent $event)` fires on every request but acts only when the matched route is
an export route, i.e. the route name equals `view.<view_id>.<display_id>.export` (with both
`view_id` and `display_id` route parameters set — these are present when the display used the default
route layout rather than the flipped one).

When it matches, it:

1. rebuilds the view arguments from the route's `_view_argument_map` option (same logic as
   `XlsExportForm::getViewArgs()`);
2. loads the `_excel_file` route parameter as a `File` entity and keeps it only if its MIME type maps
   to an `xls`/`xlsx` format;
3. cleans `_worksheet_name` (strips `* \ / : ? [ ]`, trims) and reads the `_override_sheet` flag;
4. if a worksheet name and a file are both present, attaches `_excel_file` / `_worksheet_name` /
   `_override_sheet` to the args and sets the event response to
   `XlsDataExport::buildResponse($view_id, $display_id, $args)`.

Effect: when a preset default template + worksheet name are configured on the display, hitting the
export URL directly returns the merged workbook immediately, bypassing the upload form. If the
template or worksheet name is missing, the subscriber does nothing and the normal export form
(`XlsExportForm`) is shown so the user can supply them.

Access to this path is enforced by the route's own access requirements (inherited from the view's
access plugin in `getExportRoute()`); the subscriber runs after access checking.
