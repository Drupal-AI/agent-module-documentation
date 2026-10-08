# ECA Helper — services

Defined in `eca_helper.services.yml`. These back the module's `.module` hooks; you rarely
call them directly, but they document the integration points.

## `eca_helper.file_download_manager` — `FileDownloadManager`
- Args: `@entity_type.manager`, `@eca.trigger_event`, `@current_user`.
- `onFileDownload(string $uri): array|int|null` is called from `hook_file_download()`.
  Only acts on `private://` URIs. Loads the `file` entity by URI, dispatches the
  `eca_helper_file_download:private_file` ECA event, then maps the model's access result:
  Forbidden → `-1` (deny), Allowed → `[]` (grant, no extra headers), otherwise `NULL`
  (abstain, let other modules decide). Access policy therefore lives in your ECA model.

## `eca_helper.page_attachment_alter` — `PageAttachmentAlter`
- `alter(array &$attachments, string $position)` called from `hook_page_attachments_alter`
  (`header`), `hook_page_top` (`top`) and `hook_page_bottom` (`bottom`). Reads tags queued
  by the `eca_helper_header_footer_tag` action (`HeaderFooterTag::$data[$position]`) and
  renders them: `markup` → `inline_template`, `script`/`style` → `html_tag`. Head items are
  added to `#attached['html_head']`.

## `eca_helper.messenger` — `Messenger` (decorator)
- `decorates: messenger`, priority 100, args `@eca_helper.messenger.inner`,
  `@eca.trigger_event`. Wraps core's messenger so that rendering status messages dispatches
  the `eca_helper` → `status_messages` event, enabling models to read/rewrite messages.

## Event subscribers
- `eca_helper.execution.config_subscriber` (`EcaExecutionPreProcessEventSubscriber`) — parent
  `eca.execution.subscriber_parent`; wires the preprocess event into ECA execution.
- `eca_helper.response_event_subscriber` (`ResponseSubscriber`) — applies queued response
  headers/cookies (`CookieHelper`) onto the outgoing `Response`.

## Preprocess & Quick Action extension points
- `hook_preprocess()` dispatches `eca_helper_preprocess_hook:preprocess` for every theme hook.
- `CookieHelper` (static) and `HeaderFooterTag::$data` are static stores the actions write to
  and the subscribers/services read from within a request.
- Quick Action callables live in `DRUPAL_ROOT/sites/eca/EcaActions.php` — see
  [../plugins/actions.md](../plugins/actions.md).
