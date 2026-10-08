<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fast 404 Generator — operation & wiring

Everything this module does, grounded in its four source files. There is **no configuration UI, no config object, and no config schema** — the only tunable lives in `settings.php`.

## Install & enable

1. Install and configure **Fast 404** first (`drupal/fast_404 ^2.0 || ^3.0`, module `fast404`) per its own docs — it is a hard dependency (`fast_404:fast404` in `fast_404_generator.info.yml`).
2. Enable this module: `drush en fast_404_generator -y`.
3. Add the wiring snippet to `settings.php` (from `README.md`):

   ```php
   $site_404 = DRUPAL_ROOT . '/' . $site_path . '/files/404.html';
   $settings['fast404_HTML_error_page'] = file_exists($site_404) ? $site_404 : FALSE;
   $settings['fast404_path_check'] = file_exists($site_404);
   ```

   The `file_exists()` guards mean Fast 404 falls back to its own handling until the file exists.
4. Clear caches, then trigger an anonymous 404 (visit an unknown path while logged out) to produce the file.

## How the file is produced

Service `fast_404_generator.event_subscriber` (`fast_404_generator.services.yml`) →
`Drupal\fast_404_generator\EventSubscriber\Fast404GeneratorSubscriber`, constructed with
`@file_system` (`FileSystemInterface`) and `@current_user` (`AccountProxyInterface`).

`onKernelResponse(ResponseEvent $event)` (subscribed to `KernelEvents::RESPONSE`) writes the file only when **all** of these are true:

- `$event->getResponse()->getStatusCode() == 404`
- `!file_exists('public://404.html')` — it never overwrites an existing file on a normal request
- `$this->currentUser->isAnonymous()` — authenticated responses are never captured

When those pass, it reads a regex from settings and skips capture if the request URI matches it:

```php
$exts = Settings::get('fast404_exts', '/^$/');
preg_match($exts, $event->getRequest()->getRequestUri(), $matches);
if (!$matches) {
  $this->fileSystem->saveData(
    $event->getResponse()->getContent(),
    'public://404.html',
    FileSystemInterface::EXISTS_REPLACE
  );
}
```

- **Fixed destination.** The path is always `public://404.html` — not derived from the request — so there is no path-traversal surface.
- **Source content** is `$response->getContent()`, i.e. the site's own rendered 404 page (core 404, honoring the *Default 404 (not found) page* set in *Basic site settings*), so the static file keeps the site theme/menu.
- Default `fast404_exts` is `/^$/`, which matches only an empty string, so by default **every** anonymous 404 URI is eligible.

### `fast404_exts` (settings.php only)

Set a regex in `settings.php` to exclude request URIs whose bare 404 body you do not want frozen as the template — e.g. asset extensions:

```php
$settings['fast404_exts'] = '/\.(png|jpe?g|gif|ico|css|js|txt)$/i';
```

This value is `Settings::get()` — admin-controlled, never taken from user input.

## Regeneration / freshness

The file is a snapshot. Two hooks in `fast_404_generator.module` invalidate it:

- `fast_404_generator_cron()` — deletes `public://404.html` if it exists (via `file_system->delete()`).
- `fast_404_generator_cache_flush()` — calls `fast_404_generator_cron()`, so **any cache rebuild** (`drush cr`) also removes the file.

After deletion, the next anonymous 404 regenerates it. This is why the file stays in step with theme/menu changes: rebuild caches, then hit an unknown path anonymously. To force a fresh capture manually, delete `sites/default/files/404.html` and request an unknown path while logged out.

## Verifying

- The generated file is web-accessible at `/sites/default/files/404.html`; open it to confirm it matches the site theme.
- If it is empty or unstyled, the first captured 404 was likely a bare response (e.g. a missing asset) — narrow it with `fast404_exts` and regenerate.
