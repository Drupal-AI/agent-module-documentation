# avif.avif service + serving pipeline

Service id `avif.avif`, class `Drupal\avif\Avif`. Constructor args (services.yml):
`image.factory`, `logger.factory` (channel `avif`), `string_translation`, `config.factory`,
`file_system`, `http_client`, `plugin.manager.avif_processor`, `lock`. It reads `quality` and
`processor` from `avif.settings` on construction.

## Public methods

```php
// Return an ImageInterface for <uri>.avif, generating it if missing; FALSE on failure.
public function getAvifCopy($uri, $quality = NULL);

// Static: rewrite an <img>/<source> srcset so each .png/.jpg/.jpeg URL gains a .avif suffix.
public static function getAvifSrcset($srcset);
```

- `getAvifCopy($uri, $quality = NULL)` — destination is `$uri . '.avif'`. If that file already exists
  it is returned immediately (via `image.factory`). Otherwise `createAvifImage()` runs; `$quality`
  defaults to the configured `quality`.
- `createAvifImage()` (protected) — looks up the configured `processor` in the plugin definitions; if
  it is not a defined plugin it logs *"The Avif processor is not defined…"* and returns FALSE. Otherwise
  it creates the plugin instance, acquires a lock, calls `$plugin->convert($uri, $quality, $destination)`,
  releases the lock, and returns the resulting `ImageInterface` (or FALSE if convert returned FALSE).
- `acquireLock()` (protected) — lock name `avif_create_copy:` + `Crypt::hashBase64($uri)`, held 3s, so
  two concurrent requests don't encode the same image twice. If the lock is already held it throws
  `ServiceUnavailableHttpException(3)` ("Image generation in progress. Try again shortly.") → HTTP 503.
- `getAvifSrcset()` applies `preg_replace('/\.(png|jpg|jpeg)(\?.*?)?(,| |$)/i', '.\1.avif\2\3', …)` —
  e.g. `foo.jpg?itok=x 360w` becomes `foo.jpg.avif?itok=x 360w`.

## How derivatives are served

1. `avif.route_subscriber` (`Drupal\avif\Routing\RouteSubscriber`) alters the core route
   `image.style_public`, repointing its `_controller` to
   `Drupal\avif\Controller\ImageStyleDownloadController::deliver`.
2. That controller **wraps** the core `image` `ImageStyleDownloadController` (kept as `$this->inner`).
   In `deliver()`:
   - If the `?file=` query value does **not** end in `.avif`, it delegates unchanged to the inner core
     controller — normal derivative requests behave exactly like core.
   - If it ends in `.avif` but the request's `Accept` types don't include `image/avif`, it returns a
     404.
   - Otherwise it strips the `.avif` suffix, clones the request pointing `file` at the source derivative,
     and calls the **inner core controller** for it. The core controller enforces the `itok` token and
     access and produces the source `BinaryFileResponse`; if it returns anything else (access denied /
     missing), that response is passed straight back.
   - It then calls `avif.avif::getAvifCopy()` on the resolved source file's real pathname, and returns a
     `BinaryFileResponse` with `Content-Type: image/avif`. A failed/invalid conversion returns HTTP 500.

Because access, tokens, and the source-derivative generation are delegated to the unmodified core
controller, the AVIF path never widens access beyond what core already grants for the derivative.
