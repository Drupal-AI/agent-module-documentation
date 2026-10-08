<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DocCheck Basic — login/callback flow, session gating, crawler auth

How the module turns a DocCheck login into a Drupal session. Three entry points: the login page/block
(build the button + stash the return URL), the callback (log the shared user in), and the optional
IP crawler auth provider.

## 1. Login button — `DoccheckBasicCommon::doccheckBasicLogin($template)`
`src/DoccheckBasicCommon.php`, service `doccheck_basic.commonservice`. Used by both the block
(`FormBlock::build()` → `'block'`) and the page (`CallbackController::loginPage()` → `'page'`).
- Errors out (empty markup, logged) if `dc_loginid` is unset.
- If the current user is anonymous, sets session `forced = TRUE`; if already logged in on the page
  route it renders "already logged in".
- Computes the return target `dc_page`: for the page route it is `dc_noderedirect` when set, otherwise
  the core `redirect.destination` value (forced to begin with `/`). Stores it in session key `dc_page`.
- Returns a `doccheck_basic` themed render array feeding `templates/doccheck-basic.html.twig`, which
  emits `<dc-login-button size loginClientId redirectUri language>` (JS component from the
  `doccheck_basic/doccheckbutton` CDN library). `redirectUri` = scheme+host + the
  `doccheck_basic.callback` route. In `dc_devmode` a plain "Development mode login" link to the
  callback is appended (`|raw`).

## 2. Callback — `CallbackController::callbackPage()`
`src/Controller/CallbackController.php`, route `doccheck_basic.callback` = `/_dc_callback`
(`_permission: access content`, `no_cache`). DocCheck redirects the browser here after login. Steps:
1. Trigger `page_cache_kill_switch`; read and then remove session `dc_page`. If absent/empty → error
   "No cookie found".
2. If config `dc_user` is empty → error. 
3. If the current user is anonymous:
   - Load the `dc_user` account; error if it does not exist, or if it has the `administrator` role.
   - In production (`dc_devmode === FALSE`) the returned DocCheck authorization `code` is exchanged
     server-side: construct the `Doccheck` OAuth2 provider (`clientId=dc_loginid`,
     `clientSecret=dc_client_secret`, `redirectUri`, `stateless => TRUE`) and call
     `getAccessToken('authorization_code', ['code' => …])`, erroring on `IdentityProviderException`.
     Configure `dc_client_secret` so this verification runs (see config/settings.md).
   - Call `user_login_finalize($dc_user)` — the visitor is now logged in as the shared account.
4. `RedirectResponse($redirect_page)` to the stored `dc_page`.

The OAuth2 provider (`doccheck/oauth2-doccheck`, `Doccheck\OAuth2\Client\Provider\Doccheck`) targets
`https://auth.doccheck.com/` over the League/Guzzle client (TLS verified by default). `errorMsg()`
logs to the `doccheck_basic` channel, shows a messenger error, and returns empty uncacheable markup.

## 3. Crawler IP auto-login — `DoccheckIpAuth`
`src/Authentication/Provider/DoccheckIpAuth.php`, global auth provider `authentication.doccheck_basic`
(priority 100). `applies()` returns TRUE only when `dc_crawler_autologin === TRUE`, the request has no
previous session, the first/second path segment is not in `PATHS_EXCLUDED`
(`admin`, `user`, `doccheck-login`, `_dc_callback`), and the client IP is in `dc_crawler_ip`.
`authenticate()` loads `dc_user` and calls `user_login_finalize()` for that IP, else throws
`AccessDeniedHttpException` (turned into a 401 "Invalid IP." by `handleException()`). This lets the
DocCheck search crawler index protected pages as the shared account.

## Gating model (important for agents)
"Logged in via DocCheck" == "logged into the Drupal `dc_user` account". There is no separate DocCheck
session flag. All content protection is standard Drupal: give `dc_user` a dedicated role and grant that
role node-view/block-visibility access to the protected content. The module adds no permissions and
blocks nothing itself.
