<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sightengine integrates the Sightengine content-moderation SaaS so image, video and text field values are validated against nudity/violence/profanity/PII models when an entity is saved.

---

The module lets a site block objectionable user-submitted content without a manual review queue. On the settings form at `/admin/config/people/sightengine` an administrator enters the Sightengine app `client_id` / `client_secret`, the three API endpoint URLs (text, image, video validators), and picks which detection models to run — image/video models (nudity, weapons/alcohol/drugs, gore, offensive) and text "ignore" models (profanity, personal data such as email/phone/IP, links). Moderation is turned on per field: the module alters the field-config edit form (`sightengine_form_field_config_edit_form_alter`) to add a "Sightengine validate" checkbox for string, text, image, file and entity_reference fields, storing the flag in `sightengine.settings` under `fields.<entity>.<bundle>.<field>`.

At runtime `hook_entity_bundle_field_info_alter` calls `SightengineManager::addConstraintForFields()`, which attaches a validation constraint (`sightengine_text`, `sightengine_image`, or `sightengine_file`) to each enabled field. When the entity is validated, the constraint's validator (`SightengineTextValidator`, `SightengineImageValidator`, `SightengineFileValidator`) builds a multipart POST — text sends the string plus mode/language; image/file sends the file via `CurlFile` — and posts it through the Drupal `http_client` (Guzzle) to the configured validator URL. `SightengineManager::getValidateResponse()` decodes the JSON; if a model score exceeds 0.5 (and is not in the ignore list) the validator calls `$context->addViolation()`, so the entity save fails with a message naming the offending category. The file validator resolves media entities to their underlying file and routes images vs. videos to the image/video moderation calls.

Operational and security notes: the API endpoint URLs are admin-configured (not request-derived), requests go over Guzzle with default TLS verification, and the only route is the admin settings form gated by the `administer sightengine` permission. The `client_secret` is stored in module config in cleartext (standard for this kind of API integration) and is sent as `api_secret` on every moderation request. Because validation runs synchronously on entity save, each save of a moderated field makes a blocking outbound API call (text timeout 100s, image timeout 10s), so latency and API quota are the main operational concerns.

---

- Install the module and grant the `administer sightengine` permission to trusted admins only.
- Create a Sightengine account and obtain the app `client_id` (API user) and `client_secret` (API secret).
- Visit `/admin/config/people/sightengine` and enter the client ID and secret under "App informations".
- Set the Text validator URL to the Sightengine text-moderation endpoint.
- Set the Image validator URL to the Sightengine image-moderation endpoint.
- Set the Video validator URL to the Sightengine video-moderation endpoint.
- Choose text mode: "standard" or "username".
- Enter `opt_country` (ISO country codes) for phone-number detection in text.
- Under text "Ignore models", exclude profanity subtypes (sexual, discriminatory, insult, inappropriate, other) you do not want flagged.
- Ignore personal-data detections (email, phone number, IPv4, IPv6) as needed.
- Ignore URL/link detection in text if links are allowed.
- Select image models to run: nudity, weapons/alcohol/drugs, gore, offensive.
- Select video models to run: nudity, weapons/alcohol/drugs, gore, offensive.
- Enable moderation on a text/string field by editing the field and ticking "Sightengine validate".
- Enable moderation on an image field so uploaded images are scanned on save.
- Enable moderation on a file field so uploaded files are routed to image/video moderation.
- Enable moderation on an entity_reference (media) field to scan referenced image/video media.
- Reject nudity in avatar or gallery image uploads before they are published.
- Block posts containing insults or hate speech in a comment or body text field.
- Prevent users from posting email addresses or phone numbers in free-text fields.
- Screen uploaded videos for gore or weapons content.
- Review the `sightengine` logger channel for moderation/API errors.
- Tune the sensitivity by enabling/disabling specific models rather than editing the 0.5 threshold in code.
- Turn moderation off for a field by unticking "Sightengine validate" on the field edit form.
