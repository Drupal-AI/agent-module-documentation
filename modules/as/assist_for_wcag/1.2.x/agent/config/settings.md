<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & script injection

## Install / enable
```
composer require drupal/assist_for_wcag
drush en assist_for_wcag -y
```
No module dependencies; core only, PHP >= 8.1.

## Settings form
- Route: `assist_for_wcag.settings` → `/admin/config/user-interface/assist-for-wcag` (`assist_for_wcag.routing.yml`).
- Permission: `administer site configuration` (core). The module ships **no** `*.permissions.yml`.
- Form class: `Drupal\assist_for_wcag\Form\AssistForWcagSettingsForm` (extends `ConfigFormBase`, so CSRF form tokens are automatic).
  - `getFormId()` → `assist_for_wcag_settings_form`.
  - `getEditableConfigNames()` → `['assist_for_wcag.settings']`.
  - `buildForm()` renders one `token` textfield (`#default_value` from config). If a token is already set it also renders a `widget_link` markup item linking to the remote widget-config page.
  - `attachLibraries()` attaches the `assist_for_wcag/admin` CSS library.
  - `submitForm()` saves `trim($form_state->getValue('token'))` into `assist_for_wcag.settings:token`.
- Menu link: `assist_for_wcag.links.menu.yml` places it under `system.admin_config_ui` (Configuration > User interface), weight 100.

## Config object
- `assist_for_wcag.settings` with a single key `token` (string). Set/read only by the form and the page-attachments hook. No `config/install/*` default and no `config/schema/*` (so core may emit a schema-missing notice in tests; runtime is unaffected).
- Set via Drush: `drush config:set assist_for_wcag.settings token YOUR_TOKEN`.

## How the script is injected
`assist_for_wcag_page_attachments(array &$attachments)` in `assist_for_wcag.module`:
1. Returns early if `router.admin_context`->`isAdminRoute()` is TRUE (never loads on admin pages).
2. Reads `trim($config->get('token'))` from `assist_for_wcag.settings`.
3. If the token is non-empty, appends to `$attachments['#attached']['html_head']` a `script` element:
   `src = "https://dockaccess.org/accessibility/{$token}/start.js"`, `defer => TRUE`, keyed `assist_for_wcag_script`.

The widget is loaded and executed client-side by the visitor's browser; Drupal makes no server-side HTTP request to dockaccess.org. Clearing the token removes the script on the next cache rebuild.

## Libraries
- `assist_for_wcag/admin` (`assist_for_wcag.libraries.yml`) — theme CSS `css/admin.css` only; light styling for the settings form. No JS library is bundled (the widget JS is remote).

## Operating notes
- Requires outbound HTTPS from the visitor's browser to `dockaccess.org` and a valid token from that service.
- No entities, services, plugins, or Drush commands are provided.
- Uninstalling removes the config and stops the injection; no residual markup remains.
