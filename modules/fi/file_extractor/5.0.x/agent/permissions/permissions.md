<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `file_extractor.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `file_extractor_administer_settings` | **true** | Access to both `/admin/config/media/file-extractor` (settings form) and `/admin/config/media/file-extractor/test` (test form) — i.e. choosing the extraction method and, crucially, the **binary/interpreter/host paths** the CLI extractors execute. |

Notes:
- This is the only permission the module defines. It is `restrict access: true`, so it is meant only for
  trusted administrators — appropriate, since the settings control which local binaries are executed.
- There is no separate per-field or per-content permission; whether a given file's extracted text is
  shown is governed by normal file/field/entity view access plus the extraction settings
  (excluded extensions, size, private-file exclusion) and any `FileIndexableEvent` subscribers.
