<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DocCheck Basic (doccheck_basic) — agent index

Integrates the DocCheck login (basic license, https://access.doccheck.com/) so a site can gate
medical/pharma content behind DocCheck for verified healthcare professionals. It renders a DocCheck
login button (block + page), and on the DocCheck redirect back logs the visitor into ONE
pre-configured Drupal account. The module defines no permissions and blocks no content itself:
gating is done with ordinary Drupal role/permission/block-visibility config on that shared account.

- Module deps: `drupal:node`, `drupal:block`. Core: `^10.2 || ^11`. Package: Web services.
- Composer/library dep: `doccheck/oauth2-doccheck` (`^2@beta`) — League OAuth2 client provider.
- Config object: `config.doccheck_basic` (schema in `config/schema/`, defaults in `config/install/`).
- Settings route: `doccheck_basic.settings` at `/admin/config/people/doccheckbasic`
  (`administer site configuration`); menu link in `doccheck_basic.links.menu.yml`.

## Routes (`doccheck_basic.routing.yml`)
- `doccheck_basic.login` — `/doccheck-login` → `CallbackController::loginPage()`; renders the login
  button page. `_permission: access content`, `no_cache`.
- `doccheck_basic.callback` — `/_dc_callback` → `CallbackController::callbackPage()`; DocCheck's
  redirect target; logs the visitor in and redirects to the stored page. `_permission: access
  content`, `no_cache`.
- `doccheck_basic.settings` — admin settings form. `administer site configuration`.

## Provides
- Block plugin `doccheck_basic` (`src/Plugin/Block/FormBlock.php`, category "Login", cache max-age 0)
  — the login button block.
- Controller `src/Controller/CallbackController.php` (also service `doccheck_basic.callbackservice`).
- Shared service `doccheck_basic.commonservice` = `DoccheckBasicCommon` — builds the login render
  array for both block and page; stores the post-login redirect target in the `dc_page` session key.
- Global authentication provider `authentication.doccheck_basic` = `DoccheckIpAuth`
  (`src/Authentication/Provider/DoccheckIpAuth.php`, priority 100) — optional IP-based crawler
  auto-login into the shared account.
- Theme hook `doccheck_basic` (`templates/doccheck-basic.html.twig`) rendering the `<dc-login-button>`
  web component; JS from CDN via library `doccheck_basic/doccheckbutton` (`doccheck_basic.libraries.yml`).
- `hook_help()` renders `README.md`; `hook_update_8001` seeds crawler config.

## Solution docs
- Settings & config object: [agent/config/settings.md](config/settings.md)
- Login/callback flow, session gating, crawler auth: [agent/flow/login-and-callback.md](flow/login-and-callback.md)
