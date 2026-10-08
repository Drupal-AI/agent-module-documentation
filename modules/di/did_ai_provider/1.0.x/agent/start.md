<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D-ID AI Provider (did_ai_provider) — agent index

**Registers D-ID as an AI provider + Automator that turns audio + (image or presenter) into a talking-head MP4 stored in Drupal.**

- **Version:** 1.0.x · **Core:** ^10 || ^11 · **Depends on:** ai, key
- **Route:** `did_ai_provider.settings_form` → `/admin/config/ai/di-ai-provider` (permission `administer ai providers`).
- **Service:** `did_ai_provider.api` (`DidApiService`) — Guzzle client to `https://api.d-id.com/`, HTTP Basic auth from the Key value; endpoints images/audios/talks/clips/presenters.
- **Plugins:** AI provider `DidProvider`; AI Automator `DidImageAndAudioToVideo`. Output saved to `public://did_videos`.
- **Secrets:** API key resolved via Key module from `did_ai_provider.settings:api_key` — not hardcoded (`DidApiService.php` constructor).
- **TLS:** default Guzzle verification (enabled); no `verify=>false`. Basic-auth over HTTPS.
- **Security/cost:** single admin route; no anonymous endpoints. Generation runs from content automators and is a paid, long-polling (≤600s) external call — restrict automator use.

See [api/did-service.md](api/did-service.md)
