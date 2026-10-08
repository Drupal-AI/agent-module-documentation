# Configuring Custom Error

## Required wiring (two steps)
1. **Point core error pages at this module.** *Configuration → System → Basic site settings → Error
   pages*: set "Default 403 (access denied) page" to `/customerror/403` and "Default 404 (not found)
   page" to `/customerror/404`. The settings form warns you if these are not set.
2. **Set the content.** *Configuration → System → Custom error*
   (`/admin/config/system/customerror`, route `customerror.settings`, permission
   `access site administration`).

## Config object `customerror.settings`
Schema `config/schema/customerror.schema.yml`. Default install values in
`config/install/customerror.settings.yml`.

| Key | Type | Meaning |
|---|---|---|
| `403.title` / `404.title` | text | Page title (max 70 chars in the form). |
| `403.body` / `404.body` | text | Page body. A `textarea` the module intends to hold **HTML** ("You can enter any HTML text"). |
| `403.theme` / `404.theme` | string | Theme override select (empty = system default / admin theme). **See quirk below — currently inert.** |
| `redirect` | string | Newline-separated `"<regex> <destination>"` pairs for 404 redirects. |
| `{code}.enable_login` | bool | Show the core login form for anonymous visitors on that error page. **Used by code but not declared in the schema.** |

Set via drush:
```bash
ddev drush config:set customerror.settings 404.title 'Not found' -y
ddev drush config:set customerror.settings 404.body '<p>Try the <a href="/search">search</a>.</p>' -y
```

## How the page is rendered
`CustomErrorController::index($code)` (route `customerror.error_page`):
- Rejects non-numeric `{code}` with 403.
- For 403: captures the attempted internal path into `$_GET['destination']` / `$_SESSION['destination']`
  so a subsequent login can return the user there.
- Runs the **redirect list**: each line is split into `[$regex, $dest]`; if `preg_match('/<regex>/',
  $requestUri)` matches, it sends `Location: <dest>` (302) and exits. `<front>` is resolved to the
  front-page URL. (Applies on the error page request; destinations are admin-configured.)
- Sends the correct HTTP status (`customerror_header()`), then returns render array
  `#theme => 'customerror__' . $code` with `#description` = `{code}.body`, `#error_code`, and
  `#login_form` (the core `UserLoginForm`, only when `{code}.enable_login` is set **and** the user is
  anonymous). Title comes from `titleCallback()` = `{code}.title`.

## Login form behavior
`customerror_form_user_login_form_alter()` adds `_customerror_login_submit()`, which reads the POSTed
`destination` and, if present, redirects there after login (via `Url::fromUserInput()`, internal paths
only). This lets a denied anonymous user log in on the 403 page and land back on the target page.

## Theming
Theme hook `customerror` → `templates/customerror.html.twig` (prints `{{ description }}` then
`{{ login_form }}`). Per-code suggestions `customerror__404` / `customerror__403` — copy the template
to `customerror--404.html.twig` / `customerror--403.html.twig` in your theme to differ per code.

## Known quirks (verified in source)
- `customerror_get_theme()` reads `\Drupal::config('customerror.config')->get("customerror_{$code}.theme")`
  — a **config name and key that do not exist** (real config is `customerror.settings` with key
  `{code}.theme`). So the per-code theme override is effectively a no-op; error pages render in the
  active theme. Do not rely on the "Theme" select.
- `enable_login` is written/read by the form and controller but is **missing from the config schema**,
  so it will surface in schema checks.
- The controller writes to `$_GET` / `$_SESSION` superglobals directly for the post-login destination.
