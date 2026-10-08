<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Cloud Vision augmentor plugins

Two Augmentor plugins, both extending `GoogleCloudVisionBase` →
`Drupal\augmentor\AugmentorBase`. They are configured and run through the **Augmentor** module's
own UI, not through any route this module adds.

## Install / enable

1. `composer require drupal/augmentor_google_cloud_vision` — this pulls in `drupal/augmentor`
   (`^1.1`) and the `google/cloud-vision` (`^1.9`) PHP SDK.
2. `drush en augmentor_google_cloud_vision`. The `key` module is required transitively by Augmentor
   for API-key storage.
3. Create a Google Cloud service account with the Vision API enabled, download its JSON key file,
   and place it somewhere readable by PHP but outside the web root.

## Credentials (Key entity)

`GoogleCloudVisionBase::setEnvironmentalCredentials()` (in `src/GoogleCloudVisionBase.php`):

```
if (!getenv('GOOGLE_APPLICATION_CREDENTIALS')) {
  putenv('GOOGLE_APPLICATION_CREDENTIALS=' .
    $this->getKeyObject()->get('key_provider_settings')['file_location']);
}
```

- Create a **Key** entity (Configuration → System → Keys) whose provider stores a **file location**
  — the provider settings must expose `file_location` pointing at the service-account JSON. The
  base class exports that path as the `GOOGLE_APPLICATION_CREDENTIALS` env var so the Google SDK's
  Application Default Credentials flow loads it. It does **not** read the JSON contents itself.
- `getKeyObject()`/`getKey()` come from `AugmentorBase`; the Key is chosen per-augmentor via the
  `#type => 'key_select'` "API key" field that `AugmentorBase::buildConfigurationForm()` adds.
- If the env var is already set at the OS/DDEV level, the module leaves it untouched.

## Configuration (per augmentor instance)

Configured on Augmentor's augmentor add/edit form (webservices → augmentors). Base fields from
`AugmentorBase`: **Label**, **API key** (`key_select`), **Enable debugging**. Each plugin adds:

**`google_cloud_vision_labels_detection`** (`VisionLabelsDetection.php`), `defaultConfiguration()`:
- `max_labels` (number) — cap on labels returned. Note: the `execute()` loop breaks once
  `count($labels) >= max_labels`, so leaving it null/0 yields no labels.
- `min_score` (number, step .01, form default 0.7) — confidence threshold shown in the UI. It is
  stored but **not applied** in `execute()` (labels are taken in order, not score-filtered).

**`google_cloud_vision_safe_search`** (`SafeSearch.php`), `defaultConfiguration()`:
- `send_image_path` (checkbox) — when checked, `loadImage()` sends an absolute URL
  (`file_url_generator->generateAbsoluteString($path)`) instead of raw bytes, to avoid base64
  memory issues on large images; Google then fetches that URL.

Settings persist in the augmentor's own config entity (owned by the `augmentor` module); this
module ships **no `config/install` or `config/schema`** of its own.

## Running / output

Both implement `execute($path)`:

- **Labels** — `ImageAnnotatorClient::labelDetection(file_get_contents($path))`, iterate
  `getLabelAnnotations()`, collect `getDescription()` up to `max_labels`. Returns
  `['default' => [$label, …]]`, or `['_errors' => '…check the logs…']` when empty.
- **Safe search** — `ImageAnnotatorClient::safeSearchDetection($image)` where `$image` is the raw
  bytes or the absolute URL; `parseDetectionResult()` returns
  `['adult'=>[…], 'spoof'=>[…], 'medical'=>[…], 'violence'=>[…], 'racy'=>[…]]`, each value the
  Vision likelihood enum wrapped in a one-element array.
- On any `\Throwable` both `close()` implicitly is skipped, log
  `Google Cloud Vision API error: %message`, and return an `_errors` string (rendered plain text).
- To invoke from code: load the augmentor plugin through Augmentor's plugin manager / augmentor
  entity and call `->execute($imagePathOrUri)`; the return array is what downstream Augmentor
  steps consume.

## What it does NOT provide

No OCR/text detection, no object localization, no web-detection — only the label and safe-search
plugins above. No routes, permissions, Drush commands, or hooks beyond `hook_help`
(`AugmentorGoogleCloudVisionHooks::help`).
