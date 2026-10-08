<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI 404 Redirect intercepts 404 responses, uses the Drupal AI module to find the best-matching existing content, and records a redirect suggestion with a confidence score — optionally auto-creating the redirect.

---

An exception subscriber (`Ai404RedirectSubscriber`, priority 50 on `KernelEvents::EXCEPTION`) catches `NotFoundHttpException`s, skips admin/system/node/user paths, and — when enabled — hands the path to `AiRedirectAnalyzer`. Analysis is throttled by a configurable 404 count threshold (default 4) and shielded by bot/crawler detection, per-IP rate limiting (blocks IPs hitting 10+ unique 404s/hour), and exploitation-pattern detection (wp-admin, .env, SQLi probes). Matching combines the configured AI provider (chat) with a fallback algorithm (typo/keyword/path-structure). Each result becomes an `Ai404RedirectSuggestion` content entity with a confidence score; suggestions at or above the auto-approval threshold and count minimum can be turned into real `redirect` entities automatically. Processing is queue-based so the 404 page still renders instantly.

Admins review suggestions through a Views-based UI with VBO approve/reject bulk actions (`ApproveRedirect`, `RejectRedirect` action plugins) at the settings/review screens under `/admin/config/search/ai-404-redirect`. Configuration (provider, confidence tiers, thresholds, enable flag) lives in `ai_404_redirect.settings`. All admin surfaces are gated by `administer site configuration` / the module's `administer ai 404 redirect` permission (marked restrict access). Requires a configured AI provider in the AI module.
---
Automatically suggest a redirect target for a broken URL.
- Auto-create redirects when AI confidence is high.
- Review AI redirect suggestions in a Views admin list.
- Bulk-approve redirect suggestions with VBO.
- Bulk-reject redirect suggestions with VBO.
- Set a minimum 404 count before a path is analyzed.
- Set low/medium/high confidence tiers.
- Set the auto-approval confidence threshold.
- Detect and skip bot/crawler 404 traffic.
- Rate-limit IPs that hammer many unique 404s per hour.
- Block known exploitation probe paths (.env, wp-admin, SQLi).
- Choose which AI provider/model performs the matching.
- Fall back to typo/keyword matching when AI is unavailable.
- Process 404 analysis asynchronously via a queue worker.
- Keep 404 pages fast by deferring analysis.
- Approve a single suggestion into a redirect entity.
- Reject a suggestion to prevent a redirect.
- Enable or disable the whole feature from settings.
- Restrict redirect review to trusted admins via permission.
- Score each suggestion 0–100 for confidence.
- Skip admin, node, user and system paths from analysis.
- Turn recurring 404s into permanent redirects for SEO.
