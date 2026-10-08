<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Augmentor Processors (augmentor_search_api_processors) — agent index

Submodule of **augmentor**. Adds **two Search API processors** that run a configured Augmentor over
text in the Search API pipeline: one at **index** time (rewrites indexed field values), one at
**query** time (rewrites search keywords). Package `Augmentor`. Depends on **`augmentor`** and
**`search_api`**. Core `^10.3 || ^11 || ^12`. No routes/permissions/config schema of its own
(config lives in the Search API index).

- **The processors — stages, config, `process()` behaviour** →
  [plugins/processors.md](plugins/processors.md)

## What it provides (from source)

- **`augmentor_preprocess_index`** — *"Augmentor Preprocess Index"* — class
  `src/Plugin/search_api/processor/AugmentorPreprocessIndex.php`, extends Search API's
  `FieldsProcessorPluginBase`. Stages: `pre_index_save = 0`, `preprocess_index = -10`.
- **`augmentor_preprocess_query`** — *"Augmentor Preprocess Query"* — class
  `AugmentorPreprocessQuery` (`extends AugmentorPreprocessIndex` — one-line subclass). Stages:
  `pre_index_save = 0`, `preprocess_query = -10`.
- Both inject `plugin.manager.augmentor.augmentors`. Config keys: `augmentor` (uuid, required),
  `response_key` (string, default shown as `default`). `getAugmentorOptions()` builds the select from
  `getAugmentors()`.
- `process(&$value)`: `getAugmentor(config['augmentor'])`; if missing → return; `execute($value)`;
  if `$result[response_key]` is set, `$value = $result[response_key]` (else leave `$value`
  unchanged). Because it extends `FieldsProcessorPluginBase`, `process()` is applied per configured
  field value on index and per keyword on query.
