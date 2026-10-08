# API — manager service, entity, and the download route

This is the programmatic/runtime surface: the service that looks up download records, the
`webform_protected_downloads` content entity, the route/controller that streams the file, and the
hooks that create records and expose the token.

## Service `webform_protected_downloads.manager`

Class `WebformProtectedDownloadsManager` (`src/WebformProtectedDownloadsManager.php`), interface
`WebformProtectedDownloadsManagerInterface`. Constructor takes `@entity_type.manager`.

```php
$manager = \Drupal::service('webform_protected_downloads.manager');

// Look up a download record by its link hash. Returns the entity or FALSE.
$record = $manager->getSubmissionByHash($hash);

// Look up by the referenced submission's UUID, optionally narrowing to one handler id.
// Skips records whose handler is gone/disabled or no longer references the same file
// (validated via $entity->getHandler()). Returns the entity or FALSE.
$record = $manager->getSubmissionByUuid($submission_uuid, 'webform_protected_downloads');
```

Both methods run entity queries with `accessCheck(TRUE)`. `getSubmissionByUuid()` matches on
`webform_submission.entity.uuid` and returns the first record whose handler still validates;
`getSubmissionByHash()` matches on the `hash` field and loads the single result.

## Entity `webform_protected_downloads`

`ContentEntityType` (`src/Entity/WebformProtectedDownloads.php`), `base_table
"webform_protected_downloads"`, entity key `id`. Created by
`hook_webform_submission_insert()`; removed as a type on uninstall
(`hook_uninstall` → `uninstallEntityType`).

Base fields (`baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `webform_submission` | entity_reference → `webform_submission` | Required. The submission that unlocked the file. |
| `handler_id` | string | Required. The handler instance id on the webform. |
| `file` | entity_reference → `file` (cardinality UNLIMITED) | Required. The served file. |
| `hash` | string | Required. The opaque path segment used in the download URL. |
| `active` | boolean | Default FALSE. Set FALSE after a one-time link is used. |
| `expire` | integer | Required. Unix timestamp when the link expires; `0` = never. |
| `onetime` | boolean | Required, default FALSE. Whether the link deactivates after first use. |

Methods:

| Method | Returns | Purpose |
|---|---|---|
| `getWebformSubmission()` | `WebformSubmissionInterface\|null` | The referenced submission. |
| `getHash()` | `string\|null` | The link hash. |
| `getHandler(bool $verify_file = TRUE)` | `WebformHandlerInterface\|null` | The handler if it exists and is enabled; when `$verify_file` is TRUE it also checks the handler still references this record's file. |
| `isActive()` | `bool` | The `active` flag. |
| `isOneTimeLink()` | `bool` | The `onetime` flag. |
| `getUrl()` | `GeneratedUrl\|string\|null` | Absolute URL of route `webform_protected_downloads.download` for this record's hash. |

## Download route & controller

Route `webform_protected_downloads.download`
(`webform_protected_downloads.routing.yml`):

- path `/webform_protected_file/{hash}/download`
- `_controller: WebformProtectedDownloadsController::protectedFileDownload`
- `requirements: { _permission: 'access content' }`

`protectedFileDownload(string $hash)` flow
(`src/Controller/WebformProtectedDownloadsController.php`):

1. `getSubmissionByHash($hash)` to load the record.
2. Compute `$expired = (expire < time() && expire != 0)`.
3. Load the handler via `getHandler(FALSE)` and read its settings. If `verify_access` is set and
   is not `basic`, run the owner / view-submission checks (`$submission->isOwner($currentUser)`,
   `$submission->access('view')`) for the chosen level; a failed check forces `$expired = TRUE`.
4. If there is no record, no settings, the record is not `active`, it is `$expired`, has no
   `file` target, or `file.target_id` no longer equals the handler's current
   `protected_file` — take the failure branch: flash `expiration_error_message` (if set) and
   redirect per `expiration_page` (`homepage` → `<front>`; `page_reload` → the webform URL;
   `custom` → `expiration_page_custom` via `TrustedRedirectResponse` for external URLs or
   `RedirectResponse` via `Url::fromUserInput` for internal paths; otherwise a
   `NotFoundHttpException`).
5. Otherwise stream the file with `sendProtectedFileResponse()`: a `BinaryFileResponse` on the
   file's URI with `Content-Type`, `Content-Length`, `Content-Disposition: attachment` and
   `Cache-Control: private`.
6. If the record `isOneTimeLink()`, set `active = FALSE` and save before returning.

## Record creation & token hooks (`webform_protected_downloads.module`)

- `hook_webform_submission_insert()` — on submission insert, for each **enabled**
  `webform_protected_downloads` handler that has a `protected_file`, loads the file and creates a
  `WebformProtectedDownloads` entity with `active = TRUE`, `expire = time() + expiration_time*60`
  (or `0`), `onetime = expiration_one_time`, and a generated `hash` used as the download URL's path
  segment. Runs before other handlers (e.g. emails) so the token resolves for them. See
  [configure/handler.md](../configure/handler.md) for the `verify_access` levels the download
  controller applies.
- `hook_token_info()` / `hook_tokens()` — register and replace
  `[webform_submission:protected_download_url]` (dynamic, so a handler id sub-token is supported).
  Replacement resolves via `getSubmissionByUuid()` → entity `getUrl()`.
- `hook_theme()` — `webform_handler_webform_protected_downloads_summary`
  (`templates/webform-handler-webform-protected-downloads-summary.html.twig`), the handler's
  settings summary shown on the handlers list.
