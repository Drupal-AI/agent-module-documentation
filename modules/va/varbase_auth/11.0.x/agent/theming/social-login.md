<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# varbase_auth — theming & Social Auth integration

`varbase_auth` contributes only presentation. All authentication is done by Social Auth and its
provider modules; this module's job is to (a) tell the login/register templates whether any
social provider is enabled, (b) attach the right per-provider logo, (c) register the two theme
hooks/templates the login-with UI uses, and (d) fix the icon CSS under the `gin` admin theme.
Everything lives in `varbase_auth.module` plus `includes/helpers.inc`; there is no `src/`.

## Install / enable

`drush en varbase_auth`. Composer pulls `social_api`, `social_auth`, and the
`social_auth_google` / `social_auth_facebook` / `social_auth_linkedin` providers. Unlike 10.1.x,
there is **no install recipe** — enabling and configuring providers (client ID/secret, redirect
URI, account linking) is done in Social Auth, and placing the login block is done by the
site/theme. Core is pinned to `~11.4.0`.

## The four hooks (`varbase_auth.module`)

- `varbase_auth_preprocess_page(&$variables)` — only on route names `user.login` or
  `user.register`. Iterates `\Drupal::service('module_handler')->getModuleList()` and, if any
  module name contains `social_auth_`, sets a bool. It writes that bool into the template as
  `varbase.we_do_have_enabled_social_auth_modules` through the helper below, letting a theme
  conditionally render the social block.
- `varbase_auth_preprocess_login_with(&$variables)` — returns early unless `social_auth` exists
  and `$variables['networks']` is non-empty. For each network it reads the plugin definition; if
  the definition has an `img_path`, it builds
  `images/social_auth/<provider>/<img_path>` relative to this module's path, and — only if that
  file exists under `DRUPAL_ROOT` — records it as `$variables['custom_networks'][$id]['img_path']`.
  The `login-with` template then prefers `custom_networks[id].img_path` over the network's own
  `getProviderLogoPath`.
- `varbase_auth_theme()` — registers two theme hooks: `login_with`
  (`templates/login-with.html.twig`) and `block_social_auth_html`
  (`templates/block--social-auth.html.twig`), each taking `attributes` and `children`.
- `varbase_auth_library_info_alter(&$libraries, $extension)` — when `$extension === 'social_auth'`,
  the `auth-icons` library exists, and the active theme is `gin`: it unsets Social Auth's
  `auth-icons` `css` and appends `varbase_auth/auth-icons` as a dependency, so this module's icon
  styling wins under the gin admin theme.

## Helper (`includes/helpers.inc`)

`varbase_auth__add_template_variable(array &$variables, ?array $data = NULL)` — stores `$data`
under a static `varbase` key in `$variables` (first call sets it, later calls append). This is
how `we_do_have_enabled_social_auth_modules` reaches Twig as `{{ varbase.we_do_have_enabled_social_auth_modules }}`.
The file is pulled in via `include_once` at the top of `varbase_auth.module`.

## Templates

- `templates/login-with.html.twig` — attaches `social_auth/auth-icons`, then loops `networks`,
  rendering each as a link to `network.getRedirectUrl(options).toString` (Social Auth builds that
  URL) with the resolved logo `img_path` and a translated "Authenticate through …" alt/label. If
  a `destination` is present it is added as a query param on the redirect. Includes an "or"
  separator and hints to log in with email/account.
- `templates/block--social-auth.html.twig` — a standard block wrapper (section + optional title +
  content) used by the `block_social_auth_html` theme hook.

## Library / assets

`varbase_auth.libraries.yml` defines a single CSS-only library `auth-icons` →
`css/theme/auth-icons.theme.css` (SCSS source in `scss/theme/auth-icons.theme.scss`, built with
the webpack config in the project root). No JavaScript library is shipped. Provider logos are the
SVGs under `images/social_auth/social_auth_<provider>/img/`.

## What it does NOT do

No routes, no permissions, no `*.permissions.yml`, no `*.services.yml`, no `config/` (no schema,
no optional block, no config_rewrite), no `.install`/update hooks, no Drush commands, no OAuth
token exchange or callback handling. Provider credentials and account-linking behavior are
entirely Social Auth's responsibility.
