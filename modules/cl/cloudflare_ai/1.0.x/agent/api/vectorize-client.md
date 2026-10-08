<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vectorize data-plane client

`VectorizeClient` (service `Drupal\cloudflare_ai\VectorizeClient`, iface
`VectorizeClientInterface`) is the **vector data plane**: it moves vectors in and out of an
*existing* index over the Cloudflare **Vectorize v2 REST API**. Index lifecycle as a tracked
asset is `VectorizeProvider`'s job (see [primitives/provisioning.md](../primitives/provisioning.md));
this client is stateless — every call takes resolved credentials + the index name.

It owns its own transport (like the gateway client) because the `upsert` body is **NDJSON**, not
JSON. Constructor dep: `CloudflareHttpClientFactoryInterface` only. Base URI is the hardcoded
constant `API_BASE = 'https://api.cloudflare.com/client/v4/'` — not a request-supplied host.

## Auth & paths

`client(CloudflareCredentialsInterface)` creates an HTTP client bound to `API_BASE` with headers
`Authorization: Bearer {credentials->apiToken()}` and `Accept: application/json`. Paths:

- indexes collection: `accounts/{accountId}/vectorize/v2/indexes`
- single index: `…/indexes/{indexName}`

`accountId()` and `apiToken()` come from the resolved credentials object (settings.php/env via the
SDK). Every method decodes the Cloudflare envelope and returns its `result` array (or `[]`) via
`decodeResult()`.

## Methods (all take `CloudflareCredentialsInterface $credentials, string $indexName, …`)

| method | HTTP | body / notes |
|--------|------|--------------|
| `describeIndex` | GET `…/{index}` | index config + stats |
| `createIndex($name, int $dimensions, string $metric)` | POST `…/indexes` | `{name, config:{dimensions, metric}}` |
| `deleteIndex` | DELETE `…/{index}` | returns void |
| `upsert(array $vectors)` | POST `…/{index}/upsert` | **NDJSON**: each vector `json_encode`d one-per-line, `Content-Type: application/x-ndjson`; each vector a map of `id`/`values`/optional `metadata` |
| `query(array $vector, int $topK = 10, array $filter = [], bool $returnMetadata = TRUE)` | POST `…/{index}/query` | JSON `{vector, topK, returnMetadata: 'all'\|'none'}` + `filter` when non-empty; `vector`/ids are `array_values()`'d |
| `getByIds(array $ids)` | POST `…/{index}/get_by_ids` | `{ids}` |
| `deleteByIds(array $ids)` | POST `…/{index}/delete_by_ids` | `{ids}` |

`query` sends `returnMetadata` as the string `'all'` or `'none'` (Cloudflare's v2 contract), not a
boolean. There is no retry/rate-limit logic here — that is the SDK HTTP client factory's concern.
