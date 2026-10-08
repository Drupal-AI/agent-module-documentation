<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mercury Editor Templates — agent index

Adds reusable **section templates** to Mercury Editor via a `me_template` **content entity**.
Editors save a Layout Paragraphs component as a template and re-insert it. Depends on
`mercury_editor`. No config schema (templates are content, not config); ships **seven
permissions**.

- **The `me_template` entity, its routes/paths, save-as/insert flow, Field UI, drush** →
  [configure/templates.md](configure/templates.md)
- **The seven permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts: entity type id `me_template`; collection `/admin/content/me-template`; add
`/me-template/add`; bundle/settings route `entity.me_template.settings`
(`/admin/structure/me-template`, permission "administer mercury editor template"); published
templates are injected into the Mercury add-component menu for users with **"use mercury editor
templates"** through a `LayoutParagraphsAllowedTypesEvent` subscriber.
