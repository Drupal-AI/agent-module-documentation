<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Schema Markup Generator automatically produces Schema.org JSON-LD structured data for Drupal nodes with OpenAI and injects it into the page head to improve SEO rich-result eligibility.

---

The module adds two fields to every content type on install — a `field_schema_json` text field holding the generated JSON-LD and a `field_schema_json_checkbox` opt-in toggle. When a node is saved with the checkbox enabled, the module gathers the node's field values, builds a prompt, sends it to the configured OpenAI-compatible chat endpoint, asks the model to pick an appropriate Schema.org `@type` and return JSON-LD, optionally runs a second AI "validation" pass to correct invalid output, and stores the result on the node. On node view, a `hook_preprocess_node` implementation attaches the stored JSON-LD as a `<script type="application/ld+json">` tag in the HTML head. An admin settings form configures the endpoint, token, model, prompts, excluded fields and default content types; a separate bulk batch form generates schema across many existing nodes and can export a CSV report. Requires Drupal 10.3+/11, PHP 8.1+, and an OpenAI API key; it uses core Node/Field/File only (no contrib dependencies).

---

- Auto-generate Schema.org JSON-LD for nodes on save when the per-node checkbox is enabled.
- Let AI pick the most appropriate Schema.org `@type` (Article, Event, Product, Person, etc.) from content.
- Inject the generated JSON-LD into the page head automatically for rich-result eligibility.
- Run a second AI validation pass that corrects invalid schema before storing.
- Store the JSON-LD in an editable `field_schema_json` field so editors can review or hand-tune it.
- Bulk-generate schema across many existing nodes via the admin batch form.
- Filter bulk generation by content type, language, node limit, and batch size.
- Export a CSV report of the last bulk run (node id, type, title, schema, validation status).
- Enable schema generation by default for chosen content types.
- Configure the OpenAI endpoint, model, temperature, and token limits.
- Customise the schema-generation and validation prompt templates.
- Exclude specific fields (e.g. metatag/system fields) from the AI prompt.
- Add Article/NewsArticle schema to news or blog sites.
- Add Event structured data to event websites.
- Add Product schema to commerce catalogs.
- Reduce manual Schema.org maintenance on large sites.
- Feed image, date, link, and entity-reference field values into the schema prompt automatically.
- Log all API calls, successes, failures and validation results to Drupal watchdog.
- Point the endpoint at any OpenAI-compatible chat-completions API.
- Remove the stored schema automatically when the per-node checkbox is unchecked.
