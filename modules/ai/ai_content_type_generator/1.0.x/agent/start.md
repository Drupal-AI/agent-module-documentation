<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Type Generator (ai_content_type_generator) — agent index

**Generates or updates Drupal content types and fields from plain English via the site's configured AI Core provider.**

- **Version:** 1.0.x  •  **Core:** ^10.3 || ^11  •  **Package:** AI  •  **Depends on:** `node`, `field`, `text`, `ai`
- **Generate:** `/admin/structure/types/ai-generator` (`generate ai content types`; in-place updates also need core "Administer content types").
- **Settings:** `/admin/config/ai/content-type-generator` (`administer ai content type generator`, restricted).
- **AI:** delegates to AI Core (`AiGenerationService` → `$provider->chat()`); no API key stored, no direct provider calls, TLS/billing owned by AI Core.
- **Security:** Both routes permission-gated; paid AI calls are driven only by the restricted-to-trusted `generate` permission — grant sparingly (cost-abuse consideration). No hardcoded secrets or disabled TLS. No security findings.

See [configure/generate.md](configure/generate.md).
