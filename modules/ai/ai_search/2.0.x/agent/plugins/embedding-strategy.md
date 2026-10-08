# `EmbeddingStrategy` plugin type

The one plugin type this module **defines**. A strategy decides how a Search API item is broken into
**chunks** and how those chunks become the vector(s) stored in the VDB.

- Manager service: `ai_search.embedding_strategy` (`EmbeddingStrategyPluginManager`, extends
  `DefaultPluginManager`).
- Discovery dir: `Plugin/EmbeddingStrategy`. Interface: `EmbeddingStrategyInterface`. Bases:
  `Plugin\EmbeddingStrategy\EmbeddingBase` (concrete chunking logic) and
  `Base\EmbeddingStrategyPluginBase` (config subform).
- Attribute: `Drupal\ai_search\Attribute\EmbeddingStrategy(id, label, description, deriver?)`.
  **Id rule:** the id must equal the group or be prefixed with `<group>:` (a discovery quirk noted in
  the attribute docblock).
- Alter hook: **`hook_embedding_strategy_info(&$definitions)`**.

## Interface contract (`EmbeddingStrategyInterface`)

```php
public function getChunks(string $embedding_engine, array $configuration, array $fields,
  ItemInterface $search_api_item, IndexInterface $index): array;              // \Drupal\ai\Embedding[]
public function getEmbedding(array $chunks, array $fields,
  ItemInterface $search_api_item, IndexInterface $index): array;             // [{id, values, metadata}]
public function fits(AiVdbProviderInterface $vdb_provider): bool;
public function supports(\Drupal\ai\Enum\EmbeddingStrategyCapability $capability): bool;
public function getConfigurationSubform(array $configuration): array;
public function getDefaultConfigurationValues(): array;
```

`getChunks()` is also used by the tracker and the Fields "preview" checker to count chunks without
indexing. The `Embedding` value object (`\Drupal\ai\Embedding`) carries `id`, `values` (the vector),
and `metadata`.

## Bundled strategies

| id | Label | Behaviour |
|---|---|---|
| `contextual_chunks` | Enriched Embedding Strategy (recommended) | Splits Main Content into overlapping chunks, prepends Contextual Content (+ title) to **each** chunk → **multiple vectors** per item. Best recall. |
| `average_pool` | Enriched Composite Embedding | Embeds the chunks, then **average-pools** them into a **single** composite vector per item. Cheaper storage/fewer rows, some accuracy loss. |

Both extend `EmbeddingBase`; `AveragePoolEmbeddingStrategy` overrides `getEmbedding()` to average
(`averagePooling()`), the other keeps the base multi-vector output.

## Config surface (from `Base\EmbeddingStrategyPluginBase`)

The strategy subform (shown on the server backend form) exposes `chunk_size` (tokens; blank = model
max), `chunk_min_overlap`, `contextual_content_max_percentage`, and `skip_moderation`. Stored under
the server's `embedding_strategy_configuration` (see [../configure/backend.md](../configure/backend.md)).

## Add your own strategy

```php
namespace Drupal\my_module\Plugin\EmbeddingStrategy;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\ai_search\Attribute\EmbeddingStrategy;
use Drupal\ai_search\Plugin\EmbeddingStrategy\EmbeddingBase;

#[EmbeddingStrategy(
  id: 'chapter_split',
  label: new TranslatableMarkup('Split by chapter'),
  description: new TranslatableMarkup('One chunk per chapter heading.'),
)]
class ChapterSplit extends EmbeddingBase {
  // Override getChunks()/getEmbedding()/supports()/fits() as needed.
}
```

Clear caches; the new id appears in the server's **Embedding Strategy** select. Consider a custom
strategy when your content has natural boundaries (chapters, Q&A pairs) that generic token chunking
would split badly.
