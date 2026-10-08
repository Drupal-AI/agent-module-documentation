<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client factory, request proxies & value objects

Reusable pieces the destination plugin builds on. All live in `src/`, namespace
`Drupal\data_pipelines_opensearch`.

## `ClientFactory` (service `data_pipelines_opensearch.client_factory`)

`src/ClientFactory.php`, implements `ClientFactoryInterface`. Constructor arg: the module's
`LoggerChannelInterface`. One method:

```
public function create(string $url, string $username, string $password): ?\OpenSearch\Client
```

Memoizes a single client in `$this->client`. On first call it builds:

```
(new OpenSearch\GuzzleClientFactory())->create([
  'base_uri' => $url,
  'auth' => [$username, $password],
]);
```

so authentication is HTTP basic auth over the underlying Guzzle client. Any exception is caught
and logged via the channel (`error()`) and the method returns `null` — callers treat null as
"unavailable" and return FALSE/0. The factory does **not** override transport TLS options; it uses
the OpenSearch/Guzzle client defaults.

## Value objects

- **`Index`** (`src/Index.php`) — `new Index(string $id, array $settings = [])`. Getters/setters
  for `id` and `settings`. `settings` is the index-creation body (mappings/settings).
- **`Document`** (`src/Document.php`) — `new Document(string $id, Index $index, array $data,
  ?int $delta = null)`. `getData()` returns `$data + ['@delta' => $delta]` — the delta is always
  merged into the stored body. Getters/setters for id, index, data; `getDelta()`.

## Request proxies (extend abstract `Request`, constructed with a `\OpenSearch\Client`)

`src/Request.php` just stores the client. Concrete proxies:

- **`IndexRequest`** (`IndexRequestInterface`):
  - `create(Index)` → `client->indices()->create(['index'=>id, 'body'=>settings])`
  - `delete(Index)` → `client->indices()->delete(['index'=>id])`
  - `exists(Index)` → `client->indices()->exists(['index'=>id])` (bool)
- **`DocumentsRequest`** (`DocumentsRequestInterface`):
  - `create(Index, Document[])` → builds a `_bulk` body of `index` actions (`_index`, `_id`) each
    followed by `document->getData()`, then `client->bulk($params)`.
  - `delete(Index, Document[])` → `_bulk` body of `delete` actions, then `client->bulk()`.
  - `last(Index)` → `client->search()` with `size:1, sort:{'@delta':{order:desc}}`; wraps the top
    hit into a `Document` (`_id`, index, `_source`, `_source['@delta']`) or returns null.
- **`DocumentRequest`** (`DocumentRequestInterface`):
  - `create(Document)` → `client->index(['index'=>…, 'id'=>…, 'body'=>document->getData()])`
    (single-document index; not used by the destination plugin's chunk path, which uses bulk).

## Reuse from custom code

Get the service, create a client, wrap it:

```
$client = \Drupal::service('data_pipelines_opensearch.client_factory')
  ->create($url, $user, $pass);
$req = new \Drupal\data_pipelines_opensearch\IndexRequest($client);
$req->exists(new \Drupal\data_pipelines_opensearch\Index('my_index'));
```

(Prefer constructor injection over `\Drupal::service()` in real services.)
