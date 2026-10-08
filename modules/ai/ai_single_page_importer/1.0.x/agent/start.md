<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Single Page Importer (ai_single_page_importer) — agent index

Adds an "AI Content Import" panel to node add/edit forms: fetch an editor-supplied URL, send its text to the site's `drupal/ai` chat provider, and populate the content type's fields via AJAX. Version **1.0.0-alpha4**. Core `^10 || ^11 || ^12`.

**Dependencies:** core `node`, `ai` (a configured provider/model on `ai.settings` `default_providers.chat`). No composer library deps.

**How it works (no custom entities/routes for import):**
- `ai_single_page_importer.module` — `hook_form_node_form_alter` injects the `ai_import` `details` fieldset (permission `use ai single page importer` + optional `allowed_content_types` gate). The `import_button` `#ajax` calls `ai_single_page_importer_import_callback()`, which flood-checks, validates the URL, fetches + extracts, and returns a `PopulateFieldsCommand`.
- `src/Ajax/PopulateFieldsCommand.php` — custom AJAX command `populateNodeFields`; `js/ai-single-page-importer.js` fills fields client-side (CKEditor 5 aware). The node is NOT saved by the module — normal node access applies.

**Services (`*.services.yml`):**
- `ai_single_page_importer.content_extractor` → `Service\AiContentExtractor` — Guzzle GET the URL, `cleanHtml()` via DOMDocument, build a field-requirements prompt, call the provider's `chat()`, JSON-decode, sanitize, return field map.
- `ai_single_page_importer.url_validator` → `Service\UrlValidator` — scheme allowlist (http/https), literal-IP private/reserved-range block, wildcard domain blacklist.
- `ai_single_page_importer.html_sanitizer` → `Service\HtmlSanitizer` — allow-tag sanitize (HTMLPurifier if present, else `strip_tags` + attribute regex).

**Permissions (`*.permissions.yml`):** `use ai single page importer`, `administer ai single page importer settings` (both `restrict access: true`).

**Route (`*.routing.yml`):** `ai_single_page_importer.settings` → `Form\SettingsForm` at `/admin/config/ai/ai-single-page-importer` (`administer ai single page importer settings`).

**Config:** `ai_single_page_importer.settings` — `max_content_length` (30000), `request_timeout` (30), `allowed_content_types` ([]), `domain_blacklist` (localhost/127.0.0.1/*.local/*.internal), `flood_limit` (5), `flood_window` (3600). Schema in `config/schema/`.

**Extension point:** `hook_ai_single_page_importer_field_map_alter(&$field_map, $field_definitions)` — add/override field-category mappings.

## Solution docs
- [config/settings.md](config/settings.md) — settings form, config keys, permissions, flood control.
- [api/import-flow.md](api/import-flow.md) — the fetch → clean → AI → populate pipeline, field categories, the alter hook.
