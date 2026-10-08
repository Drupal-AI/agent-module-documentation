<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Noahs Page Builder (noahs_page_builder) — agent index

**Drag-and-drop visual page builder: edits entities via a live iframe editor built from Widget + Control plugins, persisting layouts as JSON with generated CSS.**

- **Version:** 3.0.x (project `noahs`, release 3.0.2)
- **Core:** ^10 || ^11
- **Admin:** `/admin/structure/noahs`, `/admin/structure/noahs/settings` (`Form\NoahsSettingsForm`), style/iframe settings.
- **Editor:** `/noahs_edit/{entity_type}/{entity}` + preview routes; save via `POST /noahs_page_builder/save_page`.
- **AJAX surface:** many `/noahs-admin/*` endpoints (widget render/form, modal media + upload, icons, tokens, URL autocomplete, media-image helpers, themes).
- **Plugin types:** Widget (`WidgetManager`) and Control (`ControlManager`); ~35 widgets, ~40 controls under `src/Plugin/{Widget,Control}`.
- **Storage:** custom tables `noahs_page_builder_page` (+ pro revisions); front-end render via `EventSubscriber\NoahsResponseSubscriber` + Twig.
- **Submodule:** `noahs_gallery` (gallery config entity + media widget).
- **Permission:** single `administer noahs_page_builder` gates everything.

**Security:** Every route requires `administer noahs_page_builder` — no anonymous or `_access: TRUE` routes; no anon mutation endpoints. DB writes use parameterized queries; settings cURL uses `CURLOPT_SSL_VERIFYPEER = TRUE`. **Watch:** the media upload endpoint has no extension/MIME allowlist and preserves the original extension (accepts SVG) — see report; and widgets render arbitrary CSS/HTML/plain-code to visitors, so the admin permission is effectively a full-HTML capability. `NoahsTrackController::trackUser` exists but has no route (unreachable).

See [configure/setup.md](configure/setup.md) and [plugins/widgets-controls.md](plugins/widgets-controls.md).
