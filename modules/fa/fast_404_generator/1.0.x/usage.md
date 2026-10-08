Fast 404 Generator captures the site's first anonymous 404 response and writes it to `public://404.html` so the Fast 404 module can serve a fully themed static error page without bootstrapping Drupal.

---

Fast 404 exists because a missing image or a bot probing for `/wp-admin` should not cost a full Drupal bootstrap: it intercepts those requests early and returns a static response. The catch is that the static response Fast 404 ships looks nothing like the site — plain markup — and letting Drupal render its real 404 page gives up the performance the module was installed for.

This module bridges the two. It watches every response and, the first time an anonymous visitor triggers a 404 while no `public://404.html` exists yet, it saves that response's HTML to `public://404.html`. Because the captured body is the site's own core 404 page (the theme, blocks, menus, and whatever node or text is set as the site 404 in *Basic site settings*), the resulting static file keeps the site's look. Fast 404 then serves that file for subsequent 404s. There is no admin form and no per-node picker — the source is simply whatever the first anonymous 404 renders.

Wiring it up is a `settings.php` edit, and the README is explicit about it:

```php
$site_404 = DRUPAL_ROOT . '/' . $site_path . '/files/404.html';
$settings['fast404_HTML_error_page'] = file_exists($site_404) ? $site_404 : FALSE;
$settings['fast404_path_check'] = file_exists($site_404);
```

The `file_exists()` guards matter: until the file has been generated, Fast 404 falls back rather than pointing at a missing path. The generated file is a snapshot, so `hook_cron()` and `hook_cache_flush()` delete it — a cache rebuild forces regeneration from the next anonymous 404, keeping the static page in step with theme and menu changes. An optional `fast404_exts` regex in `settings.php` lets you skip request URIs (e.g. asset extensions) so their bare 404 body is never captured as the template.

---

- Serve a themed 404 page without bootstrapping Drupal.
- Keep the site's theme, blocks and menus on the error page.
- Pair a static error page with the Fast 404 module.
- Avoid Fast 404's plain, unstyled default error page.
- Avoid a full Drupal bootstrap for missing files and bot probes.
- Capture the site's own core 404 page as the static template automatically.
- Match each subsite's theme and menu on a multisite install without per-site HTML.
- Skip editing or committing a hand-made `404.html` by hand or via git.
- Add the `settings.php` snippet from the README to point Fast 404 at the file.
- Guard the Fast 404 settings with `file_exists()` so a missing file falls back cleanly.
- Regenerate the file after a theme change by clearing caches.
- Regenerate the file after a menu change by clearing caches.
- Let a cache rebuild refresh the static 404 automatically via `hook_cache_flush()`.
- Let cron clear a stale `public://404.html` so it is rebuilt.
- Use `fast404_exts` to exclude asset-extension URIs from being captured as the template.
- Keep the static file limited to public, anonymous content (only anonymous 404s are captured).
- Reduce load from bots probing for non-existent paths.
- Reduce load from broken image and file references.
- Verify the generated file at `/sites/default/files/404.html`.
- Force a fresh capture by deleting `public://404.html` and hitting an unknown path anonymously.
