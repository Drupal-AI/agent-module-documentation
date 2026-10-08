<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture (how the editor is wired)

Mercury Editor has no plugin types and no public "API" service to call for content; it works by
**replacing forms, routes and AJAX/dialog behaviour**. The pieces an agent needs to know:

## Form replacement

`mercury_editor_entity_type_build()` (hook) adds a `mercury_editor` form handler to supported
entity types — `MercuryEditorNodeForm`, `MercuryEditorTermForm`, `MercuryEditorBlockContentForm`.
The `mercury_editor.controller.entity_form` service **decorates** `controller.entity_form` so the
edit operation routes into the Mercury edit screen for enabled bundles. Whether a bundle is
enabled is read from `mercury_editor.settings` → `bundles`.

## Routes (see mercury_editor.routing.yml)

- `mercury_editor.editor` — `/mercury-editor/{mercury_editor_entity}` — the full edit screen
  (custom access via `MercuryEditorController::access`, `_hide_admin_toolbar`).
- `mercury_editor.builder.*` — insert / edit_item / duplicate_item / delete_item /
  choose_component — Mercury replacements for the Layout Paragraphs builder routes, all keyed on
  `{layout_paragraphs_layout}` from the LP tempstore and gated by
  `_layout_paragraphs_builder_access`.
- `mercury_editor.settings|skip_form_settings|menu_settings|dialog_settings` — the config forms.
- `route_callbacks: mercury_editor.preview_routes_subscriber:routes` adds preview routes; the
  taxonomy term add/edit routes are overridden to use the builder.

## Key services (mercury_editor.services.yml)

| Service | Role |
|---|---|
| `mercury_editor.tempstore_repository` (`MercuryEditorTempstore`) | Private tempstore holding the in-progress entity before save. |
| `mercury_editor.context` (`MercuryEditorContextService`) | Answers "are we in the editor / preview?", exposes the edited entity + LP layout. |
| `mercury_editor.param_converter` | Converts `{mercury_editor_entity}` route param to a live/tempstore entity. |
| `mercury_editor.theme.negotiator` | Applies `edit_screen_theme` to the editor screen. |
| `mercury_editor.iframe_ajax_response_wrapper` | Wraps AJAX responses so preview renders inside the iframe. |
| `mercury_editor.dialog` (`DialogService`) | Reads `dialog_settings` for component modals. |
| `mercury_editor.http_middleware.ajax_page_state` | Fixes ajax_page_state for iframe requests. |

## Dialog system

`mercury_editor_ajax_render_alter()` rewrites core's `openDialog`/`closeDialog` AJAX commands to
`openMercuryDialog`/`closeMercuryDialog` on Mercury routes (or when `me_id` query is present), so
component edit forms open in Mercury's own tray/dialog rather than core modals.

## Extension points

There is no `.api.php`. Integration is via the standard Layout Paragraphs / Style Options APIs
and the many `hook_preprocess_*` / `hook_*_alter` implementations in `mercury_editor.module`
(e.g. `hook_library_info_alter`, `hook_theme_suggestions_*`, `hook_entity_build_defaults_alter`).
To add reusable section templates use the **mercury_editor_templates** submodule instead of
coding against Mercury directly.
