<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Development Assistant (development_assistant) — agent index

Lightweight production companion to the **Browser Development** (`browser_development`) project. Browser Development is an in-browser CSS authoring tool that compiles a stylesheet and stores config in the DB; Development Assistant is the thin runtime shim that re-attaches that compiled stylesheet on the front end so styling survives after the editor is uninstalled on production.

## What it is
- Module type: `module`, package `Browser Development`.
- `core_version_requirement: ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `2.0.x` (installed release `2.0.0-alpha3`).
- No declared module dependencies, no Composer requirements, no libraries.
- Not covered by the security advisory policy (`not-covered`).

## What it provides
- **No routes, no permissions, no services, no config schema, no plugins, no Drush commands.**
- `hook_page_attachments_alter()` in `development_assistant.module` — the only active behaviour: on the default (front-end) theme it attaches an `html_head` stylesheet `<link>` to `/sites/default/files/browser-development/css/browser-development.css` (href built by `_development_assistant_create_link_url()`).
- `hook_module_implements_alter()` — re-orders this module's `preprocess_html` implementation to run last.
- `hook_help()` for `help.page.development_assistant`.
- `src/Form/Settings.php` (`Drupal\development_assistant\Form\Settings`) — a `FormBase` scaffold with one `api_uri` checkbox. **Not attached to any route** in this release.
- `src/Processing/FormsStorage.php` (`Drupal\development_assistant\Processing\FormsStorage`) — static helper reading/writing the `form_input` key of the `development_assistant.settings` config object.

## Coupling note
`Settings::buildForm()` imports `Drupal\browser_development\Processing\FormsStorage` (the sibling project's class). Because the form is unrouted, this coupling is never exercised at runtime; the module functions standalone via its hooks even when `browser_development` is absent.

## Solution docs
- [Front-end stylesheet attachment](frontend/stylesheet-attachment.md) — the page-attachments hook, the CSS path, the theme condition, and hook ordering.
- [Settings form & config storage](config/settings.md) — the unrouted `Settings` form, `FormsStorage`, and the `development_assistant.settings` config object.
