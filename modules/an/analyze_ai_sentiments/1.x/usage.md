<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze AI Sentiments is an Analyze submodule that scores content entities on configurable sentiment dimensions (trust, objectivity, audience fit, reading level) using the site's default AI chat provider.

---

The module adds a "Sentiments Analysis" plugin to the Analyze framework. When a content entity's Analyze tab is opened (or a batch run is triggered), it renders the entity to plain text, sends it to the configured AI chat provider (via the `ai` module's provider abstraction) with a prompt asking for a JSON object of scores, and displays each enabled dimension as a -1.0 to +1.0 gauge. Dimensions ("sentiments metrics") are fully customizable through an admin form — each has a label plus min/mid/max range labels and a weight — and are stored in simple config. Scores are cached in a custom database table keyed by entity, language, a SHA256 content hash and an MD5 config hash, so re-analysis only happens when the content or the dimension configuration changes. A bundled Views report (`/admin/reports/...`, gated by the Analyze permission `view analyze results`) lists scores across all content with color-coded scale columns supplied by Views Color Scales. It requires the `analyze`, `ai`, and `views_color_scales` modules and a configured AI chat provider; content is sent to that provider, so treat the provider key as a credential and only analyze content you are comfortable sending off-site.

---

- Score node (and other entity) content on sentiment dimensions from the Analyze tab.
- Measure Trust & Credibility (Overly Promotional to Authoritative).
- Measure Objectivity & Bias (Opinion-Based to Fact-Based).
- Estimate the target audience ("Audience Vibe Check": Gen Z to Boomer).
- Estimate CEFR reading level (A1 Beginner to C2 Proficient).
- Add your own custom sentiment dimension with bespoke min/mid/max labels.
- Rename or reorder the default dimensions to match your content strategy.
- Delete dimensions you do not need.
- Enable sentiment analysis per entity type and bundle via Analyze settings.
- Run batch analysis across an entire content library for a tone audit.
- Flag content that reads as too promotional or too complex for its audience.
- View a site-wide, filterable Views report of all sentiment scores.
- Filter the report by content type, language, or sentiment metric.
- See color-coded score columns via Views Color Scales integration.
- Have scores re-computed automatically when content is edited or deleted.
- Cache results to avoid repeat AI calls for unchanged content.
- Drive sentiment runs from an AI coding assistant via Analyze's Agent Skills (`drush analyze:setup-ai`).
- Keep the AI provider key in a Key entity / environment variable, not plain config.
- Restrict which content gets sent to the AI provider for confidentiality.
- Verify tone consistency across segments before publishing.
- Enforce credibility/objectivity standards for journalism or regulated content.
- Pair with sibling Analyze plugins (marketing audit, content security audit).
