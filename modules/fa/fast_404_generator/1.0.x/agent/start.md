<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fast 404 Generator (fast_404_generator) — agent index

Captures the site's **first anonymous 404 response** and writes its HTML to **`public://404.html`**, so the **Fast 404** module can serve a fully themed static error page without a Drupal bootstrap. Package *Performance and scalability*. Depends on **`fast_404:fast404`** (`drupal/fast_404 ^2.0 || ^3.0`). Core `^10.1 || ^11`, PHP `>=8.0`. License GPL-2.0-or-later. Version 1.0.5.

- **How the capture works, the settings.php wiring, cron/cache-flush behavior, `fast404_exts`** →
  [config/operation.md](config/operation.md)

## What it actually is

- **No routes, no controllers, no admin form, no permissions, no plugins, no config schema, no Drush.** The whole module is one event subscriber plus two hooks.
- One service: `fast_404_generator.event_subscriber` → `Fast404GeneratorSubscriber` (`src/EventSubscriber/Fast404GeneratorSubscriber.php`), args `@file_system`, `@current_user`, tagged `event_subscriber`.
- Two hooks in `fast_404_generator.module`: `hook_cron()` and `hook_cache_flush()` (the latter just calls the cron logic).

## Mechanism (from source)

- `Fast404GeneratorSubscriber::onKernelResponse(ResponseEvent)` subscribes to `KernelEvents::RESPONSE`. It acts only when **all three** hold: response status is `404`, `public://404.html` does **not** already exist, and `currentUser->isAnonymous()`.
- It then reads the regex `Settings::get('fast404_exts', '/^$/')` (from `settings.php`, admin-controlled), runs `preg_match()` against `$request->getRequestUri()`, and **only if there is no match** calls `fileSystem->saveData($response->getContent(), 'public://404.html', FileSystemInterface::EXISTS_REPLACE)`.
- Net effect: the first anonymous 404 body (the site's own core 404 page — theme, blocks, menu, and whatever node/text is set as the site 404) is frozen into `public://404.html`. The file is not user-path-controlled (fixed path) and only public/anonymous content is captured.
- `fast_404_generator_cron()` deletes `public://404.html` if present; `fast_404_generator_cache_flush()` calls it — so a cache rebuild or cron run forces regeneration from the next anonymous 404, keeping the snapshot current.

## Operating it

- Requires Fast 404 configured to use the file; the README `settings.php` snippet points `fast404_HTML_error_page` / `fast404_path_check` at `.../files/404.html`, guarded by `file_exists()`. See [config/operation.md](config/operation.md).
- The generated file is directly fetchable at `/sites/default/files/404.html`.
