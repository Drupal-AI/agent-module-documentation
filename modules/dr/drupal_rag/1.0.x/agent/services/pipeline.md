<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Indexing + query pipeline (services)

All services are wired in `drupal_rag.services.yml`.

## Indexing pipeline (write path)

### 1. Entity hooks → queue — `Hooks\EntityHooks`

`drupal_rag.module` implements legacy `hook_entity_insert/update/delete` and delegates to the
`drupal_rag.entity_hooks` service (also carries `#[Hook(...)]` attributes). For each event
`EntityHooks`:
- `isEnabledType()` — returns early unless the entity type is in `enabled_entity_types`.
- insert/update: only queues when `isPublished()` is TRUE (`EntityPublishedInterface::isPublished()`;
  entities without that interface are treated as published). delete: always queues (removal).
- `createItem()` on queue **`drupal_rag_entity_processing`** with `entity_type`, `entity_id`,
  `entity_label` (`DrupalRagQueueCommands::getLabel()` — node label / file filename / else id),
  `event_type`, `bundle`, `langcode`.

`entity_presave` is a disabled placeholder (no-op) to avoid double-queuing.

### 2. Queue worker — `Plugin\QueueWorker\DrupalRagEntityProcessingWorker`

`#[QueueWorker(id: "drupal_rag_entity_processing", cron: ['time' => 60])]`. `processItem()`:
null `entity_id` → return; else `EntityExtractor::extract()` → (empty text logs a warning and
returns) → `Chunker::chunk()` → `EmbeddingService::generateEmbeddings()` →
`VectorStorage::storeEmbedding()` with the current `ollama_model`. Note: `processItem` does not
branch on `event_type`, and delete removal relies on `storeEmbedding` deleting prior chunks first.

### 3. `Service\EntityExtractor`

`extract($entityTypeId, $entityId)`: loads the entity; if type `file` (and a `File`), delegates to
`FileTextExtractor::extract($entity->getFileUri())`. Otherwise renders the entity with the
configured `view_mode` (default `full`) via the view builder + `renderer->renderInIsolation()`, then
`Html::decodeEntities(strip_tags(...))`.

### 4. `Service\FileTextExtractor`

Matches by lowercase extension of the file URI:
- Plain text (`txt csv json xml md mdown markdown log yml yaml`): `file_get_contents` on the
  resolved realpath (`html`/`htm` are `strip_tags`ed).
- Office (`docx xlsx pptx odt ods odp`): `ZipArchive` + `simplexml`/DOM. `docx` uses
  `extractDocxAll()` (DOMXPath over `w:p`/`w:t`).
- PDF (`pdf`): `PrinsFrank\PdfParser\PdfParser::parseString()->getText()`.
- All reads go through `fileSystem->realpath()` + `is_file`/`is_readable` guards; the URI is the
  managed file's own URI (not request/config supplied). No shell-out.

### 5. `Service\Chunker`

`chunk($text, ?size, ?overlap)`: collapses whitespace, uses `chunk_size`/`chunk_overlap` config.
Text ≤ chunk_size → single chunk. Otherwise walks the string, snapping the cut to the last sentence
boundary (`... ! ? . \n\n \n`) found past the halfway point, then steps back by `overlap` (with an
infinite-loop safety clause). Returns `[['text' => ..., 'index' => n], ...]`.

### 6. `Service\EmbeddingService`

`generateEmbedding()` (query path) / `generateEmbeddings()` (indexing path): `sanitizeText()`
(strip tags, `html_entity_decode`, collapse whitespace) then prepends a model prefix
(`search_query: ` for queries, `search_document :` for documents — note the literal in source) and
calls `OllamaClient::embed()`.

### 7. `Service\OllamaClient` (`final`)

Guzzle `http_client` + config. Constructor pings `{base_url}/api/ps` and surfaces reachability
errors via `messenger`. `embed($text)` → `POST {base_url}/api/embed` `{model, input}`.
`chat($message, $model=null)` → `POST {base_url}/api/chat` `{model, messages, stream:false}`,
returns `['response' => message.content]` (or `['error' => ...]`). `getOllamaModels()` →
`GET {base_url}/api/tags`. The base URL is admin config only (`ollama_base_url`); requests use the
Guzzle default TLS/verify settings.

### 8. `Service\VectorStorage` (`final`)

Uses the **`pgvector`** DB connection. `ensureTable()` lazily creates `drupal_rag_embeddings`
(native `vector(768)`, HNSW cosine index) and `ensureVectorColumn()` migrates a non-vector column.
`storeEmbedding()` — **upsert**: deletes existing rows for `(entity_type, entity_id, bundle)` via
`deleteEntityEmbeddings()` then inserts each chunk (skipping entries whose embedding has an `error`
or no vector) using the query builder `insert()->fields()` (parameterized); the vector is stored as
the literal `'[' . implode(',', $vector) . ']'`.

## Query pipeline (read path)

### `Service\RagQueryService` (`final`)

`query($text, $options)`: `EmbeddingService::generateEmbedding()` → take
`embedding['embeddings'][0]` → `VectorStorage::similaritySearch($vectors, $limit, $minScore,
$model)` → map rows to result items. Empty/error embedding → `[]`.

`VectorStorage::similaritySearch()` runs a **parameterized** query (`:vector`, `:minScore`,
`:limit`):
```sql
SELECT entity_type, entity_id, entity_label, bundle, chunk_index, model, chunk_text,
       1 - (embedding <=> :vector::vector) AS similarity
FROM drupal_rag_embeddings
WHERE (1 - (embedding <=> :vector::vector)) > :minScore
ORDER BY embedding <=> :vector::vector
LIMIT :limit
```

### `Service\AugmentService` (`final readonly`)

`buildPrompt($query, $options)`: retrieves via `RagQueryService::query()`, formats each chunk as
`[Document: entity_type:entity_id \`label\`]\n<chunk_text>`, joins with blank lines, and
`strtr()`s them into the `prompt_template` (`{{context}}`, `{{query}}`); returns `prompt` + `sources`.
`generate()`: builds the prompt, calls `OllamaClient::chat()`, returns `response` + `sources` +
`prompt` (+ `error` if any). `defaultTemplate()` supplies the fallback template.
