# Configure Fast 404 (settings.php + API)

Fast 404 has **no admin UI, no config entity, no route, no permission, no schema**. All
configuration is `$settings['fast404_*']` keys in `settings.php`, read at runtime with
`Settings::get()`. Just enabling the module (`drush en fast404`) activates the static-file
**extension check** with defaults; everything else is opt-in.

## Install models

- **Basic (default):** enable the module. Only the extension check runs, via the event
  subscriber. No `settings.php` edits required.
- **Advanced:** copy `example.settings.fast404.php` to your site dir as `settings.fast404.php`,
  set keys, and include it at the **end** of `settings.php`:
  ```php
  if (file_exists($app_root . '/' . $site_path . '/settings.fast404.php')) {
    include $app_root . '/' . $site_path . '/settings.fast404.php';
  }
  ```
- **Preboot (fastest, flagged not fully ready):** run the checks at bootstrap phase 1 before
  modules load by adding to `settings.php`:
  ```php
  if (file_exists($app_root . '/modules/contrib/fast_404/fast404.inc')) {
    include_once $app_root . '/modules/contrib/fast_404/fast404.inc';
    fast404_preboot($settings);
  }
  ```
  `fast404_preboot()` instantiates `Settings`, requires `src/Fast404.php` directly (no
  autoloader yet), builds a `Request`, and runs `extensionCheck()` + `pathCheck()`.

## The two checks

1. **Extension check** (`Fast404::extensionCheck()`) — always runs when the module is enabled.
   Matches the request path against the `fast404_exts` regex; a match becomes a 404. It first
   short-circuits (returns, i.e. lets Drupal handle it) for: the homepage `/`, image-derivative
   URLs containing `styles/` (unless `fast404_allow_anon_imagecache` is FALSE and no `SESS`
   cookie is present), Drupal 10.1+ generated CSS/JS asset paths, whitelisted URLs, and
   whitelisted string fragments.
2. **Path check** (`Fast404::pathCheck()`) — only runs if `fast404_path_check` is TRUE. Confirms
   a dynamic path exists by querying `{router}.pattern_outline`, then `{path_alias}.alias`, then
   (if `fast404_respect_redirect`) `{redirect}.redirect_source__path`. No match → 404. Aware of
   `language.negotiation` URL path prefixes so language front pages are not blocked.

The `EXCEPTION` listener (`onNotFoundException`) only acts when `fast404_not_found_exception`
is TRUE, replacing Drupal's 404 page when any module throws `NotFoundHttpException`.

CLI requests (`PHP_SAPI === 'cli'`) are never blocked.

## All settings keys (defaults from source)

| `$settings[...]` key | Default | Effect |
|---|---|---|
| `fast404_exts` | `/^(?!\/robots)^(?!\/system\/files).*\.(txt\|png\|gif\|jpe?g\|css\|js\|ico\|swf\|flv\|cgi\|bat\|pl\|dll\|exe\|asp)$/i` | Regex of blacklisted file extensions for the extension check. |
| `fast404_allow_anon_imagecache` | `TRUE` | If FALSE, anonymous users (no `SESS` cookie) cannot trigger image-style derivative creation on missing `styles/` URLs. |
| `fast404_url_whitelisting` | `FALSE` | Switch extension check from blacklist to exact-URL whitelist mode. |
| `fast404_whitelist` | `[]` | Exact allowed URLs when whitelisting is on, e.g. `['index.php','rss.xml','cron.php']`. |
| `fast404_string_whitelisting` | `FALSE` | Array of URL fragments to always allow (e.g. `['/advagg_','cdn/farfuture','/admin']`) to avoid conflicts with CDN/AdvAgg. |
| `fast404_HTML_error_all_paths` | `FALSE` | If TRUE, use the custom HTML error page for all paths, not just static-file 404s. |
| `fast404_not_found_exception` | `FALSE` | If TRUE, replace Drupal's 404 page whenever a `NotFoundHttpException` is thrown. |
| `fast404_path_check` | `FALSE` | Enable aggressive dynamic-path checking. "Use at your own risk." |
| `fast404_return_gone` | `FALSE` | Return `410 Gone` instead of `404 Not Found`. |
| `fast404_HTTP_status_method` | `'mod_php'` | Set to `'FastCGI'` to send a `Status:` header instead of `HTTP/1.0`. |
| `fast404_html` | terse XHTML 404 doc (with `@path` token) | Inline HTML body for the response. |
| `fast404_HTML_error_page` | `FALSE` | Path to a static HTML file in docroot to serve as the 404 body; may be a langcode-keyed array (e.g. `['en'=>'./404-en.html','fr'=>'./404-fr.html']`). |
| `fast404_respect_redirect` | `FALSE` | During path check, also consult the `{redirect}` table (needs the Redirect module). |

## Services & classes (API / extend)

Declared in `fast404.services.yml`:

- **`fast404.factory`** → `Drupal\fast404\Fast404Factory` (implements `Fast404FactoryInterface`).
  Args: `@request_stack`, `@config.factory`, `@language_manager`. Method
  `createInstance(?Request $request = NULL): Fast404` builds a `Fast404` seeded with the current
  langcode and, when language negotiation uses `path_prefix`, the URL prefix info.
- **`fast404.event_subscriber`** → `Drupal\fast404\EventSubscriber\Fast404EventSubscriber`.
  Args: `@request_stack`, `@fast404.factory`. Subscribes `onKernelRequest` (REQUEST, priority
  100) and `onNotFoundException` (EXCEPTION, priority 0).

`Drupal\fast404\Fast404` (value object) public surface:
- `extensionCheck()`, `pathCheck()`, `blockPath()`, `isPathBlocked(): bool`,
  `response($return = FALSE): Response`, `setLanguageNegotiationUrlInfo(array $info)`.
- Public props `$respond404` (bool) and `$loadHtml` (bool).
- `response()` builds a Symfony `Response` (404 or 410, with `@path` substituted); when
  `$return` is FALSE it sends the response and throws `ServiceUnavailableHttpException`.

**To customise behaviour programmatically:** call `\Drupal::service('fast404.factory')->createInstance()`
to get a preconfigured `Fast404`, or decorate/replace either service in your own `*.services.yml`.
There are no hooks and no `fast404.api.php` — extension points are the settings keys and the
two services above.
