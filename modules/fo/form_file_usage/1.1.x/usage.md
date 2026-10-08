<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form File Usage automatically manages the permanent status and file-usage records for managed_file and text_format elements within custom forms.

---

Form File Usage automatically manages file lifecycle for custom forms — when a custom (non-entity)
form uses `managed_file` or `text_format` (embedded files) elements, it marks the uploaded files permanent
and records file-usage, so they aren't garbage-collected as temporary and orphaned. This fixes the common
developer pitfall where files uploaded via custom forms disappear because nothing registered their usage.
It depends on core File and is in the Core package.

Use it when building custom forms (config forms, custom submissions) that accept file uploads and need
those files retained. It is a developer/file-management utility operating on file usage; it has no
content or access role. Apply it to the relevant custom forms.

---

- Manage file usage in custom forms.
- Mark uploaded files permanent.
- Record file-usage for managed_file.
- Handle text_format embedded files.
- Prevent orphaned/GC'd uploads.
- Depend on core File.
- Fix the custom-form file pitfall.
- Retain files from custom forms.
- Have no content/access role.
- Apply to custom forms.
- Register file usage automatically.
- Keep uploaded files.
- Avoid temporary-file garbage collection.
- Support config-form uploads.
- Manage file lifecycle.
- Track embedded files.
- Retain form-uploaded files.
- Handle managed_file elements.
- Register usage records.
- Prevent file loss.
