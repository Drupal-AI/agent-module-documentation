<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Media Download serves files

There is **nothing to configure** (`configure: null`). Enabling the module changes what the
media canonical URL does. All behaviour is in five classes under `src/`.

## The canonical route override

`Drupal\media_download\RouteSubscriber` (an event subscriber) runs on route rebuild:

```php
$collection->remove('entity.media.canonical');
$collection->add('entity.media.canonical', new Route('/media/{media}', [
  '_controller' => DownloadController::class . '::save',
], [
  '_entity_access' => 'media.view',
]));
```

So `/media/{id}` no longer renders the media view page — it runs `DownloadController::save()`,
still gated by the `media.view` access check.

## The download response

`DownloadController::save(MediaInterface $media, Request $request)`:

1. `getFile()` reads the media's **source field** (`$media->getSource()->getConfiguration()['source_field']`)
   and returns the first referenced `File` entity that exists on disk (throws `RuntimeException`
   if the media has no source field; `NotFoundHttpException` if no valid file is found).
2. Returns a `CacheableBinaryFileResponse` for `$file->getFileUri()`, with the media and file as
   cacheable dependencies and a `url.query_args:dl` cache context.
3. **Content disposition**: `attachment` when `$request->query->get('dl') === '1'`, otherwise
   `inline`. So:
   - `/media/{id}` → view inline (browser displays PDFs/images).
   - `/media/{id}?dl=1` → force "Save as" download.
4. Sets `Content-Security-Policy: sandbox` (mitigates SVG XSS), `Content-Type` from
   `$file->getMimeType()` (default `application/octet-stream`), and auto `ETag`/`Last-Modified`.

## Forced standalone media URL

Core only exposes `/media/{id}` when `media.settings:standalone_url` is TRUE. `MediaSettingsOverride`
is a `config.factory.override` service that **forces that value to TRUE at runtime**:

```php
if (in_array('media.settings', $names)) {
  $overrides['media.settings']['standalone_url'] = TRUE;
}
```

- The *stored* `media.settings.standalone_url` (via `drush cget`) may still read `false`; the
  **effective** value (`\Drupal::config('media.settings')->get('standalone_url')`) is `true`.
- The media settings form (`/admin/config/media/media-settings`) shows a warning that changing
  the toggle has no effect while Media Download is installed
  (`media_download_form_media_settings_form_alter`).

## Caching

`PageCacheResponsePolicy` returns `DENY` for `BinaryFileResponse`/`StreamedResponse`, so these
downloads are never stored by the (dynamic) page cache.

## Verifying programmatically

```php
use Symfony\Component\HttpFoundation\Request;
// Requires an account with 'view media' access (switch to it in CLI):
\Drupal::service('account_switcher')->switchTo(\Drupal\user\Entity\User::load(1));
$response = \Drupal::service('http_kernel')->handle(Request::create('/media/' . $mid));
// $response is Drupal\media_download\CacheableBinaryFileResponse, status 200,
// Content-Disposition: inline; add ?dl=1 (Request::create('/media/'.$mid,'GET',['dl'=>'1'])) for attachment.
```
