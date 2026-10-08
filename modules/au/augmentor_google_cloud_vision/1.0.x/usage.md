<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Google Cloud Vision as an Augmentor provider, contributing two augmentor plugins that analyze an image for labels and for explicit (safe-search) content.

---

Google Cloud Vision Augmentor is a thin bridge between the Augmentor framework and Google's Cloud Vision API. It ships two Augmentor plugins — `google_cloud_vision_labels_detection` (returns descriptive labels for an image) and `google_cloud_vision_safe_search` (returns adult/spoof/medical/violence/racy likelihoods) — built on a shared `GoogleCloudVisionBase`. Both authenticate through a Key entity that points at a Google service-account JSON file: the base class reads the Key's `file_location` provider setting and exports it as the `GOOGLE_APPLICATION_CREDENTIALS` environment variable so the official `google/cloud-vision` PHP SDK (`ImageAnnotatorClient`) can pick it up. The module adds no routes, permissions, config schema, services (beyond the hook wrapper), or entities of its own — all configuration happens on Augmentor's own augmentor-management UI, gated by Augmentor's `administer augmentors` permission. It requires the `augmentor` module and the `google/cloud-vision` Composer library.

---

- Detect descriptive labels (tags) for an image via `google_cloud_vision_labels_detection`.
- Cap the number of returned labels with the plugin's *Max number of labels* setting.
- Set a *Min score* confidence threshold (0–1, default 0.7) for label detection.
- Screen uploaded images for explicit content with `google_cloud_vision_safe_search`.
- Get per-category likelihoods (adult, spoof, medical, violence, racy) from safe-search.
- Auto-moderate user-submitted image galleries before publishing.
- Flag potentially unsafe media for editorial review in a content workflow.
- Auto-generate alt-text candidates or tags from an image's detected labels.
- Enrich media library entities with AI-derived keywords.
- Chain the augmentor into an Augmentor processing pipeline on a media/image field.
- Authenticate to Google Cloud with a service-account JSON via the Key module (file provider).
- Reuse one Key entity across both plugins and other Augmentor providers.
- Send the image as bytes (default) by reading the file with the augmentor input path.
- Send the image as an absolute URL instead (safe-search *Send Image path* option) to avoid base64 memory pressure on large files.
- Run image analysis from custom code by loading the augmentor and calling `execute($path)`.
- Handle API/credential failures gracefully — plugins log the error and return an `_errors` message.
- Add Google Vision analysis to a headless/decoupled Drupal build through Augmentor.
- Combine Vision label output with other augmentors (e.g. LLM summarization) in one workflow.
- Support Drupal 10.2, 11, and 12 sites.
- Restrict who can create or edit these augmentors to trusted roles (`administer augmentors`).
- Localize the Google Cloud region/credentials by pointing the Key at the right service account.
