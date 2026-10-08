<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI LLMs.txt Generator — configuration, routes & services

## Install / enable

```
composer require drupal/ai_llms_txt_generator
drush en ai_llms_txt_generator
```

Requires `drupal/ai` (with a chat-capable provider configured and set as the default for the
`chat` operation type at `/admin/config/ai`) and, per `.info.yml`, `simple_sitemap` to produce
the sitemap the module reads. `hook_install()` only shows a status message; `hook_uninstall()`
deletes the `ai_llms_txt_generator.settings` config object.

## Config object `ai_llms_txt_generator.settings`

Schema `config/schema/ai_llms_txt_generator.schema.yml` (no `config/install/` defaults — the
object is created on first save of the settings form):

| Key | Type | Meaning |
|---|---|---|
| `site_name` | string | Name seeded into the AI prompt; falls back to `system.site` name. |
| `site_description` | text | Optional description seeded into the prompt. |
| `sitemap_url` | uri | Absolute URL of the sitemap.xml to fetch and parse. **Required** in the form. |
| `generated_content` | text | The AI-generated llms.txt body (served first). |
| `content` | text | Manual/additional content (served if `generated_content` is empty). |
| `last_generated` | integer | UNIX timestamp of the last successful generation. |

## Routes & permissions (`ai_llms_txt_generator.routing.yml`)

- `ai_llms_txt_generator.llms_txt` — `GET /llms.txt`, permission `access content`.
  `LlmsTxtController::content()` (src/Controller/LlmsTxtController.php) returns
  `generated_content ?: content ?: placeholder` as `text/plain; charset=utf-8` and sets
  `X-Robots-Tag: noindex`. **Read-only**: it serves stored config and never invokes the AI
  provider, so exposing it to `access content` (which anonymous users hold on most sites) does not
  trigger any model calls.
- `ai_llms_txt_generator.settings` — `/admin/config/search/ai-llms-txt`, permission
  `administer ai llms txt settings`. `LlmsTxtSettingsForm` (a `ConfigFormBase`).
- `ai_llms_txt_generator.generate` — `POST /admin/config/search/ai-llms-txt/generate`, permission
  `administer ai llms txt settings`. `GenerateController::generate()` returns a `JsonResponse`.

Permission (`ai_llms_txt_generator.permissions.yml`): **`administer ai llms txt settings`** —
"Manage and edit the contents of the AI LLMs.txt file." Both write paths (the settings form and
the generate endpoint) are gated by this permission.

## Settings form `LlmsTxtSettingsForm`

`src/Form/LlmsTxtSettingsForm.php` (services: `sitemap_parser`, `ai_generator`, `date.formatter`).
Fields: Site Name, Site Description, Sitemap URL (`#type url`, required), a **Generate LLMs.txt
with AI** AJAX button, the generated-content textarea, and an optional manual-content textarea.
`getEditableConfigNames()` returns `['ai_llms_txt_generator.settings']`.

`generateCallback()` (AJAX) runs `parseSitemap()` → `formatForAi()` → `generateContent()`, writes
`generated_content` + `last_generated`, and refreshes the textarea. `submitForm()` persists
`site_name`, `site_description`, `sitemap_url`, `generated_content`, and `content`.

## Services & pipeline

- **`SitemapParserService`** (src/Service/SitemapParserService.php)
  - `parseSitemap(string $sitemap_url): array` — `httpClient->request('GET', $sitemap_url)`,
    `simplexml_load_string()`. For a `<urlset>` it collects `loc`, `priority` (default 0.5),
    `changefreq`. For a `<sitemapindex>` it **recurses** into each child `<loc>`. Errors are
    logged and return `[]`.
  - `formatForAi(array $urls): string` — buckets URLs into high (>=0.8, up to 20), medium
    (0.5-0.8, up to 15), low (<0.5, up to 10) priority and renders a plain-text list.
- **`AiGeneratorService`** (src/Service/AiGeneratorService.php)
  - `generateContent(string $sitemap_data, array $options = []): ?string` — resolves the default
    chat provider via `AiProviderPluginManager::getDefaultProviderForOperationType('chat')`,
    `createInstance()`, builds a `ChatInput` (system + user message), calls
    `$provider->chat($messages, $model_id)->getNormalized()`, extracts `getText()`, then
    `cleanGeneratedContent()` (strips ``` fences, trims). Returns `NULL` on any failure (all
    exceptions caught and logged to channel `ai_llms_txt_generator`).
  - `buildPrompt()` embeds `site_name`/`site_description` and the formatted sitemap into a fixed
    llms.txt-authoring prompt.
- API keys and TLS are entirely delegated to the `drupal/ai` provider layer; this module holds no
  credentials and makes no direct provider HTTP calls. The only HTTP call it makes itself is the
  Guzzle GET of the admin-configured sitemap URL (default TLS verification).

## Programmatic use

```php
$parser = \Drupal::service('ai_llms_txt_generator.sitemap_parser');
$gen = \Drupal::service('ai_llms_txt_generator.ai_generator');
$urls = $parser->parseSitemap('https://example.com/sitemap.xml');
$content = $gen->generateContent($parser->formatForAi($urls));
```
