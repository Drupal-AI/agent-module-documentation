AI Content Advisor renders a node, sends it to an AI model, and stores an AI report of improvement recommendations.

---

AI Content Advisor analyzes a node's rendered content with a configured drupal/ai chat model and stores an AI-generated report of recommendations. Editors reach it from a per-node "Analyze Content with AI" tab (or an entity operation, contextual link, or block): they pick a report type, optionally edit the prompt, choose the published node or a specific moderated revision, and generate a report. Reports are saved in the module's own database table so they can be revisited and compared over time. Report types are configurable prompt templates stored as config entities — the module ships SEO-oriented defaults (full, topic authority, natural language, link analysis, headings and structure) inherited from the AI SEO Analyzer project, but you can add your own for readability, editorial, accessibility or brand-compliance analysis. The AI provider/model and an optional custom system prompt are set on the module settings page, and access is controlled by granular permissions. Requires the AI module with a configured chat provider and the league/commonmark library; generating reports calls the AI provider and incurs usage cost.

---

- Get an AI SEO audit of a page from the node's "Analyze Content with AI" tab.
- Generate a readability/content-quality review of an article.
- Create custom report types (prompts) for editorial or brand-voice checks.
- Run an accessibility-oriented content review via a custom report type.
- Analyze a specific moderated revision (e.g. a draft) instead of the published node.
- Analyze the page as an anonymous visitor to respect access restrictions.
- Keep a history of reports per node and compare newer to older ones.
- Review the exact HTML that was analyzed and the prompt that was used.
- Set a site-wide AI provider/model for all content analysis.
- Override the system prompt to steer tone and scope of analysis.
- Give some roles view-only access to reports and others the ability to create them.
- Restrict who can create reports (which incur provider cost) via permission.
- Embed the latest report for a node using the provided block.
- Trigger analysis from a node's entity-operations dropdown or contextual links.
- Migrate from AI SEO Analyzer while keeping familiar SEO analysis.
- Produce topic-authority guidance for content strategy.
- Check heading structure and hierarchy of a page.
- Review internal/external link usage and anchor text.
- Assess natural-language quality and keyword integration.
- Standardize content-quality checks across an editorial team.
