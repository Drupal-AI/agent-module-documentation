<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migration — `AiMigrator` service, schema & caching

Service `ai_migration.ai_migrator` → `src/AiMigrator.php`. Injected: `ai.provider`, `ai_migration.cache_provider`, `logger.factory`, `http_client_factory`, `serializer`, `schemata.schema_factory`. The HTTP client is built once via `ClientFactory::fromOptions(['timeout' => 30])` (default Guzzle TLS verification remains on).

## `convert($prompt_manager, $url, $html, $entity_type, $bundle, $modelConfig): array|bool`
1. Resolve provider/model: `modelConfig['provider_id'|'model_id'|'structured_output'|'config']`, else `getDefaultProviderForOperationType('chat')`. `createInstance()` with a 300s http_client_options timeout; `setConfiguration($modelConfig['config'] ?? [])`.
2. `createSchema($entity_type, $bundle)` (below); logs schema at debug. On serializer failure → FALSE.
3. If `$html` empty, `httpClient->request('GET', $url)` and read the body (the parser normally passes already-fetched, html_processor-cleaned HTML, so this branch is a fallback). Fetch failure logs and returns FALSE.
4. Build user prompt: `str_replace('[ai:migration:content]', $html, $prompt_manager->getPrompt('user'))`.
5. Structured output on → `messages->setChatStructuredJsonSchema(decode(schema))`. Off → system prompt with `[ai:migration:schema]` replaced by the schema, via `setSystemPrompt()`.
6. Cache check: `cache->getPromptResponse($user_prompt, providerId, modelId)`; hit returns immediately.
7. `provider->chat($messages, $modelId, ['ai-migration'])->getNormalized()->getText()`; logs response at debug. Any exception → FALSE.
8. `decodeResponse()`; success → `cache->setPromptResponse(...)` then return the decoded `data` array.

## `createSchema($entity_type, $bundle): string`
`schemaFactory->create($entity_type, $bundle)` then `serializer->serialize($schema, 'schema_json:api_json')`. The JSON:API normalizers in `src/Normalizer/jsonapi/` (`AiMigrationSchemaNormalizer` prio 40, `FieldDefinitionNormalizer` prio 50, `RelationshipFieldDefinitionNormalizer` prio 55) shape the Schemata output into the schema handed to the model, so the AI is constrained to the destination content type's fields.

## `decodeResponse($response): array`
`preg_match('/\{.*\}/s', ...)` extracts the first `{`…last `}`, `json_decode(..., TRUE)`. Null → `AiResponseInvalidFormatException`. Requires a top-level `data` array (returned); otherwise throws. No `eval`/dynamic execution — the model output is parsed as JSON only, then fed to Migrate process mapping.

## Caching — `AiMigrationCacheBinProvider`
Service `ai_migration.cache_provider` over the tagged `ai_migration` cache bin (`ai_migration.cache_bin`). `AiMigrationCacheProviderBase::hashContent()` = `hash('xxh32', $prompt.$provider.$model)`; cid `ai_migrator:prompt:<hash>`. `setPromptResponse()` stores permanently by default; identical page+provider+model queries reuse the cached JSON instead of re-calling (and re-paying) the provider. Clearing all caches clears this bin too.

## Exceptions (`src/Exception/`)
`AiMigrationExceptionInterface` (marker), `AiMigrationNormalizeException`, `AiResponseInvalidFormatException`. Failures in `convert()` return FALSE and log to the `ai_migration` channel; the migration row is then simply not produced.

## Data-handling note
Fetched (and sanitized) page HTML is sent to the configured AI provider as chat input; confirm egress is acceptable for the content. Provider credentials/TLS are governed by the `ai` module. The fetch URL is set in the migration YAML by the operator, not by an incoming HTTP request.
