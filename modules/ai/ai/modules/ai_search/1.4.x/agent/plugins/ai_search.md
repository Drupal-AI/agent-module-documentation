# plugins — the EmbeddingStrategy plugin type

AI Search defines **one** plugin type: `EmbeddingStrategy`. A strategy decides how a Search
API item's fields are grouped and chunked before each chunk is embedded into a vector. It is
the one extension point for changing chunking/vectorization behavior.

| | |
|---|---|
| Attribute | `#[EmbeddingStrategy]` — `Drupal\ai_search\Attribute\EmbeddingStrategy` |
| Interface | `Drupal\ai_search\EmbeddingStrategyInterface` |
| Base class | `Drupal\ai_search\Plugin\EmbeddingStrategy\EmbeddingBase` (extends `Base\EmbeddingStrategyPluginBase`) |
| Namespace | `Drupal\<module>\Plugin\EmbeddingStrategy` |
| Manager service | `ai_search.embedding_strategy` (`EmbeddingStrategyPluginManager`) |
| Alter hook | `hook_embedding_strategy_info_alter()` |

**Attribute id caveat (from source):** the plugin id must equal the group or be prefixed
with `group:` — e.g. `foo` or `foo:bar` — or discovery misses it.

## Built-in strategies

| id | Label | Behavior |
|---|---|---|
| `contextual_chunks` | Enriched Embedding Strategy | Default. One vector per chunk, each enriched with repeated title/contextual content. Highest accuracy. |
| `average_pool` | Enriched Composite Embedding | Embeds all chunks then average-pools them into a single vector per item. Fewer vectors, faster/cheaper, lower accuracy. |

## Interface contract

```php
namespace Drupal\my_module\Plugin\EmbeddingStrategy;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\ai_search\Attribute\EmbeddingStrategy;
use Drupal\ai_search\Plugin\EmbeddingStrategy\EmbeddingBase;

#[EmbeddingStrategy(
  id: 'my_strategy',
  label: new TranslatableMarkup('My strategy'),
  description: new TranslatableMarkup('How it chunks and vectorizes content.'),
)]
class MyStrategy extends EmbeddingBase {
  // Override getEmbedding() to change chunking/vectorization.
}
```

Methods you implement/override (see `EmbeddingStrategyInterface`):

- `getEmbedding(string $embedding_engine, string $chat_model, array $configuration, array $fields, ItemInterface $search_api_item, IndexInterface $index): array` — returns `[['id' => ..., 'values' => <vector>, 'metadata' => [...]], ...]`. This is the core method; `EmbeddingBase` provides helpers `groupFieldData()`, `getChunks()`, `getRawEmbeddings()`, `buildBaseMetadata()`, `addContentToMetadata()`.
- `fits(AiVdbProviderInterface $vdb_provider): bool` — whether the strategy works with a given vector DB (e.g. single-vector strategies for VDBs that only store one vector per row).
- `supports(EmbeddingStrategyCapability $capability): bool` — capability check (enum `Drupal\ai\Enum\EmbeddingStrategyCapability`).
- `getConfigurationSubform(array $configuration): array` — Form API elements shown in the backend's "Advanced Embeddings Strategy Configuration" fieldset.
- `getDefaultConfigurationValues(): array` — defaults for that subform.

Extending `EmbeddingBase` and overriding only `getEmbedding()` (as `average_pool` does) is the
common path; extending it with no overrides (as `contextual_chunks` does) gives the default
enriched-chunk behavior.

## Discover strategies programmatically

```php
$manager = \Drupal::service('ai_search.embedding_strategy');
$options = $manager->getStrategies();        // [id => label]
$details = $manager->getStrategyDetails();    // [id => full definition]
$strategy = $manager->createInstance('contextual_chunks');
```
