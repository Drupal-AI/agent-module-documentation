<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# DXPR Builder — agent index

Commercial front-end drag-and-drop page builder. You turn a text field into a visual editor by
setting its display formatter to **DXPR Builder** (`dxpr_builder_text`). Admin lives under
**DXPR Studio** (`/admin/dxpr_studio/dxpr_builder`); `configure: dxpr_builder.settings`.
Depends on `field`, `field_ui`, `views`, `image`, `block`; suggests `key`.

**Licensing note:** the live editor requires a valid JWT/API key and per-user "billable user"
access (`DxprBuilderLicenseService`). Without a key the editor will not fully load, but all
config below (settings, profiles, templates, the formatter) is inspectable/creatable normally.

- **Global settings (`dxpr_builder.settings`), JWT/Key storage, AI settings** →
  [configure/settings.md](configure/settings.md)
- **Enable the builder on a field (the `dxpr_builder_text` formatter) + config entities
  (profiles, page/user templates)** → [configure/builder-and-entities.md](configure/builder-and-entities.md)
- **Permissions (edit / administer / profile)** → [permissions/permissions.md](permissions/permissions.md)
- **Services, Block/Action/Views plugins, content lock** → [api/services-plugins.md](api/services-plugins.md)
- **Hooks to extend classes & button styles** → [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs): `dxpr_builder_page` (drag-and-drop content type), `dxpr_builder_block`
(drag-and-drop block type), `dxpr_builder_media` (media browser).

Key facts:
- Formatter id `dxpr_builder_text`; field types `text`, `text_long`, `text_with_summary`.
- Config entities: `dxpr_builder_profile`, `dxpr_builder_page_template`, `dxpr_builder_user_template`.
- Permissions: `edit with dxpr builder`, `administer dxpr builder configuration`,
  `administer dxpr_builder_profile`.
