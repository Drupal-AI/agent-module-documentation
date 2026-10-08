<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Content Guide

## Global settings
`/admin/config/content/content_guide` (`administer content guide`) → config `cg.settings`, key `document_base_path` (relative to DRUPAL_ROOT). Markdown guide files live under this directory.

## Attaching a guide to a field
On the entity's **Manage form display**, open a widget's third-party settings (provided by `cg_field_widget_third_party_settings_form`) and set the guide **document path**. An autocomplete (`/content-guide/files/autocomplete`) lists `.md` files under the base path. The widget then attaches JS that fetches the guide.

## Runtime fetch
JS calls `GET /content-guide/{langcode}` with headers:
- `X-CSRF-Token` — token validated against the identifier
- `X-CG-Identifier` — the field identifier the token is bound to
- `X-CG-Document-Path` — the document to render

The controller renders the Markdown (Parsedown), resolves internal `href`s to site URLs, and returns `Xss::filterAdmin()`ed HTML. If `name.{langcode}.md` exists it is served instead of `name.md`.

## Extending
- Alter which document/settings are used with `hook_cg_controller_widget_settings_alter()` or the `AlterControllerWidgetSettings` event.
- The `cg_field_group` submodule wires guides into Field Group.
