<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Cloud Vision Augmentor (augmentor_google_cloud_vision) — agent index

Provides two **Augmentor** plugins that call the **Google Cloud Vision API** to analyze an image.
Package `Augmentor`. Depends on `augmentor` (module) and `google/cloud-vision` `^1.9` (Composer
library, the official `ImageAnnotatorClient` SDK). Core `^10.2 || ^11 || ^12`. GPL-2.0-or-later.
Version 1.0.3.

- **The two plugins, their settings, credentials/Key setup, and how to run them** →
  [plugins/vision-augmentors.md](plugins/vision-augmentors.md)

## What it actually is

- Two augmentor plugins in `src/Plugin/Augmentor/`, both extending
  `Drupal\augmentor_google_cloud_vision\GoogleCloudVisionBase` (which extends `augmentor`'s
  `AugmentorBase`):
  - **`google_cloud_vision_labels_detection`** — `VisionLabelsDetection.php`. Label/tag detection.
    Settings: `max_labels`, `min_score` (default 0.7). Returns `['default' => [labels…]]`.
  - **`google_cloud_vision_safe_search`** — `SafeSearch.php`. Explicit-content likelihoods
    (adult/spoof/medical/violence/racy). Setting: `send_image_path` (bool). Returns those five
    keys, each a one-element array.
- **No OCR/text-detection plugin** despite the generic "vision" name — only the two above.
- `GoogleCloudVisionBase::setEnvironmentalCredentials()` reads the selected **Key** entity's
  `key_provider_settings['file_location']` and, if `GOOGLE_APPLICATION_CREDENTIALS` is not already
  set, `putenv()`s it so the Google SDK auto-loads the service-account JSON.
- Provides **no routes, no permissions, no config schema, no entities**. The only service is a hook
  wrapper (`src/Hook/AugmentorGoogleCloudVisionHooks.php`, `hook_help`); `.module` has a
  `#[LegacyHook]` shim. Administration is entirely Augmentor's own augmentor UI, gated by
  Augmentor's `administer augmentors` permission.

## Mechanism (from source)

- Each plugin's `execute($path)` calls `setEnvironmentalCredentials()`, news up an
  `ImageAnnotatorClient`, sends the image, maps the response to an array, `close()`s the client, and
  on any `\Throwable` logs `Google Cloud Vision API error: %message` and returns an `_errors` array.
- Image bytes: labels always use `file_get_contents($path)`. Safe-search's `loadImage()` sends the
  raw bytes by default, or — when `send_image_path` is on — an absolute URL from
  `file_url_generator->generateAbsoluteString($path)` (Google fetches the URL), to avoid base64
  memory pressure. `$path` is the augmentor input supplied by the enclosing Augmentor pipeline.
- TLS and request signing are handled by the `google/cloud-vision` SDK; the module makes no raw
  HTTP call. Credentials come from a Key entity (file provider), resolved to the
  `GOOGLE_APPLICATION_CREDENTIALS` env var at call time; on error the exception `getMessage()` is logged.
