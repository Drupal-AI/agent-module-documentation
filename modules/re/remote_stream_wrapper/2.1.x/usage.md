<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Remote Stream Wrapper registers read-only `http://` and `https://` stream wrappers so Drupal can create managed file entities whose URI *is* the remote URL — the bytes are never copied to local disk.

---

The module is pure code: no settings form, no configure route, no permissions, no config schema, no plugin types, no Drush commands, and no module dependencies beyond core. It registers two services, `stream_wrapper.http` and `stream_wrapper.https`, both `HttpStreamWrapper` and both tagged `stream_wrapper` with their scheme, which makes `http`/`https` first-class Drupal schemes: `file_exists()`, `fopen()`, `file_get_contents()` and `File::create(['uri' => 'https://…'])` all work, backed by Guzzle. The wrapper is deliberately **read-only** — `ReadOnlyPhpStreamWrapperTrait` turns writes, `unlink()`, `mkdir()` and friends into warnings that return FALSE, `realpath()` returns FALSE, and `getExternalUrl()` just returns the URI unchanged. Three global helper functions (`file_is_scheme_remote()`, `file_is_uri_remote()`, `file_is_wrapper_remote()`) test whether a scheme/URI/wrapper implements `RemoteStreamWrapperInterface`, which is how the rest of the module — and your code — recognises a remote file. A third service, `file.mime_type.guesser.http` (tag `mime_type_guesser`, priority 10), guesses the MIME type of an external URL from its extension, falling back to a HEAD-then-GET request and the `Content-Type` header. For images, `hook_entity_type_alter()` swaps the `image_style` entity class for the module's subclass so `buildUri()` reroutes derivatives of remote originals into `public://styles/<style>/<scheme>/<host/path>`, and a route callback registers an `image.style_<scheme>` route per remote scheme, served by `RemoteImageStyleDownloadController`. `hook_requirements()` blocks installation when PHP's cURL extension is missing.

---

- Create a managed `file` entity for an image hosted on a CDN without downloading it to the local file system.
- Reference documents that live in an external DAM from Drupal fields while leaving the bytes where they are.
- Keep a Drupal site's disk footprint flat when cataloguing thousands of externally hosted assets.
- Migrate legacy content that stores absolute URLs into real file entities without a fetch step.
- Let `file_exists('https://example.com/report.pdf')` work as a normal PHP filesystem call.
- Read a remote file's contents with `file_get_contents()` using Drupal's HTTP client under the hood.
- Generate image-style derivatives (thumbnails, crops) from images hosted on another domain.
- Serve those derivatives locally from `public://styles/<style>/https/…` so they get cached like any other derivative.
- Detect the MIME type of an arbitrary external URL, even when the URL has no file extension, via its `Content-Type` header.
- Improve automatic MIME detection for remote attachments in an importer or feed.
- Distinguish remote from local files in custom code with `file_is_uri_remote($file->getFileUri())`.
- Guard file-processing code so it skips `realpath()` on remote URIs (which always return FALSE).
- Build a media source or field widget that accepts a URL instead of an upload.
- Attach externally hosted video posters or subtitle files to media entities.
- Catalogue partner-provided assets you are not licensed to rehost.
- Deduplicate storage across a multisite install by pointing every site at one canonical asset host.
- Prototype content quickly against remote sample images before assets are finalised.
- Make Drupal's usual file APIs work against S3/CloudFront URLs that are already publicly readable.
- Register your own remote scheme by implementing `RemoteStreamWrapperInterface` and get image-style routing for free.
- Write integration code that reads remote JSON/CSV through Drupal's stream layer instead of raw Guzzle calls.
- Enforce read-only semantics on external assets — Drupal cannot accidentally overwrite or delete them.
- Verify a remote asset is reachable and get its size/last-modified via the wrapper's `url_stat()`.
- Keep file URIs stable when a site moves hosts, because they were never host-relative to begin with.
- Audit which managed files on a site are remote versus local in a single query over `file_managed.uri`.
- Avoid a nightly sync job that mirrors a partner's media library onto local disk.
