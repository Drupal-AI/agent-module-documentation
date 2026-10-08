<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File download route, attachment service & tokens

## Download route

`cmrf_form_processor.routing.yml`:

```yaml
cmrf_form_processor.download_file:
  path: '/cmrf/file/{fileid}'
  defaults:
    _controller: '\Drupal\cmrf_form_processor\Controller\DownloadFileController'
  requirements:
    _access: 'TRUE'
```

`Controller/DownloadFileController::__invoke(string $fileid)`:

1. Reads `hash` from the request query.
2. Loads the managed `file` entity by `$fileid`.
3. Reads the file's bytes and computes `Crypt::hashBase64($content)` (base64 of a SHA-256 digest).
4. Serves a forced-download `BinaryFileResponse` **only** if the supplied `hash` equals that digest;
   otherwise throws `UnauthorizedHttpException` (bad/missing hash) or `NotFoundHttpException`
   (no such file).

The route is intentionally anonymous: the content-hash acts as a bearer token so CiviCRM (which
receives these URLs as field values) can pull the file back. The URLs are generated in
`FormProcessorBaseHandler::formatSubmissionValue()` for managed-file elements whose submission
format is `url`, via `Url::fromRoute('cmrf_form_processor.download_file', ['fileid'=>…, 'hash'=>…])`.

## Attachment download service (`File/File`, `cmrf_form_processor.file`)

`download(string|array $url, string $subPath)` fetches CiviCRM-supplied attachment URL(s) with a
Guzzle client and stores them under `private://cmrf_form_processor/<current-user-id>/<subPath>/`.
The filename is parsed from the response `Content-Disposition` header (`filename="…"`, `basename()`
+ `urldecode()`; the extended `filename*` form is rejected). The saved file passes through Drupal's
`FileUploadHandler` with `FileNameLength` and `FileExtension` validators (so the site's
dangerous-extension policy applies), using `FileExists::Rename`. If a file with the same name is
already present in the destination it is reused (id returned) rather than re-downloaded.

The URLs handed to this service come from CiviCRM Form Processor replies (attachment/default values)
resolved in `DefaultDataHandler::prepareForm()` and `FormProcessorBaseHandler::setElementValue()`
for `WebformElementAttachmentInterface` elements — i.e. the fetch target is defined by the
admin-configured CiviCRM backend, not by an arbitrary end-user field.

## Tokens (`cmrf_form_processor.module`)

Token type `cmrf-form-processor` with dynamic tokens:

| Token | Source |
|-------|--------|
| `[cmrf-form-processor:default-data:FIELD]` | `FormProcessorDefaults` reply, run through `convertFieldValueToHumanReadable()` |
| `[cmrf-form-processor:return-data:FIELD]` | the `FormProcessor` submission reply (`getReply()`) |
| `[cmrf-form-processor:calculated-data:FIELD]` | `FormProcessorCalculation` reply (needs `webform-element-data`) |

`convertFieldValueToHumanReadable()` maps stored option keys to their labels using cached Form
Processor field metadata. `default-data` tokens add the `url.path`, `url.query_args`, `user` cache
contexts. All three lookups are wrapped in try/catch and silently yield empty strings on error.
