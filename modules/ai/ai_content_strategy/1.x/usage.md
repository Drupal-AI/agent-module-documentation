AI Content Strategy analyzes a site's existing content and structure and uses a configured AI chat provider to return prioritized, EEAT-framed content-strategy recommendations.

---

The module adds an admin report at `/admin/reports/ai/content-strategy` where an administrator generates recommendation "cards" grouped into configurable categories (content gaps, authority topics, expertise demonstrations, trust signals, and any custom category). To build a prompt it reads the site name, the front-page node's rendered text, the primary navigation menu (when Menu UI is enabled), and the URLs discovered in `sitemap.xml`, then sends that context plus each enabled category's instructions to the default chat provider from the AI module (`drupal/ai`) via its provider abstraction (`ai.provider`). The JSON response is decoded and stored in a key-value collection, not in nodes or config — it never creates content types, taxonomy, or entities from the model output. Each card carries a priority and five content ideas; ideas can be edited inline (autosave), marked implemented, given a link, deleted, or expanded with "Generate more ideas". Categories are configuration entities managed at `/admin/config/ai/content-strategy/categories`, a global system prompt is set at `/admin/config/ai/content-strategy/settings`, and a full `drush acs:*` command set mirrors the UI for scripting. Recommendations are advisory output a human reviews and acts on.

---

- Generate AI content-strategy recommendations for a site.
- Identify content gaps in the existing content.
- Surface authority topics to build thought leadership.
- Suggest expertise demonstrations and trust signals (EEAT).
- Produce prioritized (high/medium/low) recommendation cards.
- Get five concrete content ideas per recommendation.
- Generate additional ideas for an existing recommendation on demand.
- Generate more recommendation cards within one category.
- Define custom recommendation categories with tailored AI instructions.
- Enable, disable, weight, and reorder recommendation categories.
- Set a global system prompt that shapes all generation.
- Edit recommendation titles, descriptions, and ideas inline with autosave.
- Mark ideas as implemented and attach a link to the published content.
- Delete individual cards or single ideas.
- Export all recommendations to CSV for spreadsheets or project tools.
- Export/import categories as configuration for multi-site deployments.
- Drive generation and CRUD entirely from Drush (`acs:generate`, `acs:report`, `acs:category:*`, `acs:export`).
- Check AI readiness before generating with `drush acs:health`.
- Analyze the site's sitemap and navigation for contextual grounding.
- Reuse any chat provider configured in the AI module (OpenAI, Anthropic, etc.).
- Install Agent Skills for AI coding assistants with `drush acs:setup-ai`.
- Track content-plan progress over time from the report page.
