<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Schema.org JSON-LD uses AI Automators to generate a Schema.org JSON-LD field for content entities and injects that structured data into each entity's canonical page head.

---

AI Schema.org JSON-LD is a "glue" module that wires together the Drupal AI ecosystem (AI Automators), Field Widget Actions, and JSON Field to give content entities an AI-generated `field_schemadotorg_jsonld` JSON field. On the entity edit form a "Generate Schema.org JSON-LD" button sends a token-based prompt (built from the entity's title, body, URL and full rendered content) to the site's default AI provider; the returned JSON is cleaned, validated, and stored in the field for a human to review and save. On the entity's canonical page the module emits the stored JSON-LD (and any per-entity-type default JSON-LD) as a `<script type="application/ld+json">` tag in the head. It supports any fieldable content entity type with a canonical link (nodes, media, taxonomy terms, users, comments, block content, and more), ships per-entity-type starter prompts, and adds a Drush command and a config action for scripted field provisioning. Two submodules extend it: a breadcrumb submodule that adds `BreadcrumbList` JSON-LD, and a log submodule that records prompt/response pairs for tuning. Configuration lives at `/admin/config/ai/schemadotorg-jsonld` behind the core `administer site configuration` permission.

---

- Add an AI-generated Schema.org JSON-LD field to a node content type (e.g. Article, Page).
- Generate JSON-LD for media entities, taxonomy terms, users, or comments.
- Emit `<script type="application/ld+json">` structured data into the canonical page head for search engines.
- Give content editors a one-click "Generate Schema.org JSON-LD" button on the edit form.
- Store structured data as a native, queryable JSON field rather than rendered markup.
- Customize the per-entity-type default AI prompt used to generate JSON-LD.
- Override the AI prompt per bundle via the AI Automator settings.
- Set a static default JSON-LD block injected for every page of an entity type.
- Include the full rendered entity (as seen by anonymous users) in the AI prompt via the `[<type>:ai_schemadotorg_jsonld:content]` token.
- Share a reusable "requirements" instruction block across all entity-type prompts.
- Add the JSON-LD field to a bundle from the command line with `drush ai_schemadotorg_jsonld:add-field`.
- Provision the JSON-LD field declaratively from a Drupal recipe using the `addField` config action.
- Build a machine-readable knowledge graph of your site's content for AEO/LLM discovery.
- Add `BreadcrumbList` structured data to pages by enabling the breadcrumb submodule.
- Log every AI prompt and response to review, debug, and improve generation quality.
- Download logged prompts and responses as CSV for offline SEO/AEO analysis.
- Filter logs to a single entity and review them from that entity's edit form.
- Copy generated JSON-LD to the clipboard for pasting into Google's Rich Results Test or the Schema Markup Validator.
- Iterate on prompts across different AI models to find the best structured-data output.
- Keep a human in the loop: AI proposes, an editor reviews and saves.
- Preserve manually curated JSON-LD properties while letting the AI extend them.
- Translate JSON-LD per language, since the field is translatable.
