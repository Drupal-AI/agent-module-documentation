<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Page Not Found — configuration & behavior

## Install / enable
```
composer require drupal/better_page_not_found
drush en better_page_not_found -y
```
No dependencies beyond Drupal core (`^8 || ^9 || ^10 || ^11`). Works immediately after enable — no
configuration is required for the default (homepage-button) behavior.

## Runtime behavior (`better_page_not_found.module`)
`better_page_not_found_preprocess_page(&$variables)` reads
`\Drupal::routeMatch()->getRouteName()` and acts only on three routes:

| Route | Message (hardcoded `t()`) | Default button |
|-------|---------------------------|----------------|
| `system.404` | `The requested page could not be found.` | Go to homepage → `/` |
| `system.403` | `Sorry, you are not authorized to access this page.` | Go to homepage → `/` (or login) |
| `system.401` | `Sorry, you are not authorized to access this page.` | Go to homepage → `/` (or login) |

For each it sets `$variables['page']['content']` to:
```php
[
  '#theme' => 'better_system_message',
  '#text' => t(...),
  '#button_text' => $button_text,
  '#button_target' => $button_target,
]
```
Only the content region is replaced; header/footer/theme remain. The message strings and the button
targets are literal constants in the module code — no request data is interpolated. The 404 branch
always uses the homepage button; only the 401 and 403 branches consult the setting below.

`better_page_not_found_theme()` registers the `better_system_message` theme (template
`templates/better-system-message.html.twig`), which outputs the text in a `<p>` and the button as an
`<a href="{{ button_target }}">`.

`better_page_not_found_page_attachments(&$page)` attaches library `better_page_not_found/css` when the
route is one of `system.401`, `system.403`, `system.404`. The library
(`better_page_not_found.libraries.yml` → `css/better-page-not-found.css`) styles
`.c-system-message`, `.c-system-message__text`, `.c-system-message__button` — override these in a
custom theme to restyle.

## Settings form
- Class: `\Drupal\better_page_not_found\Form\BetterPageNotFoundSettingsForm` extends `ConfigFormBase`.
- Form id: `better_page_not_found_settings`. Editable config: `better_page_not_found.settings`.
- Route `better_page_not_found.settings` — path `/admin/config/user-interface/better-page-not-found`,
  requirement `_permission: 'administer site configuration'`
  (`better_page_not_found.routing.yml`). Menu link under `system.admin_config_ui`
  (`better_page_not_found.links.menu.yml`, weight -1).
- One field, `access_denied_button_target` (`#type => radios`), options `homepage` | `login`,
  default `homepage`. On submit it saves that single value to the config object.

## Config object
`better_page_not_found.settings`:
- `access_denied_button_target`: `"homepage"` (default) or `"login"`. When `login`, the 401/403
  button reads "Go to login page" and links to `/user/login`; otherwise "Go to homepage" → `/`.

No `config/schema/*` and no `config/install/*` are shipped; the default is applied in code via
`$config->get('access_denied_button_target') ?: 'homepage'`. (Absent schema means the setting has no
typed-config definition — relevant if you export/translate it.)

## Notes for agents
- This module changes only presentation. It does **not** alter access control: a 403 stays a 403,
  a 404 stays a 404. Enabling it does not grant or deny anything.
- It provides no permissions, services, entities, plugins, hooks beyond the three preprocess/theme/
  attachment hooks above, and no Drush commands.
- To fully customize the copy, either override the `better_system_message` template / the message
  strings (string translation) or provide your own `hook_preprocess_page` at a later weight.
