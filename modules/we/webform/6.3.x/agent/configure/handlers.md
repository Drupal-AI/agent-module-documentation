# Handle submissions (handlers, confirmations, export)

**Handlers** (WebformHandler plugins) run when a submission is created/updated/deleted. Configure
per form at `/admin/structure/webform/manage/<id>/handlers`. Stored under the webform's
`handlers:` config key.

The Handlers tab (Contact form shows the default email handler); "Add handler" lists the plugins below:
![Webform handlers](../../../../../../../screenshots/webform/6.3.x/handlers.png)

## Built-in handlers (`src/Plugin/WebformHandler/`)
- **EmailWebformHandler** (`email`) — send notification/confirmation email. Configure To/From/
  Reply-to (tokens allowed, e.g. `[webform_submission:values:email:raw]`), subject, body
  (text or HTML), attachments, and conditional sending. Add multiple for admin + autoresponder.
- **RemotePostWebformHandler** (`remote_post`) — POST/PUT/GET submission data to an external URL
  (JSON or form params) on insert/update/delete; map fields, add custom headers, handle the
  response, and message on error. Used for CRM/webhook/API integrations.
- **ActionWebformHandler** (`action`) — set submission data / change state (e.g. lock, sticky).
- **SettingsWebformHandler** (`settings`) — override form settings conditionally.
- **DebugWebformHandler** (`debug`) — dump the serialized submission for development.

## Confirmation
Form **Settings → Confirmation**: choose type (page, inline, message, modal, URL, none),
message (tokens supported), and redirect URL.

## Export results
`/admin/structure/webform/manage/<id>/results/download` or
`drush webform:export <id>` — exporters are WebformExporter plugins:
- `delimited` (CSV/TSV), `table` (HTML), `json`, `yaml`; PDF/DOCX via `webform_entity_print`.
- Options: delimiter, multiple-value handling, header format, file uploads, batching.

To add your own handler or exporter see [../plugins/plugins.md](../plugins/plugins.md).
