<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI 404 Redirect (ai_404_redirect) — agent index

**Uses the AI module to match 404 paths to content and suggest/auto-create redirects, with bot + rate-limit protection.**

- **Version:** 1.0.x (1.0.2)
- **Core:** ^10 || ^11
- **Depends:** redirect, system, views, views_bulk_operations, ai
- **Config route:** `ai_404_redirect.settings` → `/admin/config/search/ai-404-redirect` (`administer site configuration`)
- **Permission:** `administer ai 404 redirect` (restrict access: true)
- **Services:** `ai_404_redirect.event_subscriber` (Ai404RedirectSubscriber, EXCEPTION prio 50), `ai_404_redirect.analyzer` (AiRedirectAnalyzer → `@ai.provider`)
- **Entity:** `Ai404RedirectSuggestion` (confidence-scored). **Actions:** ApproveRedirect, RejectRedirect (VBO). **Queue:** async worker (`*.queue_workers.yml`).
- **Thresholds:** 404-count min (default 4), confidence tiers, auto-approval threshold; bot detection + per-IP rate limit (10+ unique 404s/hr) + exploit-path blocking.

**Security:** admin config + review routes are permission-gated (`administer site configuration`; custom perm marked restrict access). The public surface is only the 404 exception handler, which reads the request path, never writes on the anonymous request (analysis is queued), and applies bot/rate-limit/exploit filtering before invoking the LLM. No mutating anonymous endpoint. Outbound AI calls go through the ai module's provider (TLS handled there). Confirm the AI provider key is stored via Key/env, not in config.

See [configure/ai_404_redirect.md](configure/ai_404_redirect.md)
