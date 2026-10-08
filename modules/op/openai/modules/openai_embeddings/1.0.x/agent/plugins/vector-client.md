# The `vector_client` plugin type

Abstracts the vector database so embeddings can be stored/queried in different backends.

## Manager & discovery
- Manager service `plugin.manager.vector_client` (`\Drupal\openai_embeddings\VectorClientPluginManager`).
- Discovers classes in `Plugin/openai_embeddings/vector_client/` of any module.
- Interface `\Drupal\openai_embeddings\VectorClientInterface`; base
  `\Drupal\openai_embeddings\VectorClientPluginBase`.
- Annotation `\Drupal\openai_embeddings\Annotation\VectorClient` (annotation-based, not
  attribute). Alter hook `vector_client_plugin_info`; cache key `vector_clients`.

## Shipped clients
| Plugin | Class | Backend |
|---|---|---|
| Milvus | `Plugin/openai_embeddings/vector_client/Milvus.php` | Milvus vector DB |
| Pinecone | `Plugin/openai_embeddings/vector_client/Pinecone.php` | Pinecone vector DB |

## Add a backend
```php
namespace Drupal\my_module\Plugin\openai_embeddings\vector_client;

use Drupal\openai_embeddings\VectorClientPluginBase;

/**
 * @VectorClient(
 *   id = "weaviate",
 *   label = @Translation("Weaviate"),
 * )
 */
class Weaviate extends VectorClientPluginBase {
  // Implement VectorClientInterface: connect, upsert vectors, query by similarity,
  // fetch stats, delete — matching how Milvus/Pinecone implement them.
}
```
Then select/configure it via the module's settings so indexing (`EmbeddingQueueWorker`) and the
test-search / stats / delete admin pages use your backend.

## Flow
1. Content text → stopwords stripped → `openai.api->embedding()` produces a vector.
2. The active `vector_client` upserts the vector (queued via `EmbeddingQueueWorker`).
3. Search (`openai_embeddings.search`) embeds the query and asks the client for nearest
   matches; `openai_embeddings.stats` reads backend stats; `delete_confirm` clears vectors.
