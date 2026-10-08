<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mercury Editor Task (mercury_editor_task) — agent index

**Adds a dedicated 'Mercury Editor' node task/tab plus a settings form that tunes the page-building editing experience.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Depends on:** mercury_editor
- **Routes:** `mercury_editor_task.settings` (`/admin/config/content/mercury-editor/task`, perm `administer site configuration`); `entity.node.mercury_editor_task` (`/node/{node}/mercury-editor`, custom access → node edit access)
- **Services:** form_display_builder, form_alter (config.factory), inline_entity_form manager, content-translation event subscriber
- **Configure:** `mercury_editor_task.settings`

**Security:** Admin settings route is permission-gated (`administer site configuration`); the per-node editor route uses a custom access check that resolves to normal node edit access. No anonymous or mutating public endpoints.

See [configure/settings.md](configure/settings.md)
