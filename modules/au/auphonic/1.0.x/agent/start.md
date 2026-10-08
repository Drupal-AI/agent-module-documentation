<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auphonic Core (auphonic) — agent index

Registers **Auphonic** (cloud audio post-production / loudness normalization, `https://auphonic.com/api/`)
as an `audio_to_audio` **AI provider** for the AI module. Package `AI Provider`. Depends on `ai` and
`key`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-beta3. Configure at
`/admin/config/auphonic/settings`.

## What it provides (from source)

- **Service `auphonic.api`** → `Drupal\auphonic\AuphonicApi` (args `@http_client`, `@config.factory`,
  `@key.repository`). Thin Guzzle client for the Auphonic REST API (HTTP Basic auth). See
  [api/client.md](api/client.md).
- **AI provider plugin** `AuphonicProvider` (id `auphonic`, `src/Plugin/AiProvider/AuphonicProvider.php`),
  implements `AudioToAudioInterface`; supported operation types: `audio_to_audio`. Presets act as models.
  See [plugins/provider.md](plugins/provider.md).
- **Settings form** `AuphonicConfigForm` (route `auphonic.settings`, permission
  `administer site configuration`) writing config object `provider_auphonic.settings`
  (`username`, `password` = a Key id). Menu link under `ai.admin_providers`.
  See [config/settings.md](config/settings.md).
- **API definition** `definitions/api_defaults.yml` (returned verbatim by
  `AuphonicProvider::getApiDefinition()`): defines the `audio_to_audio` input / authentication /
  configuration shape (`audio_binary`, `title`, `options`; `username`+`password`; config `title`).
- **Config schema** `provider_auphonic.settings` (`username`, `password` strings). No permissions of its
  own, no Drush, no hooks, no entities.

## Submodule

- **`ai_interpolator_auphonic`** — optional AI Interpolator field rule "Auphonic Normalize Audio" for
  file fields, using the same `auphonic.api` client. Documented separately at
  [modules/ai_interpolator_auphonic/1.0.x/agent/start.md](../modules/ai_interpolator_auphonic/1.0.x/agent/start.md).

## Key facts

- No public upload/production HTTP routes — the only route is the admin config form.
- Credentials: `username` in plain config; `password` resolved from a **Key entity** at runtime
  (never stored as a raw secret in this module's config).
- All API calls target the fixed host `https://auphonic.com/api/` over HTTPS.
