<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Augmentor Search API processors

## Install & enable

```bash
drush en augmentor_search_api_processors -y   # requires augmentor + search_api
```

Create augmentor instances first at `/admin/config/augmentors`. Then, on a Search API index at
`/admin/config/search/search-api/index/<index>/processors`, enable **Augmentor Preprocess Index**
and/or **Augmentor Preprocess Query** and configure each.

## The two processors

Both live in `src/Plugin/search_api/processor/` and extend Search API's
`FieldsProcessorPluginBase` (so they inherit its per-field selection and the `process(&$value)`
transform contract).

| Plugin id | Class | `stages` (weight) | Runs on |
|---|---|---|---|
| `augmentor_preprocess_index` | `AugmentorPreprocessIndex` | `pre_index_save=0`, `preprocess_index=-10` | each selected field value during indexing |
| `augmentor_preprocess_query` | `AugmentorPreprocessQuery` (subclass) | `pre_index_save=0`, `preprocess_query=-10` | the search keywords during query |

`AugmentorPreprocessQuery` is literally `class AugmentorPreprocessQuery extends AugmentorPreprocessIndex {}`
— identical config and `process()`, only the stage differs.

## Dependency injection

`create()` builds the plugin with `plugin.manager.augmentor.augmentors`, stored on
`$this->augmentorManager`.

## Configuration (`buildConfigurationForm` + `defaultConfiguration`)

On top of `FieldsProcessorPluginBase`'s own field-selection form:

| Key | Element | Default | Meaning |
|---|---|---|---|
| `augmentor` | select (required) | `[]` (form shows `''`) | Augmentor UUID to run; options from `getAugmentorOptions()` → `getAugmentors()`. |
| `response_key` | textfield (required) | `''` (form default `default`) | Key to read out of the augmentor's result array. |

Config is persisted inside the **Search API index** entity (this submodule ships no config schema of
its own).

## Transform (`process(&$value)`)

```php
$augmentor = $this->augmentorManager->getAugmentor($this->configuration['augmentor']);
if (!$augmentor) { return; }                                   // unknown augmentor → leave value
$result = $augmentor->execute($value);
if (!isset($result[$this->configuration['response_key']])) { return; }  // missing key → leave value
$value = $result[$this->configuration['response_key']];        // replace with augmented value
```

So each field value (index) or keyword (query) is sent to the augmentor and, when the response
contains the configured key, **replaced** by that response. A missing augmentor or missing response
key leaves the original value untouched.

## Operating notes

- `FieldsProcessorPluginBase` calls `process()` once **per value** — a real provider augmentor means
  **one external API call per indexed field value**. On a full reindex this can be a large volume of
  metered calls; size/queue accordingly and prefer cheap/deterministic augmentors for large indexes.
- This path calls the augmentor plugin's `execute()` directly; it does **not** fire the parent's
  `pre_execute`/`post_execute` HTTP hooks (those are only on the field-widget execute controller).
- Credentials, TLS, and any outbound-call behaviour are the provider augmentor's concern (this
  submodule only orchestrates); the base framework stores keys via the Key module.
