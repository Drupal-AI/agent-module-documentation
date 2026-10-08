<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring AI 404 Redirect

## Prerequisites
- Enable and configure an AI provider in the **AI** module (`/admin/config/ai`) — OpenAI, Anthropic, etc. Store its API key with a Key entity / env variable, not plaintext config.
- Enable `redirect` and `views_bulk_operations`.

## Settings (`/admin/config/search/ai-404-redirect`, `ai_404_redirect.settings`)
- **enabled** — master on/off; when off the exception subscriber returns early.
- **AI provider / model** — used by `AiRedirectAnalyzer` via `@ai.provider` (chat operation) to pick a match.
- **404 count threshold** — minimum times a path must 404 before analysis (default 4).
- **Confidence tiers** — low/medium/high plus an **auto-approval threshold**; a suggestion at/above it (and past the count minimum) is turned into a real `redirect` entity automatically.

## How analysis runs
`Ai404RedirectSubscriber::onException` (priority 50) catches `NotFoundHttpException`, ignores `/admin`, `/system`, `/node`, `/user`, then filters bot/crawler user-agents, rate-limits IPs (10+ unique 404s/hour), and drops known exploit probes. Surviving paths are analyzed (AI + typo/keyword/path fallback) and stored as `Ai404RedirectSuggestion` entities with a 0–100 confidence score. Work is queued so the 404 page renders immediately.

## Review workflow
Open the Views-based suggestion list under the module's admin area. Use the VBO bulk operations **Approve** (`ApproveRedirect`) / **Reject** (`RejectRedirect`) to convert or discard suggestions. Approved suggestions create `redirect` module entities.
