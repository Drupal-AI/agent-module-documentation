<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI SEO/GEO analyzer sends a node's rendered HTML to an LLM (via the Drupal AI module) and returns an actionable on-page SEO and Generative Engine Optimization (GEO) audit, stored per node.

---

The module integrates with the [AI](https://www.drupal.org/project/ai) module: you pick a provider+model at `/admin/config/ai/seo` (config `ai_seo.settings`, key `provider_and_model`, plus optional `custom_system_prompt`/`custom_prompt` overrides and an `enable_field_buttons` toggle). The actual analysis prompts live in **`ai_seo_report_type` config entities** (config prefix `report_type`, so config names like `ai_seo.report_type.full`) — eight ship by default (`full`, `topic_authority`, `natural_language`, `link_analysis`, `headings_and_structure`, `schema_org_markup`, `ai_citability`, `agentic_readiness`), each holding an `id`, `label`, `description`, `prompt`, `status`, and a `default_prompt_hash` used to detect admin edits. Site builders manage these at `/admin/config/ai/seo/report-types`. From a node you trigger analysis via the "Analyze SEO" operation/contextual link or the node edit form's "AI SEO/GEO Analysis" sidebar, which can run a live streaming analysis of unsaved draft content, analyze an individual text field inline (when field buttons are enabled), or queue a background job (`ai_seo_analysis` queue worker, processed on cron). Completed reports are Markdown rendered to HTML (via `league/commonmark`) and saved in the custom `ai_seo` database table, viewable at `/node/{node}/seo`. Four permissions gate viewing reports, creating reports (which incurs API costs), and administering settings and report types. Core services are `ai_seo.service` (`AiSeoAnalyzer`), `ai_seo.report_service` (`ReportService`), and `ai_seo.render_entity_html`.

---

- Run a full AI-driven on-page SEO audit of a node and get prioritized, Drupal-specific fixes.
- Assess how likely a page is to be cited by AI search (Google AI Mode, ChatGPT, Perplexity) with the `ai_citability` report.
- Check "agentic search readiness" of a page with the `agentic_readiness` report type.
- Audit only the Schema.org / structured-data markup of a page with `schema_org_markup`.
- Focus an audit on heading hierarchy and content structure with `headings_and_structure`.
- Evaluate internal/external linking quality with the `link_analysis` report.
- Review readability and conversational tone with the `natural_language` report.
- Measure topical authority and depth with the `topic_authority` report.
- Add your own custom report type with a bespoke prompt at `/admin/config/ai/seo/report-types/add`.
- Disable a shipped report type you do not want offered by toggling its `status`.
- Select which AI provider and model powers analysis via `provider_and_model`.
- Prepend a site-wide custom system prompt or custom prompt to every analysis.
- Analyze unsaved draft content from the node edit form before publishing.
- Enable inline "SEO/GEO ✦" buttons on individual text fields for focused, per-field advice.
- Queue an SEO analysis to run in the background on save (via cron), avoiding a slow request.
- Store and revisit historical reports for a node at `/node/{node}/seo`.
- Restrict who can generate (paid) reports vs. who can only view them via permissions.
- Compare a node's SEO before and after content edits using saved reports.
- Give content editors an "Analyze SEO" link directly from the content listing operations.
- Localize analysis: prompts instruct the model to answer in the page's own language.
- Version-track report-type prompts as exported config for deployment across environments.
- Detect when an admin has customized a report prompt via the `default_prompt_hash` comparison.
- Build an editorial workflow where a "full" report is auto-queued after each node save.
- Audit any node type, since the report runs against the entity's rendered full view.
- Integrate SEO analysis into a larger AI stack by reusing the site's configured AI provider.
