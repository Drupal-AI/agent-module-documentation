<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workers AI Provider registers Cloudflare Workers AI models with the AI module.

---

Workers AI Provider enables the use of Cloudflare Workers AI as a provider for the Drupal AI module — so models hosted on Cloudflare's Workers AI (edge-run LLMs and other models) become available for chat and related AI operations wherever the AI module offers a provider choice.

The Cloudflare API credential/account id is stored via the Key module (env-backed); requests send prompts to Cloudflare (cost + egress). Depends on `ai` and `key`; supports Drupal 10.2+ and 11.

---

- Add Cloudflare Workers AI as a provider.
- Use edge-run models.
- Provide chat operations.
- Register a provider plugin.
- Make Workers AI models selectable.
- Send prompts to Cloudflare (cost/egress).
- Store the credential via Key (env-backed).
- Depend on `ai` and `key`.
- Support Drupal 10.2+ and 11.
- Integrate with the AI provider abstraction.
- Configure models.
- Keep the key secure.
- Select Workers AI
- Route AI calls to Cloudflare
- Support edge AI.
- Complement other providers.
- Handle provider config.
- Integrate Cloudflare
