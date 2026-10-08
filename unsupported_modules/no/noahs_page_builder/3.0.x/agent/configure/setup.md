<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring & operating Noahs Page Builder

## Permission
One permission controls the entire module: **`administer noahs_page_builder`** ("Administer Noahs"). It gates the admin pages, the editor/preview, every `/noahs-admin/*` AJAX endpoint, media upload, and the `save_page` mutation. It is **not** marked `restrict access: true` even though it allows arbitrary file upload and arbitrary CSS/HTML that renders to anonymous visitors — grant it only to fully trusted editors.

## Admin routes (all require `administer noahs_page_builder`)
- `/admin/structure/noahs` — landing/admin page.
- `/admin/structure/noahs/settings` — `Form\NoahsSettingsForm` (global settings; includes an outbound HTTP check that uses `CURLOPT_SSL_VERIFYPEER = TRUE`).
- `/admin/structure/noahs/settings_styles` — style editor.
- `/admin/structure/noahs/settings_iframe` — iframe settings.
- `/admin/structure/noahs_page_builder/icons` — available icons.

## Editing an entity
1. Open a node (or commerce product) and use the **Edit with Noahs** local task, or go directly to `/noahs_edit/{entity_type}/{entity}`.
2. Drag Widgets in from the palette; select a widget to edit its Controls (spacing, color, background, typography, borders, etc.).
3. The builder calls `/noahs-admin/*` endpoints to fetch widget forms/renders, modal media, tokens and icons.
4. Saving issues `POST /noahs_page_builder/save_page` with a JSON body (`noahs_id`, `entity_id`, `entity_type`, `settings`, `page_settings`, `css`, `language`); layout is written to `noahs_page_builder_page` and CSS is generated. Revisions are kept only if `noahs_page_builder_pro` is installed.

## Media upload note
`/noahs-admin/noahs_page_builder/upload_file` (`NoahsModalMediaController::uploadMediaModal`) saves uploaded files to `public://YYYY-MM/`, keeping the sanitised original filename **and its extension**, with no extension/MIME allowlist (SVG is explicitly accepted and stored). Its only protection is the admin permission.

## Front-end rendering
`EventSubscriber\NoahsResponseSubscriber` (with `file_url_generator`, `path.current`, `request_stack`) injects the built layout/CSS on matching routes; output is themed via the module's Twig templates. This path is read-only for visitors.
