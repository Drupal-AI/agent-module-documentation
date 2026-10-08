<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS AI Augmentor (augmentor_aws) — agent index

**Augmentor submodule adding AWS AI Service plugins (AWS Rekognition Detect Faces).**

- **Version:** 1.0.x
- **Core:** ^10.1 || ^11 || ^12
- **Requires:** `augmentor:augmentor`; Composer `aws/aws-sdk-php ^3.255`
- **Plugin:** `src/Plugin/Augmentor/RekognitionDetectFaces.php` (id `rekognition_detect_faces`) — configurable SDK `version` + `region_code`; `execute($path)` streams image bytes to Rekognition `DetectFaces`.
- **Hooks:** `src/Hook/AugmentorAwsHooks.php` (help only), OOP hook via services.yml autowire.
- **Credentials:** AWS SDK default credential chain (env vars / instance profile) — no secret stored in Drupal config.

**Security:** no custom routes; access governed by Augmentor's `administer augmentors` permission (trusted roles only per README). No TLS is disabled — the AWS SDK handles transport. Each run makes a billable AWS Rekognition call, so cost abuse is bounded by augmentor-admin access.

See [plugins/rekognition.md](plugins/rekognition.md)