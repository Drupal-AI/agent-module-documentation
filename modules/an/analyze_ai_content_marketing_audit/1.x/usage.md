<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze AI Content Marketing Audit is an Analyze-ecosystem plugin that scores each content entity against configurable marketing factors (usability, actionability, business value, brand voice, funnel stage, and more) using a configured AI chat provider.

---

The module adds two Analyze plugins to the entity **Analyze** tab: a lightweight non-AI status plugin and the main **AI Content Marketing Audit** analyzer. The AI analyzer renders each enabled entity's default view mode, strips it to plain text, and sends it to the site's default AI chat provider (via the `ai` module's provider abstraction) asking for a JSON object of scores. Quantitative factors return a number between -1.0 and +1.0 (shown as a gauge); qualitative factors return one of a fixed option list (shown as a classification). Results are cached in a custom table keyed by a content hash and a config hash, so re-analysis only runs when the content or the factor configuration changes. Factors are fully manageable (add / edit / delete / reorder / enable) at an admin settings page, and a bundled View at `/admin/reports/content-marketing-audit` reports all stored scores with color-scaled columns. All admin routes require the `administer analyze` permission (owned by the parent Analyze module).

---

- Score every article against seven marketing factors from the node's Analyze tab.
- Identify low-performing content in a large library that needs rewriting.
- Surface high-performing content worth promoting or repurposing.
- Give a marketing team measurable criteria instead of gut-feel content decisions.
- Benchmark a new draft against proven marketing principles before publishing.
- Classify each page by marketing-funnel stage (Awareness / Consideration / Decision / Retention).
- Add a custom quantitative factor (e.g. "SEO strength") scored -1.0 to +1.0.
- Add a custom qualitative factor with your own discrete option list.
- Disable factors that do not apply to your content strategy without deleting them.
- Reorder factors by priority so the most important gauge shows first in the summary.
- Run a site-wide content audit via the Analyze batch interface (BatchableAnalyzerInterface).
- Review all scores across content types in the bundled Views report.
- Filter the audit report by factor, language, or content using the exposed Views filters.
- Use color-scaled score columns (via Views Color Scales) to spot outliers at a glance.
- Cache analysis results so opening the Analyze tab repeatedly does not re-bill the AI provider.
- Force a fresh re-analysis when content is edited (content-hash invalidation handles this).
- Restrict who can configure factors and view reports to trusted editors (administer analyze).
- Expose marketing-audit analysis to AI coding assistants through Analyze's Agent Skills file.
- Feed a low-temperature (0.2) model for consistent, repeatable scoring runs.
- Evaluate translated content per language (scores are stored per langcode).
- Combine with sibling Analyze plugins (security audit, sentiment) for a full content review.
- Show a single headline factor gauge in the compact Analyze summary on each entity.
- Present qualitative classifications and quantitative gauges together in the full report.
