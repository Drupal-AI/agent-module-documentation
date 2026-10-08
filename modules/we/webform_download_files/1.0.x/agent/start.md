<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Download Files — agent index

A **VBO action to download selected webform submissions' file attachments as a ZIP** (bulk-export uploads).
Depends on `webform`, `views_bulk_operations`. Version **1.0.3**. Core `^10||^11`.

**SECURITY CAVEAT:** the action's `access()` **returns TRUE unconditionally** (no independent per-submission/
per-file check — comment: "if the view can be accessed, no need for extra check"), and it zips files from the
**private** submission dir. So access to the **private (often sensitive) submission files rests ENTIRELY on
the VBO view's access config** — **restrict the view to trusted roles** (a loose view exposes private files).
ZIP is scoped to the selected submissions.
