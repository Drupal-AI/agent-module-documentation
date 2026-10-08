# Cloudflare Stream — services & upload flow

## `cloudflare_stream` (Drupal\cloudflare_stream\Service\CloudflareStream)
Thin reader over `cloudflare_stream.settings`. Methods: `getApiToken()`, `getAccountId()`,
`getCustomerSubdomain()`, `debugEnabled()`, and `listAllowedFileExtensions()` (returns the fixed
video-extension whitelist string).

## `cloudflare_stream.api` (…\Service\CloudflareStreamApi implements CloudflareStreamApiInterface)
Guzzle wrapper over the Cloudflare Stream REST API. Base URL:
`https://api.cloudflare.com/client/v4/accounts/{account_id}/stream`; every call sends
`Authorization: Bearer {api_token}`. Timeout 600s. Methods:

| Method | HTTP | Purpose |
|---|---|---|
| `uploadVideoByHttpRequest(File $file)` | POST (multipart) | Simple single-request upload of a file's bytes. |
| `initiateTusUpload(int $length, string $creatorId='', string $metaData='')` | POST | Starts a TUS resumable upload; returns `TusUploadParameters(ready, destinationUrl, videoId)` from the `location` + `stream-media-id` response headers. |
| `getEmbedCodeHtml(string $id)` | GET `/{id}/embed` | Cloudflare-provided embed HTML. |
| `getDetails(string $id)` | GET `/{id}` | Video metadata (`result`), or `[]`. |
| `deleteVideo(string $id)` | DELETE `/{id}` | True on HTTP 200. |
| `listVideos(after, before, include_counts, search, limit, asc, status)` | GET | Paged video list; used by the stream wrapper directory reads and the Sync submodule. |
| `validateToken(string $token)` | GET (user/tokens/verify) | Token validity check used by the settings form. |

Errors go through `handleError()`: logs the Cloudflare `errors` payload to the `cloudflare_stream`
channel, and — only if `debug_messages` is enabled — echoes it to the user via Messenger
(`FormattableMarkup` with a `<pre>`). The actual TUS byte transfer is done by
`Drupal\cloudflare_stream\Tus\UploadClient` (constructed with the upload URL, local file path, API
token, and logger).

## Upload / stream-wrapper flow (`cfstream://`)
`CloudflareStreamWrapper extends LocalStream`, scheme `cfstream`, service `cloudflare_stream.wrapper`.
DI can't run for PHP-instantiated wrappers, so it pulls services via `\Drupal::service()` in the
constructor (nullable params exist for tests). Write path:
1. Widget writes the selected file to `cfstream://<source_file>` → `LocalStream` buffers to a temp file
   (`getDirectoryPath()` = the file system temp dir).
2. `stream_close()` (mode `w`): stats the temp file, base64-encodes the name into TUS `Upload-Metadata`,
   calls `initiateTusUpload(length, metaData)`, then `UploadClient::upload()` pushes the bytes.
3. The returned `videoId` is stored in private tempstore (`tempstore.private`, collection
   `cloudflare_stream`) keyed by the URI, for `CloudflareVideoItem::preSave()` to reset the URI to
   `cfstream://<video-id>`; the local temp file is then unlinked.

Read path: `stream_open('r')` succeeds if `getDetails()` returns data for the id; `stream_stat()` /
`url_stat()` synthesize a read-only file stat from Cloudflare metadata; `unlink()` on a
non-local URI calls `deleteVideo()`. `getExternalUrl()` →
`https://{subdomain}.cloudflarestream.com/{id}/watch`.
