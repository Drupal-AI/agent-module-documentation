<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# C2PA Sign — signing pipeline, manifest & events

All logic is procedural in `c2pa_sign.module` plus the kernel subscriber
`src/EventSubscriber/C2paSignSubscriber.php`. Signing is delegated to the `jrglasgow/c2patool`
library (`Jrglasgow\C2paTool\Tool` and `\Signer`), which shells out to the `c2patool` CLI.

## Triggers → sign

- **Upload** — `hook_entity_presave` on a `file` entity → `c2pa_sign_presave_file()`. Only for new
  files (`!isset($file->original)`) and only if `assertions.upload`. Calls
  `c2pa_sign_create_manifest_and_sign($file, [...operation=upload...], FALSE)`.
- **Publish** — `hook_entity_insert`/`hook_entity_update` on `node` (or any
  `ContentEntityBase`) → `c2pa_sign_postsave_content_entity()`. Only when `assertions.publish`, the
  entity `isPublished()`, and it was NOT already published (`$entity->original?->isPublished()` is
  false). Loops file fields (`FileFieldItemList`) via `c2pa_sign_entity_publish_file_fields()` and
  signs each referenced file with `operation=publish` (resaving the file object).
- **Image derivative** — `C2paSignSubscriber::onKernelResponse` (priority -1000) on routes
  `image.style_public` / `image.style_private` (it also reconstructs the route/style from the path
  for styled files that have no route, e.g. drupal/webp — `emptyRoute()`). Requires
  `image_derivatives.add_manifests`. Builds a temp `File` for the derivative, creates an
  `image_derivative` manifest, and signs the derivative with the original as `--parent`. If
  `add_when_original_does_not_have_manifest` is false it first checks the source has a manifest and
  skips otherwise.

## `c2pa_sign_create_manifest_and_sign($file, $manifest_options, $resave_file_object, $entity)`

- Only handles `public://` and `private://` files. Resolves the absolute path via
  `FileSystem::realpath()`.
- Gates on `Signer::fileExtensionAllowed()` and `Signer::mimeTypeAllowed()` (allow-lists in
  `Signer` — jpg/png/webp/avif/tiff/dng/heic/svg, mp4/mov/avi, mp3/wav/m4a, etc.). Non-matching
  files are logged and skipped.
- Gets a `Signer` (`c2pa_sign_get_signer()`), builds the manifest (`c2pa_sign_create_manifest()`),
  then `$signer->sign($absolute_path, $absolute_path, $manifest, $absolute_path)` — signs in place
  (source == destination; the library writes to a temp destination then `rename()`s over the
  original). Updates `$file->setSize(filesize(...))`, saves the file only if `$resave_file_object`
  (avoids recursion), and on success calls `c2pa_sign_record_certificate_usage()`.

## `c2pa_sign_create_manifest(File $file, $options, $entity, $parent)`

Assembles a manifest array:

- Reads any existing manifest first (`c2pa_sign_get_manifest()` → `Tool::checkManifest()`); if one
  exists the action is `c2pa.opened`, else `c2pa.created`.
- `title` = filename; `claim_generator` / `claim_generator_info` built from `site.claim_generator`,
  the module version, Drupal version, and the logo (`c2pa_sign_get_logo()`) when configured.
- `vendor` derived from `$_SERVER['SERVER_NAME']`.
- Operation-specific actions: `upload` → `c2pa.creativeWork`; `publish`/`published` →
  `c2pa.published`; `image_derivative` → actions mapped from the ImageStyle effects
  (`c2pa_sign_image_style_to_actions()` / `..._effect_to_action()`: Scale/Resize→`c2pa.resized`,
  ScaleAndCrop→resized+cropped, Convert→`c2pa.converted`, Crop→`c2pa.cropped`,
  Desaturate→`c2pa.color_adjustments`, Rotate→`c2pa.orientation`; unknown effects can implement
  `c2paAction()`/`c2paMetadata()`, else `c2pa.unknown`).
- Actions collapse into a `c2pa.actions.v2` assertion; caller-supplied `assertions` (the custom
  `drupal.c2pa_sign.upload` / `.publish` / `.image_derivative` notes) are merged in.
- Dispatches `ManifestCreateEvent`; if a subscriber called
  `addPreventManifestEmbedReason()`/`isManifestEmbeddingPrevented()`, returns FALSE (no signing).

## `c2pa_sign_get_signer()`

`c2pa_sign_get_certs()` → chosen cert; new `Tool` (dispatch `CreateToolEvent`), `setBinary()` from
config; new `Signer($tool, $cert->uri, $cert->key_uri, $cert)`; dispatch `PreSignEvent`. The
`Signer` picks a signature algorithm from the cert (ES256/384/512, PS256/384/512, Ed25519) and, when
using file-based cert/key, injects `sign_cert` / `private_key` (file paths) into the manifest JSON;
with `ENVIRONMENT_VARIABLE` cert/key it omits those and relies on c2patool env handling. Default
timestamp authority: `http://timestamp.digicert.com`.

## Certificate usage tracking

`c2pa_sign_record_certificate_usage(Signer $signer)`: loads the cert public key (phpseclib3
`PublicKeyLoader`), computes the fingerprint, and `merge()`s into `c2pa_sign_certificate_uses`
(insert or `count = count + 1`). `c2pa_sign_get_certificate_usage($fingerprint)` reads it back.

## Events (`src/Event/`)

| Event | EVENT_NAME | Purpose |
|---|---|---|
| `ManifestCreateEvent` | `c2pa_sign_manifest_create_event` | Alter the manifest array before signing; carries the `File` and optional `ContentEntityInterface`; can prevent embedding via `addPreventManifestEmbedReason()`. |
| `CreateToolEvent` | `c2pa_sign_create_tool_event` | Alter/replace the `Tool` (e.g. environment) before a `Signer` is built. |
| `PreSignEvent` | `c2pa_sign_pre_sign_event` | Alter/replace the `Signer` immediately before signing (e.g. remote signer path, reserve size). |
| `CertificateValidateEvent` | `c2pa_sign_certificate_validate_event` | Provide custom validity for a cert the built-in `Signer::validateCert()` rejected; subscriber calls `isValid(TRUE)` to accept. |

## Library note

Signing (`Signer::sign()`) builds the c2patool invocation as an **array** of arguments passed to
Symfony `Process` (auto-escaped). Manifest data is written to a `tempnam()` file and passed as
`--manifest <path>`. The library's `Tool::executeCommand()` accepts either an array (escaped) or a
string (deprecated; interpreted as a shell command line).
