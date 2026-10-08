<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auphonic Core registers the Auphonic cloud audio post-production service as an `audio_to_audio` provider for the AI module, so Drupal can send an audio file to Auphonic for loudness normalization / mastering and get the processed file back.

---

The module (`package: AI Provider`, depends on `ai` and `key`) does three things. (1) It ships a Guzzle-based API client service `auphonic.api` (`Drupal\auphonic\AuphonicApi`) that talks to `https://auphonic.com/api/` using HTTP Basic auth built from a configured **username** and a **Key**-stored **password**; it exposes `startSimpleProduction()`, `startProduction()` (create production → upload file → start), `getProduction()`, `getPresets()`, and `downloadProduction()`/`downloadProductionFromUuid()`. (2) It provides the AI provider plugin `AuphonicProvider` (id `auphonic`, `src/Plugin/AiProvider/AuphonicProvider.php`) implementing `AudioToAudioInterface`: `getConfiguredModels()` lists your Auphonic **presets** as selectable models, and `audioToAudio()` writes the input to a temporary file entity, starts a production against the chosen preset, polls the job (up to 20 tries, 5s apart) until status `3`, then downloads the first output file and returns it as an `AudioFile` inside an `AudioToAudioOutput`. Temporary file entities are deleted in the plugin destructor. (3) It provides a settings form `AuphonicConfigForm` at `/admin/config/auphonic/settings` (route `auphonic.settings`, permission `administer site configuration`, menu link under the AI providers admin) writing config object `provider_auphonic.settings` with `username` (plain string) and `password` (a Key id chosen through a `key_select` element). The password is resolved to its secret value at runtime via the Key repository, so the API secret is never stored directly in this module's config. The optional submodule `ai_interpolator_auphonic` wires the same client into an AI Interpolator field rule so a file field can be normalized automatically. Requirements: an Auphonic account (free tier ~2 hours/month); video normalization additionally needs FFmpeg on the server.

---

- Register Auphonic as an `audio_to_audio` AI provider so other modules can normalize audio through the AI module's operation API.
- Automatically level out a podcast or interview recording whose volume fluctuates.
- Normalize a batch of audio files that were recorded at different volumes to a consistent loudness.
- Master a voice recording (leveling, noise reduction, filtering) via Auphonic presets without leaving Drupal.
- Expose your Auphonic **presets** as selectable "models" in AI-provider-aware UIs.
- Send an uploaded MP3 to Auphonic and store the processed result back on the entity (with the submodule).
- Build an editorial workflow where uploading raw audio triggers cloud post-production.
- Use HTTP Basic credentials for the Auphonic API without hardcoding the password (password held in a Key entity).
- Keep the Auphonic secret out of exported config by referencing a Key provider (env, file, etc.).
- Poll a long-running Auphonic production to completion from a Drupal request.
- Download a finished Auphonic production's first output file as an in-memory binary for further handling.
- Pipe a downloaded production straight to a destination file (`sink`) instead of buffering it.
- Choose which Auphonic preset (algorithms, output format) is applied per production.
- Provide a title/metadata for each Auphonic production started from Drupal.
- Integrate audio normalization into the AI Automator / AI Interpolator pipeline for content entities.
- Give site builders a single admin form to connect a Drupal site to an Auphonic account.
- Prototype audio post-production in Drupal before wiring a fuller custom workflow on top of the `auphonic.api` service.
- Reuse the `auphonic.api` service directly from custom code to script Auphonic productions.
- Normalize audio derived from video (with FFmpeg installed) as part of a media pipeline.
