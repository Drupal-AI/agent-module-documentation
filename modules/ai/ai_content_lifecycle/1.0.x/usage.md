<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Lifecycle asks the site's AI provider whether content is outdated and queues flagged items for editor review as tracking entities.

---

AI Content Lifecycle adds AI-assisted content governance. An administrator picks which content entity types and
bundles to check and writes a prompt describing what "outdated" means for each bundle. A batch process renders each
selected entity in a configured view mode, converts it to Markdown, and sends it with the prompt to the site's
configured drupal/ai chat provider, which must reply with strict JSON (`{mark_for_update, reason}`). When the model
marks an item, the module creates or updates a revisionable `content_life_cycle` entity that references the content
and stores the reason and a review status (pending, analyzed, reviewed, updated, ignored). Editors then work the
queue from the entity collection and an optional Views integration that relates lifecycle records back to their
nodes. Because it uses the drupal/ai provider abstraction, the module keeps no API keys or HTTP client itself. It
requires the `ai` module and runs on Drupal 10 and 11.

---

- Automatically flag outdated or incorrect content for human review.
- Define what "outdated" means per content type via a custom prompt.
- Detect content that mentions superseded facts (old tax rates, former officials, etc.).
- Check multiple content entity types and bundles from one settings screen.
- Run a batch analysis across all existing content of the enabled bundles.
- Choose which drupal/ai chat model performs the evaluation (or use the site default).
- Track a review status per item: pending, analyzed, reviewed, updated, ignored.
- Store the AI's reason for flagging alongside each tracked item.
- Keep a revision history of lifecycle records (revisionable entity).
- Skip items already marked "reviewed" or "ignored" on re-runs.
- Review flagged content in a Views listing that links lifecycle records to their nodes.
- Extract content for analysis using a specific view mode (default `search_index`).
- Override the analysis prompt from other modules via the `ai_content_lifecycle_prompt` alter hook.
- Support content-governance and editorial freshness workflows.
- Reassign or delete lifecycle records automatically when their author account is cancelled/deleted.
- Give governance teams a queue of AI-suggested content to refresh.
- Reduce manual auditing of large content archives.
- Centralize outdated-content triage for editorial teams.
