<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — az_blob_fs

Namespace `Drupal\az_blob_fs`. Services declared in `az_blob_fs.services.yml`.

## The `azblob://` stream wrapper

Once configured, treat Azure like any Drupal scheme — no module API needed for basic file I/O:

```php
file_put_contents('azblob://docs/report.pdf', $bytes);   // block-uploads to the container
$data = file_get_contents('azblob://docs/report.pdf');   // downloads the blob
rename('azblob://a/x.jpg', 'azblob://b/x.jpg');          // copy-then-delete on Azure
unlink('azblob://docs/report.pdf');
$dir = opendir('azblob://docs');                          // lists blobs by prefix
```

- Service `stream_wrapper.az_blob_fs`, class `AzBlobFsStream` (extends `AzBlobFsStreamWrapper`),
  scheme `azblob`, type `StreamWrapperInterface::NORMAL`.
- The wrapper constructor **throws `AzBlobFsException`** if `az_blob_account_name` or
  `az_blob_account_key_name` is unset — file ops on `azblob://` fail fast when unconfigured.
- Writes buffer to `php://temp` and are committed as Azure blocks on `stream_flush()`; `Content-Type`
  is set from the built-in extension→MIME map (`getContentTypes()`).
- `getExternalUrl()` returns the public blob URL (via the proxy client's `getBlobUrl()`); for
  not-yet-generated `styles/…` derivatives it returns the internal `/azblob/files/styles/…` URL instead.
- Directories are virtual (Azure has no real folders): `mkdir()` is a no-op returning TRUE; folder
  existence is inferred from blob-name prefixes.

## `az_blob_fs` service (`AzBlobFsService`)

Args: `@database`, `@config.factory`, `@key.repository`.

- `getBlobContainer(): ?string` — configured container name.
- `getAccountName(): ?string` — configured account name.
- `getAzBlobProxyClient(array $data = []): ?AzBlobRestProxyAlter` — builds and returns the Azure blob
  client. Reads `az_blob_account_key_name` from config, resolves the **actual key value from the Key
  module** (`keyRepository->getKey($name)->getKeyValue()`), assembles the connection string
  (`DefaultEndpointsProtocol`, `AccountName`, `AccountKey`, optional `BlobEndpoint` for emulator,
  optional GovCloud `EndpointSuffix`). Returns NULL if the key name or resolved value is empty.

```php
$client = \Drupal::service('az_blob_fs')->getAzBlobProxyClient();
```

## `AzBlobRestProxyAlter`

Extends the SDK `MicrosoftAzure\Storage\Blob\BlobRestProxy`; created via
`AzBlobRestProxyAlter::createBlobService($connectionString)`. Adds:

- `getBlobUrl($container, $blob): string` — full public URL, honoring `az_blob_protocol` and rewriting
  the host to `az_blob_cdn_host_name` when set (skips protocol rewrite in emulator mode).
- `renameBlob($srcContainer, $srcName, $dstContainer, $dstName): bool` — copy then delete.
- `uriIsFile(string $uri): bool` — heuristic: last path segment contains a dot.
- `getPrefixedBlob($container, $uri)` — `getBlob` wrapper returning FALSE on `ServiceException`.

## Image-style warmer (`az_blob_fs.image_styles_warmer`)

Interface `AzBlobImageStylesWarmerInterface`, class `AzBlobImageStylesWarmer`. Called automatically from
`az_blob_fs_file_insert/update` and `az_blob_fs_crop_insert/update`, but callable directly:

```php
\Drupal::service('az_blob_fs.image_styles_warmer')->warmUp($file); // FileInterface
```

- `warmUp(FileInterface $file)` — generate `az_blob_initial_image_styles` inline and enqueue
  `az_blob_queue_image_styles`.
- `doWarmUp(FileInterface $file, array $image_styles)` — generate the given styles now.
- `addQueue(FileInterface $file, array $image_styles)` — push to queue `az_blob_fs_images_pregenerator`.
- `validateImage(FileInterface $file): bool` — TRUE only for permanent files on the `azblob` scheme that
  validate as a supported image (uses the image toolkit's supported extensions + `file.validator`).

## Notes for callers

- No `*.api.php`: the module invites no custom hooks and defines no plugin types.
- No Drush commands.
- The download controller `AzBlobFsImageStyleDownloadController::deliver()` is route-invoked only (open
  route, but core image-derivative token enforced); not a service you call directly.
