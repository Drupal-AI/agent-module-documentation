<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Validations adds seven AI-backed validation rules to the Field Validation module so text, image, and audio fields can be passed or failed by an AI provider.

---

AI Validations integrates with the contributed Field Validation module to provide AI-powered field validation rules. Each rule is a `FieldValidationRule` plugin (backed by a Symfony Validator constraint/validator pair) that you attach to a field via Field Validation's rule-set UI. On entity validation the rule sends the field value to an AI provider configured through AI Core and interprets the response into a pass/fail. The seven rules cover: a custom XTRUE/XFALSE text prompt, native provider moderation, text classification and image classification (with a tag, finder type, and minimum confidence), a custom XTRUE/XFALSE image prompt (vision), object detection (with require/forbid keywords and AND/OR logic), and audio validation (speech-to-text transcription followed by an XTRUE/XFALSE chat evaluation of the transcript). It requires the AI Core module with at least one configured provider, the Field Validation module, and core Image. It provides no routes, permissions, Drush commands, or configuration forms of its own — provider/model selection reuses AI Core's `ai_provider_configuration` form element, and image rules can optionally apply an image style before sending to reduce token usage.

---

- Block user-submitted text an AI moderation check flags as hate speech, violence, or sexual content.
- Restrict moderation failures to specific categories (e.g. `hate,violence,sexual`) with a confidence threshold.
- Reject text your AI provider classifies as spam or off-topic above a confidence threshold.
- Enforce a content policy on a text field with a custom XTRUE/XFALSE prompt (e.g. "must mention the product").
- Require a comment or description field to be written in a particular language or tone.
- Reject uploaded images an AI classifier tags as NSFW or off-brand.
- Require uploaded photos to contain a specific element via a vision prompt (e.g. "shows a person wearing a hard hat").
- Require or forbid named objects in an image with object detection (e.g. "must contain person", "must not contain weapon").
- Combine multiple object-detection keywords with AND (all required) or OR (any) logic.
- Approve an image only when the requested object(s) are found, or disapprove when they are found.
- Validate audio uploads by transcribing them and checking the transcript against a custom prompt.
- Apply a downscale image style before sending an image to the provider to cut token cost.
- Attach several AI rules to one field alongside ordinary Field Validation rules.
- Reuse a site's default AI provider for an operation type without selecting a model per rule.
- Set a minimum confidence score so only high-confidence classifications fail validation.
- Choose exact, case-sensitive contains, or case-insensitive substring matching for classification/detection labels.
- Choose whether a rule skips or fails when the configured AI model is unavailable.
- Moderate free-text webform or node fields before they are saved.
- Gate a profile avatar or media field on an image-classification or object-detection rule.
- Validate a speech submission (audio field) for appropriateness before publishing.
