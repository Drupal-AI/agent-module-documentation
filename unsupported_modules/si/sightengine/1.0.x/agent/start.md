<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sightengine (sightengine) — agent index

**Integrates the Sightengine SaaS to validate image, video and text field values against nudity/violence/profanity/PII models on entity save.**

- **Version:** 1.0.x (info.yml has no version; composer.lock reports `dev-1.0.x`, branch `1.0.x`)
- **Core:** ^8.8.4 || ^9 || ^10 || ^11
- **Package:** Web services

**Route:** `sightengine.settings` → `/admin/config/people/sightengine` (admin config form), `_permission: administer sightengine`, `_admin_route: TRUE`.
**Permission:** `administer sightengine`.
**Menu link:** under `system.admin_config_content`.

**Services:**
- `sightengine` → `Drupal\sightengine\SightengineManager` (attaches constraints, posts to the API via `\Drupal::httpClient()`).
- `imageModeration` / `videoModeration` → image/video constraint validators.
- `logger.channel.sightengine`.

**Constraints (plugins):** `sightengine_text`, `sightengine_image`, `sightengine_file` — added at runtime by `SightengineManager::addConstraintForFields()` via `hook_entity_bundle_field_info_alter`; enabled per field through the "Sightengine validate" checkbox added to the field-config edit form. A model score > 0.5 (not in the ignore list) triggers `$context->addViolation()`, failing the entity save.

**Config:** `sightengine.settings` holds `client_id`, `client_secret`, `validator_url.{text,image,video}`, `opt_country`, `mode`, `models.{image,video,text_ignore}` and per-field `fields.<entity>.<bundle>.<field>` flags.

**Security:** single admin settings route gated by `administer sightengine`; no anonymous or mutating endpoints. Outbound moderation calls use Guzzle with default TLS verification; validator URLs are admin-configured (not request-driven, no SSRF). `client_secret` is stored in config cleartext and sent as `api_secret` — standard for this integration.

See [configure/settings.md](configure/settings.md)
