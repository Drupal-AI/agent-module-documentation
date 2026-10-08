<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The HTTP stream wrapper & remote file entities

## Services (`remote_stream_wrapper.services.yml`)

| Service id | Class | Tag |
|---|---|---|
| `stream_wrapper.http` | `…\StreamWrapper\HttpStreamWrapper` | `stream_wrapper`, `scheme: http` |
| `stream_wrapper.https` | `…\StreamWrapper\HttpStreamWrapper` | `stream_wrapper`, `scheme: https` |
| `file.mime_type.guesser.http` | `…\File\MimeType\HttpMimeTypeGuesser` | `mime_type_guesser`, `priority: 10` |

Because of the tags, `http` and `https` appear in
`\Drupal::service('stream_wrapper_manager')->getWrappers(StreamWrapperInterface::ALL)`.
`HttpStreamWrapper::getType()` is `READ & HIDDEN`, so the schemes are **not** offered as
upload/storage destinations in field settings — they are for reading and for URIs you set yourself.

## "Is it remote?" — the three global functions

Defined in `remote_stream_wrapper.module` (procedural, always available once the module is on):

```php
file_is_scheme_remote('https');                     // TRUE
file_is_uri_remote('https://example.com/a.png');    // TRUE
file_is_wrapper_remote($wrapper_or_class);          // is_subclass_of(..., RemoteStreamWrapperInterface::class)
```

All three ultimately test `RemoteStreamWrapperInterface`. Implement that interface in your own
stream wrapper and the rest of the module (including image-style routing) treats your scheme as
remote too. The interface adds one method beyond `StreamWrapperInterface`:

```php
public function request(string $method = 'GET'): \Psr\Http\Message\ResponseInterface;
```

plus the constants `REMOTE = 0x0002` and `REMOTE_NORMAL = 0x0016`.

## Create a managed file entity for a remote URL

The whole point of the module — no download, no local copy:

```php
use Drupal\file\Entity\File;

$file = File::create([
  'uri' => 'https://example.com/assets/photo.png',
  'status' => 1,           // permanent
]);
$file->save();

$file->getFileUri();       // https://example.com/assets/photo.png
$file->createFileUrl(FALSE);  // same URL — getExternalUrl() returns the URI unchanged
$file->getMimeType();      // image/png — guessed by file.mime_type.guesser.http on save
```

`filename` is optional; core derives it from the URI. Set it explicitly if you want a friendly
label. Reference the file from any file/image field by `target_id` as usual.

Read one back:

```php
$remote = \Drupal::entityTypeManager()->getStorage('file')
  ->loadByProperties(['uri' => 'https://example.com/assets/photo.png']);
```

Find every remote managed file on a site:

```php
foreach (File::loadMultiple() as $f) {
  if (file_is_uri_remote($f->getFileUri())) {
    printf("%d %s\n", $f->id(), $f->getFileUri());
  }
}
```

## Reading bytes

Standard PHP filesystem calls route through the wrapper (Guzzle does the work):

```php
file_exists('https://example.com/a.txt');        // url_stat() -> HEAD/GET
$body = file_get_contents('https://example.com/a.txt');
$fh   = fopen('https://example.com/a.txt', 'r'); // only r / rb / rt
```

Direct access to the response when you need headers:

```php
$w = \Drupal::service('stream_wrapper_manager')->getViaUri($uri);
$response = $w->request('HEAD');                 // ResponseInterface
$len = $response->getHeaderLine('Content-Length');
```

## Read-only limits (things that will NOT work)

`ReadOnlyPhpStreamWrapperTrait` traps every mutating operation — it raises an
`E_USER_WARNING` and returns FALSE:

- `fopen()` with `w`/`a`/`x`/`c` (any non-read mode), `fwrite()`, `ftruncate()`
- `unlink()`, `rename()`, `mkdir()`, `rmdir()`, `touch()`, `chmod()`
- `stream_cast()` — so `stream_select()`/`file_put_contents()`-style helpers warn

Also: `realpath()` returns **FALSE** (guard any code that calls it), `dirname()` is computed
purely from the string, and `getName()`/`getDescription()` are both `'HTTP stream wrapper'`.
Deleting the *file entity* is fine — only the remote bytes are untouchable.

## MIME type guessing

`HttpMimeTypeGuesser::guessMimeType($path)`:

1. returns NULL immediately for non-external paths (`UrlHelper::isExternal()`);
2. parses a filename **with an extension** out of the URL path and asks the core extension
   guesser — this is the cheap, no-network path;
3. otherwise does `requestTryHeadLookingForHeader($path, 'Content-Type')` (HEAD, falling back to
   GET on a 4xx/5xx) and returns the `Content-Type` value with any `; charset=…` stripped and
   lower-cased;
4. logs and returns NULL on exception (channel `remote_stream_wrapper`).

Call it directly with `\Drupal::service('file.mime_type.guesser.http')->guessMimeType($url)`.
