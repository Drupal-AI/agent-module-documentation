<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DifyClient — Dify Dataset/Knowledge API wrapper

`Drupal\dify\DifyClient` (`src/DifyClient.php`) is a thin Guzzle wrapper over the Dify
**Knowledge base (Dataset) v1 API**. Constant `DATASET_ENDPOINT = 'v1/datasets'`. It is **not**
registered as a container service — the `dify_search_api` backend constructs it directly with two
pre-configured Guzzle clients (both built via `http_client_factory->fromOptions()` with the
server's `base_uri` and a `Authorization: Bearer <api_key>` header; TLS verification is Guzzle's
default, i.e. on): `$client` for JSON requests and `$fileClient` for multipart file uploads.

## Constructor

`__construct(ClientInterface $client, ClientInterface $fileClient)` — JSON client + file client.
All methods `@throw GuzzleException`.

## Document methods

- `getKnowledgeBaseList(?int $page, int $limit=1)` → `GET v1/datasets`.
- `getDocuments($dataset_id, ?$keyword, ?$page, $limit=1)` → `GET …/{dataset}/documents`; returns
  `{data, has_more, total}` (validated/defaulted).
- `getAllDocuments($dataset_id, $max_pages=100)` — paginates `getDocuments` (limit 100) until
  `has_more` is false or the page cap.
- `getDocumentByKeyword($dataset_id, $keyword)` → first match or NULL.
- `createDocumentFromText($dataset_id, $doc_name, $data, array $chunking_options=[])` →
  `POST …/document/create-by-text`; throws `RuntimeException` on non-200.
- `updateDocumentFromText($dataset_id, $document_id, $doc_name, $data, $chunking_options=[])` →
  `POST …/documents/{id}/update-by-text` (drops `indexing_technique`).
- `createDocumentFromFile($dataset_id, $file_path)` / `updateDocumentFromFile(…, $document_id, …)`
  → multipart `POST …/document/create-by-file` / `…/update-by-file`; opens the file with a private
  `openFileOrThrow()` (`fopen(..., 'rb')`, throws `RuntimeException` if unreadable).
- `deleteDocument($dataset_id, $document_id)` → `DELETE …/documents/{id}`.
- `deleteAllDocuments($dataset_id)` — loops `getAllDocuments` + `deleteDocument`, returns the docs
  that failed to delete.

## Chunking options (`getTextIndexingOptions`, protected)

Builds the Dify `process_rule`. Keys (with defaults): `mode` (`parent_child`), `max_tokens`
(1000), `separator` (`\n`), `remove_extra_spaces` (TRUE), `remove_urls_emails` (FALSE),
`parent_mode` (`full-doc`; **`contextual_field` is a Drupal-side strategy that maps to Dify
`paragraph`**), `chunk_overlap` (50), `parent_separator` (`\n\n`), `parent_max_tokens` (1000).
`parent_child` → `doc_form=hierarchical_model`, `process_rule.mode=hierarchical`; otherwise
`process_rule.mode=automatic`. `indexing_technique` is always `high_quality`.
`getFileIndexingOptions()` uses `mode=custom` with a `;` separator.

## Segment methods

`getSegments`, `createSegments` (batch; each needs `content`, optional `answer`/`keywords`),
`updateSegment` (`content`/`answer`/`keywords`/`regenerate_child_chunks`/`enabled`),
`deleteSegment` → all under `…/documents/{id}/segments…`.

## Metadata methods

`createMetadataField($dataset_id, $name, $type='string')`, `getMetadataFields`,
`assignDocumentMetadata($dataset_id, $operation_data)` (bulk doc→field values),
`ensureMetadataField` (get-or-create; returns NULL on create failure).

## IdentityCardTrait

`src/IdentityCardTrait.php`, `buildIdentityCard(array $data, array $field_labels, array
$parent_fields)`: fields with priority **≥150** become a compact single pipe-separated line;
priority **100–149** each get their own `Label: value` line; the compact line comes first. Values
are collapsed to one line, empties skipped. Shared by the Search API backend and the knowledge
pipeline so text and contextual-field indexing produce the same document header.
