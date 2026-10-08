<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Email Cleanup removes uploaded webform attachment files from `private://webform/<webform-id>/` once the last triggered email handler has sent, so temporary attachment files are not left on disk.
---
The module overrides the core Webform email handler by shipping a `@WebformHandler` plugin that reuses the same id (`email`) and extends `EmailWebformHandler`. After `parent::sendMessage()` succeeds it determines the last email handler that actually ran for this submission — iterating the webform's email handlers, skipping disabled ones and those whose conditions fail, and picking the highest weight (`getLastTriggeredEmailHandlerId()`). Only when the current handler is that last one, and the webform is in the module's cleanup list, does it run cleanup, so attachments survive until every email that needs them has been sent.

Cleanup (`cleanupAttachmentFiles()`) resolves `private://` to a real path, and if the private filesystem is configured deletes the files and subdirectories under `.../webform/<webform-machine-name>/` using the file_system service (`delete()` / `deleteRecursive()`), logging counts and errors and showing a status message. If the private filesystem is not configured it logs a warning and does nothing. It removes files from disk but does not delete managed-file entities from the database. Selection is admin-configured at `/admin/config/content/webform-email-cleanup` (permission `administer webform`).

Setup: ensure a private file system is configured, enable the module (clear cache so the email-handler override applies), then on the settings form check the webforms whose uploaded attachments should be purged after their last email sends.

---

- Delete uploaded webform attachments after the last email sends
- Purge files from private://webform/<id>/ post-delivery
- Avoid leaving temporary attachment files on disk
- Select which webforms run attachment cleanup
- Run cleanup only after the last triggered email handler by weight
- Respect handler conditions when deciding the last email handler
- Skip disabled email handlers when determining cleanup timing
- Keep attachments until every email that needs them has sent
- Reduce private-directory storage growth from webform uploads
- Support GDPR-style minimization of stored submission files
- Configure cleanup targets at /admin/config/content/webform-email-cleanup
- Restrict configuration to the administer webform permission
- Log cleanup counts and errors to the webform logger
- No-op safely when the private file system is not configured
- Override the core Webform email handler transparently (same id)
- Clear cache after enabling so the handler override applies
