# Programmatic API — services & the fetch flow

## How on-demand fetching works

`StageFileProxySubscriber::checkFileOrigin()` listens on `KernelEvents::REQUEST` at
**priority 240** (after ban middleware, before page cache). For each request it:

1. Returns early if `origin` is unset, if the request host *is* the origin, if the path is not
   under the public files directory, contains `..`, is CSS/JS aggregation, or matches an
   excluded extension / excluded path.
2. Resolves image-style URLs to the original file when `use_imagecache_root` is on (so the
   image module can regenerate derivatives locally).
3. Then either:
   - **hotlink** on → sets a `TrustedRedirectResponse` (`301`) to `origin/origin_dir/relative_path`; or
   - **download** (default) → calls `DownloadManagerInterface::fetch()` to save the file locally,
     triggers the page-cache kill switch, and returns a `RedirectResponse` back to the same path
     so the web server serves the now-present file.

You normally never call this yourself — it runs automatically on missing file requests.

## `stage_file_proxy.download_manager`

Service id `stage_file_proxy.download_manager`, class `Drupal\stage_file_proxy\DownloadManager`,
also autowirable by interface `Drupal\stage_file_proxy\DownloadManagerInterface`.

```php
/** @var \Drupal\stage_file_proxy\DownloadManagerInterface $dm */
$dm = \Drupal::service('stage_file_proxy.download_manager');

// Download one file from the origin into the local public files dir. Returns bool.
$ok = $dm->fetch($server, $remote_file_dir, $relative_path, ['verify' => TRUE]);

$dir  = $dm->filePublicPath();                    // the public files directory path
$orig = $dm->styleOriginalPath($uri);             // original path behind an image-style URI (or FALSE)
```

The HTTP client is `stage_file_proxy.http_client` (a child of core `http_client`, parameterized
by `stage_file_proxy.http_client_options`); the manager also uses the core `lock` service to
avoid concurrent downloads of the same file.

## Exclude paths — `stage_file_proxy.alter_excluded_paths` event

Before deciding to proxy, the subscriber dispatches an `AlterExcludedPathsEvent`. Subscribe to
add paths that should never be fetched (any request path *containing* one of these strings is
skipped):

```php
use Drupal\stage_file_proxy\EventDispatcher\AlterExcludedPathsEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyExcluder implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return ['stage_file_proxy.alter_excluded_paths' => 'onAlter'];
  }

  public function onAlter(AlterExcludedPathsEvent $event): void {
    $event->addExcludedPath('private-uploads');
    // also: setExcludedPaths([...]), getExcludedPaths(), removeExcludedPath('x')
  }

}
```
