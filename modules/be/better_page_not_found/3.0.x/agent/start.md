<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Page Not Found (better_page_not_found) — agent index

Presentation-only module that restyles Drupal core's **401 / 403 / 404 error pages**. On those
routes it replaces the page **content region** with a themed message + a homepage (or login) button,
leaving the surrounding theme intact. Version **3.0.1**. Core `^8 || ^9 || ^10 || ^11`. No dependencies.

## What it does (source facts)
- `better_page_not_found.module`:
  - `hook_preprocess_page` (`better_page_not_found_preprocess_page`) — switches on the route name
    (`system.401`, `system.403`, `system.404`) and overwrites `$variables['page']['content']` with a
    `#theme => 'better_system_message'` render array. Messages are **hardcoded `t()` strings**
    ("The requested page could not be found." for 404; "Sorry, you are not authorized to access this
    page." for 401/403). The requested URL/path is **not** reflected into the output.
  - `hook_theme` — registers the `better_system_message` theme (`text`, `button_text`,
    `button_target` variables; template `better-system-message`).
  - `hook_page_attachments` — attaches the `better_page_not_found/css` library only on the three error
    routes.
  - `hook_help` — short About text.
- Template `templates/better-system-message.html.twig` — renders `text`, and an `<a>` whose href is
  `button_target` (only ever the hardcoded `/` or `/user/login`).
- Library `better_page_not_found/css` → `css/better-page-not-found.css` (classes `.c-system-message`,
  `.c-system-message__text`, `.c-system-message__button`).

## Config / routes
- Config object: `better_page_not_found.settings`, one key `access_denied_button_target`
  (`homepage` | `login`; default `homepage`). No config/schema or config/install shipped.
- Settings form: `\Drupal\better_page_not_found\Form\BetterPageNotFoundSettingsForm`
  (`ConfigFormBase`), route `better_page_not_found.settings` at
  `/admin/config/user-interface/better-page-not-found`, permission `administer site configuration`.
  Menu link in `better_page_not_found.links.menu.yml` under `system.admin_config_ui`.

## Provides
- No entities, no permissions, no services, no plugins, no Drush. Only the one hook-based preprocess,
  a theme hook, a settings form and a CSS library.

## Solution docs
- Config & behavior: [agent/config/settings.md](config/settings.md)
