<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config-set generation event subscriber

`src/EventSubscriber/SearchApiSolrSubscriber.php` is the module's only PHP class. It hooks into
`search_api_solr`'s config-set generation so the trained OpenNLP model files (`*.bin`) that the NLP
field types reference are bundled into the Solr config-set download an admin uploads to Solr. Trained
models are large binaries that cannot live in Drupal config, so they are injected at generation time
from the `mkalkbrenner/solarium-nlp` composer library instead.

## Service

- Id: `search_api_solr_nlp.search_api_solr_subscriber` (`search_api_solr_nlp.services.yml`).
- Class: `Drupal\search_api_solr_nlp\EventSubscriber\SearchApiSolrSubscriber`, `arguments: []`,
  tag `event_subscriber`.

## Subscribed events

`getSubscribedEvents()` (guarded — returns `[]` if `\Drupal\search_api_solr\Event\SearchApiSolrEvents`
does not exist, a workaround to avoid a fatal during site install; see drupal.org facets issue
`3199156`):

| Event constant | Handler |
|---|---|
| `SearchApiSolrEvents::POST_CONFIG_FILES_GENERATION` | `onPostConfigFilesGeneration` |
| `SearchApiSolrEvents::POST_CONFIG_SET_GENERATION` | `onPostConfigSetGeneration` |

## Flow

1. **`onPostConfigFilesGeneration(PostConfigFilesGenerationEvent $event)`** — reads
   `$event->getConfigFiles()`. If `schema_extra_types.xml` is present, it runs
   `preg_match_all('@Model="([^"]+\.bin)"@', …)` to collect every `*.bin` model name referenced by the
   generated field types (e.g. `en-sent.bin`, `en-token.bin`, `en-pos-maxent.bin`). The unique set is
   stored in the static `self::$models`.
2. **`onPostConfigSetGeneration(PostConfigSetGenerationEvent $event)`** — gets the `ZipStream` via
   `$event->getZipStream()`, constructs `new SolariumNlp\Nlp()`, and for each collected model calls
   `$zip->addFileFromPath($model, $nlp->getOpenNlpDemoModelPath($model))`. `getOpenNlpDemoModelPath()`
   resolves the file from the library's `opennlp/models-combined/<name>` directory (throwing
   `InvalidArgumentException` if it is missing/unreadable). The model files are thereby added to the
   config-set zip alongside the field-type schema.

The two handlers cooperate through the static `$models` property: the first records which models the
generated schema needs, the second packages those exact files. This runs only when an administrator
triggers a Search API Solr config-set (re)generation/download; it does not run on normal requests.
