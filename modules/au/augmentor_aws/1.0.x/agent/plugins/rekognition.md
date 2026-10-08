<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS Rekognition Detect Faces plugin

Plugin id `rekognition_detect_faces` (`src/Plugin/Augmentor/RekognitionDetectFaces.php`), an `AugmentorBase` implementation.

## Configuration
- **Version** (`version`, default `latest`) — AWS SDK service version.
- **Region Code** (`region_code`, default `ap-southeast-2`) — AWS region.
- The base Augmentor `key` field is removed (`unset($form['key'])`) — credentials do not come from Drupal.

## Credentials
Supply AWS credentials to the SDK via the standard AWS chain (environment variables `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`, or an EC2/ECS instance role). Nothing is persisted in module config.

## execute($path)
1. Opens `$path` (`fopen`/`stream_get_contents`) to read raw image bytes.
2. Instantiates `Aws\Rekognition\RekognitionClient` with the configured region/version.
3. Calls `DetectFaces` with `Attributes => ['ALL']`.
4. Returns `['default' => $result['FaceDetails']]`.

## Operational notes
- Each execution is a billable Rekognition API call; restrict `administer augmentors` to trusted roles.
- Runs are triggered through the Augmentor framework (fields/actions), not via any route this module defines.
