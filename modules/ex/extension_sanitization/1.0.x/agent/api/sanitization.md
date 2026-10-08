<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# extension_sanitization — filename sanitization

The entire module is one event subscriber. This doc covers install, the event it hooks, the exact
rewrite algorithm, and how to operate/verify it.

## Install / enable

- `drush en extension_sanitization -y` (or via *Extend*). No configuration step exists — there is
  no settings route, no config object, no permission. It is active site-wide once enabled.
- Dependencies: **Drupal core only** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`). The
  release ships no `composer.json`; require via `composer require drupal/extension_sanitization`.
- Package: **Media**. Removing the module and clearing caches (`drush cr`) restores core's default
  upload naming.

## Service

`extension_sanitization.services.yml`:

```yaml
services:
  extension_sanitization.event_subscriber:
    class: Drupal\extension_sanitization\EventSubscriber\ExtensionSanitizationSubscriber
    arguments: ['@messenger']
    tags:
      - { name: event_subscriber }
```

- Single dependency: core `@messenger` (`MessengerInterface`), used only for a status message.

## Event

`ExtensionSanitizationSubscriber::getSubscribedEvents()` returns:

```php
[ FileUploadSanitizeNameEvent::class => 'sanitizeFilename' ]
```

- `\Drupal\Core\File\Event\FileUploadSanitizeNameEvent` is dispatched by core's managed file
  **upload handler** while it sanitizes an uploaded file's name, so the subscriber applies to
  uploads that flow through that core mechanism (file fields, media, etc.). **No priority** is
  declared (default `0`), so it orders with core's own subscribers for the same event.
- The event exposes `getFilename()` / `setFilename()` and `getAllowedExtensions()` (the target
  field's allowed-extension list, provided by core, already lowercased).

## Algorithm — `sanitizeFilename()`

`src/EventSubscriber/ExtensionSanitizationSubscriber.php`:

1. `$allowed_extensions = $event->getAllowedExtensions();`
2. `$exploded_filename = explode('.', $event->getFilename());`
3. Loop `for ($i = count($exploded_filename) - 2; $i >= 1; $i -= 1)` — i.e. from the
   **second-to-last** segment down to **index 1**. This deliberately skips:
   - index `0` — the **base name**, and
   - the **last** index — the **final extension**.
4. For each intermediate segment, if `in_array(strtolower($exploded_filename[$i]), $allowed_extensions)`
   then `unset($exploded_filename[$i])` and mark `$changed = TRUE`.
5. If `$changed`: `$event->setFilename(implode('.', $exploded_filename))` and
   `$messenger->addMessage('File was renamed due to multiple file extensions.')`.

### Behavior

- Only **intermediate** segments that are themselves **allowed extensions** are removed; the base
  name and the trailing extension are always kept.
- Comparison is **case-insensitive** (`strtolower` before `in_array`).
- Examples (field allows jpg/png/jpeg/gif):
  - `photo.jpg.png.JPEG.gif` → `photo.gif`
  - `image.jpeg.jpeg` → `image.jpeg`
  - `x.JPG.jpg` → `x.jpg`
- If nothing matches, the filename is left untouched and no message is shown; the module never
  blocks an upload and never alters the final extension.

## Operate / verify

- Upload a file whose name repeats an allowed extension (e.g. `test.png.png`) to any file/media
  field. On save you should see the status message and the stored filename collapsed to
  `test.png`.
- There is nothing to tune: which segments qualify as "extensions" is driven entirely by the
  destination field's own allowed-extensions setting. To change what gets collapsed, change the
  field's allowed extensions.
- This is defense-in-depth cleanup layered on core's upload sanitization; it does not replace
  core's transliteration, munging, or allowed-extension validation.
