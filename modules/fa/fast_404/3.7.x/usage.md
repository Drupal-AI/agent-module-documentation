Fast 404 serves cheap, low-memory 404 (or 410) responses for requests that Drupal would otherwise handle through its full bootstrap. It intercepts URLs that look like missing static files (by extension) and, optionally, missing dynamic Drupal paths, returning a tiny static HTML page and exiting early.

---

The module registers a single event subscriber (`fast404.event_subscriber`) that listens on `KernelEvents::REQUEST` (priority 100) and `KernelEvents::EXCEPTION`. On each request it runs two checks. The **extension check** matches the request path against a blacklist regex (`fast404_exts`) of file extensions (txt, png, gif, jpe?g, css, js, ico, swf, flv, cgi, bat, pl, dll, exe, asp by default); a match that is not a real file on disk yields an immediate 404 with a minimal HTML body. The **path check** (opt-in via `fast404_path_check`) queries the `router`, `path_alias`, and optionally `redirect` tables to confirm a dynamic path exists before letting Drupal continue. There is no admin UI, config entity, permission, or Drush command — the module is configured entirely through `$settings['fast404_*']` keys in `settings.php`, read at runtime via `Settings::get()`. An optional `fast404.inc` preboot (`fast404_preboot()`) can run the same checks at bootstrap phase 1 (before modules load) for extra speed, though the maintainers flag it as not fully ready. Behaviour is deliberately aggressive: image-derivative (`styles/`) URLs and Drupal 10.1+ CSS/JS asset paths are skipped by default, and whitelisting (`fast404_url_whitelisting` / `fast404_whitelist` / `fast404_string_whitelisting`) exists to protect legitimate module paths. Responses can be upgraded to `410 Gone`, sent with a FastCGI status header, or replaced with a custom (optionally per-language) HTML file.

---

- Cheaply reject bot/scanner requests for `.php`, `.asp`, `.exe`, and similar files without a full Drupal bootstrap.
- Return low-memory 404s (under ~2MB RAM) for missing static assets under high 404 load.
- Block requests for non-existent images, CSS, JS, and other file extensions via the default `fast404_exts` regex.
- Customise which extensions are blocked by overriding `$settings['fast404_exts']` with your own regex.
- Turn on aggressive dynamic-path checking with `$settings['fast404_path_check'] = TRUE` to 404 unknown Drupal routes early.
- Serve `410 Gone` instead of `404 Not Found` for permanently removed resources via `$settings['fast404_return_gone']`.
- Replace the terse built-in 404 body with your own static HTML file using `$settings['fast404_HTML_error_page']`.
- Serve a per-language custom 404 page by passing a langcode-keyed array to `fast404_HTML_error_page`.
- Force the custom HTML page for all paths (not just static files) with `$settings['fast404_HTML_error_all_paths']`.
- Override the inline 404 message HTML with `$settings['fast404_html']` (supports an `@path` token).
- Switch from blacklisting to whitelisting file URLs with `$settings['fast404_url_whitelisting'] = TRUE` plus `fast404_whitelist`.
- Whitelist URL fragments used by CDN, AdvAgg, or similar modules via `$settings['fast404_string_whitelisting']` to avoid false 404s.
- Prevent anonymous users from triggering image-style derivative creation by setting `$settings['fast404_allow_anon_imagecache'] = FALSE`.
- Honour the Redirect module during path checking with `$settings['fast404_respect_redirect'] = TRUE`.
- Fully replace Drupal's native 404 page (e.g. when another module throws `NotFoundHttpException`) with `$settings['fast404_not_found_exception'] = TRUE`.
- Send the correct HTTP status header under FastCGI with `$settings['fast404_HTTP_status_method'] = 'FastCGI'`.
- Run the checks at bootstrap phase 1 (before modules load) using the `fast404.inc` preboot include in `settings.php` for maximum speed.
- Protect a site from denial-of-service style hammering of image-derivative URLs by disabling anonymous imagecache generation.
- Keep language-prefixed front pages working while path-checking multilingual sites (the module recognises configured URL prefixes).
- Reduce CPU, memory, and database load caused by high volumes of 404 traffic on busy sites.
- Provide fast 404s while still allowing real static files on disk (the web server serves those before Drupal is reached).
- Ensure Drush/CLI requests are never blocked by the 404 logic (CLI SAPI is exempted automatically).
