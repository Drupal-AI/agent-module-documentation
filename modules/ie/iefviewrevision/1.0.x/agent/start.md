<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Entity Form - View Revisions — agent index

Adds a **Revisions** link beside Edit/Remove in **Inline Entity Form** widgets. On-disk dir `iefviewrevision`; real machine name `ief_view_revision`. Version **1.0.2**. Core `^9 || ^10`.

- `ief_view_revision.module`: `hook_field_widget_form_alter()` injects `<a href="/node/{id}/revisions">` for each referenced entity.
- Depends on `inline_entity_form`. Security: link only — target route enforces core revision access; no bypass, `id` is integer.
