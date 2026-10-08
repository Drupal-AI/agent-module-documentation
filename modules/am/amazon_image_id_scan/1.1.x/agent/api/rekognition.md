<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service: amazon_image_id_scan.rekognition (Rekognition)

`Drupal\amazon_image_id_scan\Services\Rekognition` (`src/Services/Rekognition.php`). Registered in
`amazon_image_id_scan.services.yml` as `amazon_image_id_scan.rekognition`, constructor arg
`@config.factory`. Wraps the bundled AWS SDK `Aws\Rekognition\RekognitionClient`. All comments and
error strings are Spanish. Get it with `\Drupal::service('amazon_image_id_scan.rekognition')`.

## connect(): self

Reads `amazon_image_id_scan.settings` → `rekognition_tab`, then builds a `RekognitionClient` with:

```php
$client_config['credentials'] = [
  'key'    => $credentials['key']    ?? FALSE,
  'secret' => $credentials['secret'] ?? FALSE,
];
$client_config['region']  = 'us-east-1';   // hardcoded
$client_config['version'] = 'latest';
$this->connect = new RekognitionClient($client_config);
```

Stores the client on `$this->connect` and returns `$this`. Region and version are fixed; there is
no error if credentials are missing (they fall back to `FALSE` and the AWS call fails at request
time). Requests are signed and sent by the AWS SDK (SigV4 over HTTPS to the Rekognition endpoint).

## document($image, $config, $prefix): string|array

Main validation entry point. `$image` is the raw image bytes, `$config` the profile array for the
selected id, `$prefix` the numeric profile id. Steps:

1. `connect()`, then `RekognitionClient::detectLabels(['Image' => ['Bytes' => $image], 'Attributes' => ['ALL']])`.
2. **Negative labels** — `unset($config[$prefix.'_negativo']['add'])`, then for every returned
   `Labels[].Name` matching a configured negative `label`, throw `RekognitionException` with that
   row's `error_description` (or a default Spanish message).
3. **Positive labels** — for each configured positive row, find the matching returned label; if its
   `Confidence` `>=` the row's `percentage` it passes, otherwise (or if the label is absent) throw
   `RekognitionException` with the row's `error_description`.
4. **OCR / regex** — calls `text($image)` (see below). If text was returned, it strips `.` and spaces
   from it and, for each `_regular_expresion` row, requires `preg_match($row['label'], $text)`;
   otherwise throws with the row's `error_description`. The `label` here is used directly as the PCRE
   pattern (admin-supplied). If `text()` returned an `['error' => …]`, that error array is returned.
5. On any thrown `RekognitionException` the method catches it and returns `['error' => $e->getMessage()]`.

Return value: the detected/processed text string on success, or `['error' => '…']` on any failure —
which the widget turns into a form-validation error.

## text($image, $nection = FALSE): string|array

Calls `RekognitionClient::detectText(['Image' => ['Bytes' => $image], 'Attributes' => ['ALL']])`
(re-connecting first only if `$nection` is TRUE — `document()` passes the already-connected client).
Concatenates every `TextDetections[].DetectedText` with a trailing space into the return string. If
`TextDetections` is empty it throws a `RekognitionException` (hardcoded Spanish "not a cédula" HTML
message) which is caught and returned as `['error' => …]`.

## Notes

- No image URL is fetched here — the caller (the widget) reads the file and passes bytes; Rekognition
  receives the bytes inline (`Image.Bytes`), not an S3 reference, despite the unused `load_s3`
  permission name.
- The Rekognition/text results are used only for pass/fail validation and as error-message text; the
  service returns plain strings/arrays and does not render markup itself.
- Unit tests: `tests/src/Unit/Services/RekognitionTest.php` mock the `RekognitionClient` and cover
  `connect()`, `document()` success/error, and `text()` success/error.
