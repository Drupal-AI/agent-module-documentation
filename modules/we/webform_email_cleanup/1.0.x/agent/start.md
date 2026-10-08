<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Email Cleanup (webform_email_cleanup) — agent index

**Deletes uploaded attachment files under `private://webform/<id>/` after the last triggered email handler of a selected webform sends.**

- **Version:** 1.0.x — core `^10 || ^11`; depends on `webform`. Requires a configured private file system.
- **Mechanism:** `@WebformHandler(id="email")` extends core `EmailWebformHandler`; after `sendMessage()` succeeds and if the current handler is the last *triggered* email handler (by weight, respecting disabled/conditions) and the webform is selected, runs cleanup.
- **Cleanup:** `file_system->delete()/deleteRecursive()` on files/subdirs of `private://webform/<machine-name>/`; no-op (warning) if private FS not configured; does not remove managed-file DB entities.
- **Config:** `/admin/config/content/webform-email-cleanup` (`administer webform`) — checkbox list of webforms.
- **Security:** operates only within the webform's own private directory; enabling **replaces the core email handler** (clear cache after enabling). Admin-gated; no anonymous endpoints. No mail is constructed here (no header-injection surface).
