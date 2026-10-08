<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AWS AI Augmentor is a submodule of Augmentor that exposes Amazon AI services as Augmentor plugins, letting the Augmentor framework enrich content by calling AWS APIs.

---

It ships one plugin today — **AWS Rekognition Detect Faces** — which takes an image path, streams the raw bytes, and calls Rekognition's `DetectFaces` with `Attributes => ['ALL']`, returning the per-face detail array as the augmentor output. The plugin's configuration form only asks for the AWS SDK API **version** (default `latest`) and **region code** (default `ap-southeast-2`); it deliberately removes the generic Augmentor "key" field. AWS credentials are NOT entered in Drupal — per the README they are supplied to the AWS SDK for PHP through the standard AWS credential chain (environment variables / instance profile), so no secret is stored in module config. The module depends on `augmentor` and pulls in `aws/aws-sdk-php` via Composer.

Because the plugin is driven through Augmentor, it inherits Augmentor's access model: configuring/running augmentors is gated behind the `administer augmentors` permission (which the README explicitly flags as security-sensitive and for trusted roles only). There are no custom routes, callbacks, or anonymous endpoints. Operationally, each execution issues a paid AWS Rekognition call, so the cost surface is bounded by who can create/run augmentors.

---

- Add AWS Rekognition face detection as an Augmentor plugin.
- Detect faces in an uploaded image and return per-face attributes.
- Choose the AWS region the Rekognition client connects to.
- Set the AWS SDK service version used by the plugin.
- Supply AWS credentials via environment variables (12-factor style).
- Supply AWS credentials via an EC2/ECS instance role instead of config.
- Enrich media/content using AWS AI without storing a secret in Drupal.
- Run the augmentor from an entity field configured with the plugin.
- Trigger the augmentor as part of an Augmentor action pipeline.
- Restrict augmentor creation/execution to trusted roles.
- Extend the module with additional AWS AI Service plugins.
- Bound AWS API cost by limiting who holds `administer augmentors`.
- Return face-detail data for downstream processing or storage.
- Read raw image bytes from a file path for Rekognition analysis.
- Integrate AWS AI into an existing Augmentor-based workflow.
- Pull in `aws/aws-sdk-php` automatically via Composer.