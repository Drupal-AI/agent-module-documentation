<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI LLMs.txt Generator (ai_llms_txt_generator) — agent index

Generates a spec-compliant `/llms.txt` (an [llmstxt.org](https://llmstxt.org/) Markdown site
summary for LLM crawlers) by fetching your **sitemap.xml**, ranking its URLs by priority, and
summarizing them with the **Drupal AI** module's default chat provider. Package *SEO & Metadata*.
Core `^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version 1.0.1.

- **Config object, settings form, routes, permission, services** →
  [config/settings.md](config/settings.md)

## Dependencies

- `ai:ai` (drupal/ai) — provides the chat provider abstraction (`ai.provider`). **Required.**
- `simple_sitemap:simple_sitemap` — declared as a module dependency (produces the sitemap the
  generator reads); `composer.json` lists it only as a `suggest`, but `.info.yml` requires it.
- No other libraries, no submodules, no entities, no plugins, no Drush.

## What it provides

- **Routes** (`ai_llms_txt_generator.routing.yml`):
  - `ai_llms_txt_generator.llms_txt` — `GET /llms.txt` → `LlmsTxtController::content()`;
    permission `access content`. Serves stored config as `text/plain; charset=utf-8` with
    `X-Robots-Tag: noindex`. Read-only; does **not** call the AI.
  - `ai_llms_txt_generator.settings` — `/admin/config/search/ai-llms-txt` → `LlmsTxtSettingsForm`;
    permission `administer ai llms txt settings`.
  - `ai_llms_txt_generator.generate` — `POST /admin/config/search/ai-llms-txt/generate` →
    `GenerateController::generate()`; permission `administer ai llms txt settings`. Runs the
    parse + AI pipeline and saves the result (JSON response).
- **Permission** (`ai_llms_txt_generator.permissions.yml`): `administer ai llms txt settings`.
- **Config** (`config/schema/ai_llms_txt_generator.schema.yml`): `ai_llms_txt_generator.settings`
  — `site_name`, `site_description`, `sitemap_url`, `generated_content`, `content`
  (manual append), `last_generated`. No `config/install/` defaults; created on first save.
- **Services** (`ai_llms_txt_generator.services.yml`):
  - `ai_llms_txt_generator.sitemap_parser` = `Service\SitemapParserService` (`@http_client`,
    `@logger.factory`) — GETs the sitemap URL, `simplexml_load_string`, recurses into a sitemap
    index, returns `[loc, priority, changefreq]`; `formatForAi()` builds the priority-grouped text.
  - `ai_llms_txt_generator.ai_generator` = `Service\AiGeneratorService` (`@ai.provider`,
    `@config.factory`, `@logger.factory`) — `generateContent()` builds a prompt and calls the
    default chat provider via `getDefaultProviderForOperationType('chat')`.

## Mechanism (from source)

- `GenerateController::generate()` and `LlmsTxtSettingsForm::generateCallback()` run the same
  pipeline: `parseSitemap($sitemap_url)` → `formatForAi()` → `AiGeneratorService::generateContent()`
  → save `generated_content` + `last_generated`.
- `LlmsTxtController::content()` returns `generated_content ?: content ?: placeholder` — it only
  reads config, never triggers a model call.
- Output is `text/plain`; content is AI-generated Markdown cleaned by
  `cleanGeneratedContent()` (strips code fences). No filesystem write — the body lives in config
  and is served from a route.
