<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Vectorize VDB Provider (ai_vdb_provider_vectorize) — agent index

**Registers Cloudflare Vectorize as a Vector Database provider for the Drupal AI module's Search API backend.**

- **Version:** 1.0.x (1.0.0-alpha3)
- **Core:** ^10.5 || ^11 || ^12
- **Depends on:** ai, ai_search, search_api, cloudflare_ai, cloudflare_sdk, cloudflare_api
- **Configure route:** `ai_vdb_provider_vectorize.settings_form` → `/admin/config/ai/vdb_providers/vectorize` (perm: `administer ai providers`)
- **Key plugin:** `Plugin/VdbProvider/CloudflareVectorize` (VdbProvider); `VectorizeMapper` for field→metadata mapping
- **Security:** single admin settings route gated on `administer ai providers`; no anonymous, no mutating public endpoints; Cloudflare credentials handled via the cloudflare_* SDK modules.

See [configure/settings.md](configure/settings.md)
