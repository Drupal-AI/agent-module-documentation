<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filename extension sanitization (extension_sanitization) — agent index

Collapses **repeated file extensions** in uploaded filenames: it drops every intermediate
`.`-separated segment that matches one of the field's **allowed extensions**, keeping the base
name and the final extension (`photo.jpg.png.gif` → `photo.gif`, `image.jpeg.jpeg` → `image.jpeg`).
Package **Media**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **1.0.3**.

- **How the sanitization works, the event, the service, and how to operate it** →
  [api/sanitization.md](api/sanitization.md)

## What it actually is

- **One service** (`extension_sanitization.services.yml`): `extension_sanitization.event_subscriber`
  → `Drupal\extension_sanitization\EventSubscriber\ExtensionSanitizationSubscriber`, tagged
  `event_subscriber`, constructed with `@messenger`.
- It subscribes to core's **`FileUploadSanitizeNameEvent`** (`getSubscribedEvents()` maps it to
  `sanitizeFilename`), so it runs inside core's managed file upload name-sanitization flow.
- **No** routes, permissions, config, config schema, forms, entities, plugins, hooks, Drush
  commands, libraries or dependencies (only Drupal core). No `composer.json` in the release.

## Mechanism (from source)

- `sanitizeFilename(FileUploadSanitizeNameEvent $event)` reads `$event->getAllowedExtensions()`
  and `$event->getFilename()`, then `explode('.', $filename)`.
- It loops from the **second-to-last** segment down to index **1** (so index 0 = base name and the
  **last** segment = final extension are never touched); for each intermediate segment whose
  `strtolower()` is `in_array($allowed_extensions)` it `unset()`s that segment.
- If anything changed it `implode('.')`s the survivors, calls `$event->setFilename(...)`, and adds
  the status message *"File was renamed due to multiple file extensions."* via `@messenger`.
- Comparison is **case-insensitive**; the base name and the trailing extension are always preserved.

## Role

- Defense-in-depth filename hygiene that **complements** core's own upload sanitization
  (transliteration, munging, allowed-extension validation) rather than replacing it. Primary
  practical benefit: avoiding broken image derivatives from duplicated extensions (e.g.
  imageapi_optimize_webp). No content-access or permission role.
