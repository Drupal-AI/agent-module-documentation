<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Single Page Importer adds an "AI Content Import" panel to node edit forms that fetches an external URL and uses an AI provider to populate the content type's fields.

---

AI Single Page Importer hooks into every node add/edit form (`hook_form_node_form_alter`) and, for users holding the `use ai single page importer` permission, shows a collapsible "AI Content Import" fieldset with a Source URL field and an "Import Content with AI" button. When clicked, the module fetches the page server-side with the Guzzle HTTP client, strips it to readable text, and asks the site's configured `drupal/ai` chat provider to map that text onto the fields that exist on the current content type (title, long-text body, short-text summaries, taxonomy terms, dates, links). The AI's JSON response is passed back over AJAX and filled into the form fields client-side (CKEditor 5 aware), for the editor to review and adjust before saving. It never saves the node itself — normal node create/edit access still applies.

Operationally: the feature is gated by two permissions — `use ai single page importer` (run an import) and `administer ai single page importer settings` (configure the module at `/admin/config/ai/ai-single-page-importer`). Because each import makes the server fetch an editor-supplied URL and then sends the page text to the AI provider (a billable external call), grant the use permission only to editors you trust and only import from sources you trust. Built-in controls include per-user flood limiting (default 5 imports/hour), a configurable domain blacklist, a scheme allowlist (http/https), a literal-IP private-range check, a maximum content length sent to the AI, and an HTTP request timeout. Requires core `node` and the `ai` module with a configured provider; supports Drupal 10, 11, and 12.

---

- Import a single web page into a new or existing node.
- Populate the title, body, and other mapped fields from a URL.
- Speed up editorial migration of articles and blog posts.
- Republish curated external content into structured Drupal fields.
- Auto-format extracted body content as clean HTML for CKEditor 5.
- Suggest taxonomy terms (tags/categories) from page content.
- Extract dates into ISO 8601 for date fields.
- Extract link fields from page content.
- Let non-technical editors import without hand-copying markup.
- Restrict the importer to specific content types via settings.
- Gate the import panel with `use ai single page importer`.
- Gate settings with `administer ai single page importer settings`.
- Limit imports per user with flood control (default 5/hour).
- Block unwanted source domains with a wildcard blacklist.
- Cap the amount of page text sent to the AI provider.
- Choose the AI provider/model via the site's `drupal/ai` configuration.
- Review AI-populated fields before saving the node.
- Extend supported field types with `hook_ai_single_page_importer_field_map_alter()`.
- Log every import to the `ai_single_page_importer` channel for auditing.
- Complement bulk migration tools for one-off single-page imports.
- Curate a content library from across the web.
