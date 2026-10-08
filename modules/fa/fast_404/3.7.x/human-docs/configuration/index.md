# Configuration

Fast 404 has **no admin UI, no config entity, and no permissions**. Everything is
configured through `$settings['fast404_*']` keys in your site's `settings.php`,
which the module reads at runtime. Simply enabling the module runs the extension
check with sensible defaults; everything below is opt‑in.

## Three ways to install it

**Basic (default).** Just enable the module. Only the extension check runs, and
no `settings.php` edits are required. This is right for most sites.

**Advanced.** Copy the module's `example.settings.fast404.php` into your site
directory as `settings.fast404.php`, set the keys you want, and include it at the
**end** of `settings.php`:

```php
if (file_exists($app_root . '/' . $site_path . '/settings.fast404.php')) {
  include $app_root . '/' . $site_path . '/settings.fast404.php';
}
```

**Preboot (fastest).** Run the checks at the very earliest bootstrap phase,
before Drupal's modules even load, by adding this to `settings.php`:

```php
if (file_exists($app_root . '/modules/contrib/fast_404/fast404.inc')) {
  include_once $app_root . '/modules/contrib/fast_404/fast404.inc';
  fast404_preboot($settings);
}
```

The maintainers flag the preboot path as not fully ready, so treat it as
experimental.

## The two checks

1. **Extension check** — always runs when the module is enabled. It matches the
   request path against the `fast404_exts` regex of file extensions; a match with
   no matching file on disk becomes a 404. It deliberately lets some things
   through untouched: the homepage, image‑style derivative URLs (those containing
   `styles/`), Drupal 10.1+ generated CSS/JS asset paths, and anything you
   whitelist.
2. **Path check** — only runs if you set `fast404_path_check` to `TRUE`. It
   confirms a dynamic path actually exists (checking the router, then path
   aliases, then optionally redirects) before letting Drupal continue. It is
   aware of language URL prefixes, so multilingual front pages are not blocked.
   The module labels this "use at your own risk," so test it before relying on
   it.

Command‑line (CLI) requests are never blocked.

## Every setting, in plain language

- **`fast404_exts`** — the regex of blacklisted file extensions the extension
  check uses. The default covers txt, png, gif, jpe?g, css, js, ico, swf, flv,
  cgi, bat, pl, dll, exe, and asp. Override it with your own regex to change what
  gets blocked.
- **`fast404_allow_anon_imagecache`** *(default TRUE)* — when set to FALSE,
  anonymous visitors (with no session cookie) cannot trigger image‑style
  derivative generation on missing `styles/` URLs. Useful to blunt
  denial‑of‑service style hammering of image derivatives.
- **`fast404_url_whitelisting`** *(default FALSE)* — switch the extension check
  from blacklist mode to exact‑URL whitelist mode.
- **`fast404_whitelist`** *(default empty)* — the exact URLs allowed when
  whitelisting is on, for example `['index.php', 'rss.xml', 'cron.php']`.
- **`fast404_string_whitelisting`** *(default FALSE)* — an array of URL fragments
  to always allow, for example `['/advagg_', 'cdn/farfuture', '/admin']`, to
  avoid conflicts with CDN or asset‑aggregation modules.
- **`fast404_HTML_error_all_paths`** *(default FALSE)* — when TRUE, use your
  custom HTML error page for *all* paths, not just static‑file 404s.
- **`fast404_not_found_exception`** *(default FALSE)* — when TRUE, replace
  Drupal's normal 404 page whenever any module throws a "not found" exception.
- **`fast404_path_check`** *(default FALSE)* — enable the aggressive dynamic‑path
  checking described above.
- **`fast404_return_gone`** *(default FALSE)* — return `410 Gone` instead of `404
  Not Found`, appropriate for resources you have permanently removed.
- **`fast404_HTTP_status_method`** *(default `mod_php`)* — set to `FastCGI` to
  send a `Status:` header instead of an `HTTP/1.0` status line, which is needed
  under some FastCGI setups.
- **`fast404_html`** — the inline HTML body used for the response. Supports an
  `@path` token that is replaced with the requested path.
- **`fast404_HTML_error_page`** *(default FALSE)* — the path to a static HTML file
  in your docroot to serve as the 404 body. You can pass a language‑keyed array
  to serve a per‑language page, for example
  `['en' => './404-en.html', 'fr' => './404-fr.html']`.
- **`fast404_respect_redirect`** *(default FALSE)* — during the path check, also
  consult the Redirect module's table so redirects are honored. Requires the
  Redirect module.

After editing `settings.php`, no cache clear is strictly required for these
runtime settings, but rebuilding caches (`drush cr`) is a safe habit after
changing site configuration.
