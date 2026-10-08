<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private file auto redirect (private_file_auto_redirect) — agent index

**Redirects requests for old/superseded private files to the latest file referenced by the media entity, so stale private-file URLs resolve to the current file instead of 404ing.**

- **Version:** 2.1.x
- **Core:** ^10.2 || ^11 (PHP 8.1)
- **Depends on:** drupal:media
- **Mechanism:** `src/Routing/RouteSubscriber.php` re-points the `system.private_file_download` and `system.files` route controllers to `PfarDownloadController::download`.
- **Controller:** `src/Controller/PfarDownloadController.php` (extends core `FileDownloadController`) loads the file by URI, finds the referencing media, compares revisions, and 302-redirects to the latest file — otherwise defers to core.
- **Routes/permissions:** no new routes, no new permissions, no config.

**Security:** No access bypass. The module never streams file bytes itself — every delivery path calls `parent::download()` (core `FileDownloadController`), so `hook_file_download`/private-file access is enforced on the file that is actually served, and the redirect target is re-checked on the follow-up request.