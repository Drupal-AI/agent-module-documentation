<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze AI Brand Voice is an Analyze-framework plugin that uses a configured AI chat provider to score how well each content entity aligns with your written brand voice guidelines, from -1.0 (off-brand) to +1.0 (on-brand).

---

The module adds one Analyze plugin (`analyze_ai_brand_voice_analyzer`). When a supported entity's Analyze tab is viewed, it renders the entity to plain text, combines it with an admin-defined brand voice guideline string, and sends both to the default chat provider from the AI module, requesting a single numeric alignment score. The score is displayed as a gauge and cached in a `analyze_ai_brand_voice_results` table keyed by a SHA-256 content hash and MD5 config hash, so it is only recomputed when the content or the guidelines change (and is deleted automatically on entity update/delete). A bundled Views report at `/admin/reports/brand-voice-analysis` lists scores across all content using Views Color Scales, and the Analyze batch system can score content in bulk. Content is sent to whichever AI provider is configured, so the provider key is a credential and analysed text leaves your infrastructure — a governance decision for confidential content — and each uncached analysis is a paid model call, so watch cost. Scores are advisory guidance, not a hard gate.

---

- Score how on-brand a node, term or other content entity is via its Analyze tab.
- Define brand voice guidelines in plain language at `/admin/config/analyze/brand-voice`.
- Find off-brand pages across an existing site without reading each one.
- Compare tone consistency between authors on the same content type.
- Show a visual -1.0 to +1.0 gauge to editors during content review.
- Enable the analyzer per entity type/bundle at `/admin/config/content/analyze-settings`.
- Review a site-wide, sortable, colour-coded brand voice report under Reports.
- Filter the report by content type, language and analysis date.
- Batch-score all articles with `drush analyze:batch --analyzers=analyze_ai_brand_voice_analyzer --types=node:article`.
- Force re-analysis after a guidelines rewrite with the batch `--force` flag.
- Run brand voice together with sibling Analyze plugins (sentiment, broken links) in one pass.
- Inherit brand voice defaults from CKEditor AI Agent when that module is installed.
- Override guidelines programmatically with `hook_ai_brand_voice_alter()`.
- Rely on automatic cache invalidation so scores refresh only when content or config changes.
- Prioritise rewrites by sorting the report by lowest score.
- Keep the AI provider key stored as a Key entity / env var, not plain config.
- Send only shareable content to the AI provider for confidential material governance.
- Track brand alignment over time via the report's "Last analyzed" column.
- Use any chat-capable AI provider (OpenAI, Anthropic, etc.) already set up in the AI module.
- Restrict the settings form to trusted editors via the `administer analyze` permission.
- Treat scores as advisory input to human review, not an automated publishing gate.
- Budget for per-analysis model cost when scoring large content volumes.
