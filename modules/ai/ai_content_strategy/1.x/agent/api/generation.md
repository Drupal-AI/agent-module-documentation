<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generation pipeline & AI provider

All LLM calls go through the AI module's abstraction — the module never talks to a vendor API,
manages keys, or sets TLS options itself. Services are wired in `ai_content_strategy.services.yml`.

## Provider access
- Injected service `ai.provider` (`\Drupal\ai\AiProviderPluginManager`).
- `$defaults = $provider_manager->getDefaultProviderForOperationType('chat')` then
  `$provider = $provider_manager->createInstance($defaults['provider_id'])`.
- Calls: `$provider->chat(new ChatInput([new ChatMessage('user', $prompt)]), $defaults['model_id'], ['content_strategy'])`.
- Responses decoded with `ai.prompt_json_decode` (`PromptJsonDecoderInterface`) or a regex
  `Json::decode` fallback for the "generate more ideas" array path.

## Building context (`ContentAnalyzer`, `src/Service/ContentAnalyzer.php`)
- `getSiteStructure()` — site name, the front-page node rendered then `strip_tags`'d, and the
  primary (`main`) menu active-trail items (only if `menu_ui` is enabled).
- `getSitemapUrls()` — fetches `/sitemap.xml` via the core `http_client` (Guzzle) and walks
  `<urlset>`/`<sitemapindex>` iteratively; returns a flat URL list. This is a same-site fetch of a
  fixed path, not a user-supplied URL.

## Full generation (`StrategyGenerator::generateRecommendations()`)
1. `checkHealth()` verifies a usable chat provider + default model, else throws.
2. Gathers site structure + sitemap URLs (throws if no URLs).
3. System role = `ai_content_strategy.settings:system_prompt` (or hardcoded default) plus a
   "return valid JSON matching the schema" instruction.
4. Prompt built by `CategoryPromptBuilder::buildStrategyPrompt()` from every **enabled** category's
   `instructions` (`CategorySchemaBuilder::getEnabledCategories()`), embedding the site data and a
   JSON schema example; requires exactly 2 cards × 5 ideas per category.
5. Decoded JSON stored verbatim in the key-value collection (UUIDs added via
   `RecommendationStorageService::ensureUuids()`/`ensureIdeaUuids()`).

`ContentStrategyController::generateRecommendationsAjax()` wraps this, saves results, and returns
AJAX commands that render the cards (theme `ai_content_strategy_recommendations_items`).

## Incremental generation
- `generateMore($section, $uuid)` — inline XML-ish prompt asking for 5 more idea strings for one
  card; expects a JSON array of strings; appends via `RecommendationStorageService`.
- `addMoreRecommendations($section)` — `CategoryPromptBuilder::buildAddMorePrompts()` returns a
  system+user pair (tokens replaced by `replaceTokens()`); expects `{<section>: [2 cards]}`; merges
  into stored data.

## Schema (`CategorySchemaBuilder`)
- `buildSchema()` composes a draft-07 object schema keyed by enabled category id, each an array of
  `{title, description, priority(enum high/medium/low), content_ideas[]}`. Cached permanently under
  `ai_content_strategy:composite_schema`, invalidated on category save/delete.

## Error handling
- `buildUserFriendlyErrorMessage()` maps provider/rate-limit/auth/network/parse failures to guidance
  strings; `getHttpStatusFromException()` echoes a 4xx/5xx exception code onto the AJAX response.
- Exceptions are logged through the `logger.channel.ai_content_strategy` channel.
