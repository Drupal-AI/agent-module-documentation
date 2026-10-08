<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Kraken.io processor (configure)

Kraken has **no module settings page**. All configuration is a processor you attach to an
`imageapi_optimize` **pipeline**; the settings live inside that pipeline's config entity
(`imageapi_optimize.pipeline.<id>`), not in a standalone config object.

## Add it in the UI

1. Create or edit a pipeline at `/admin/config/media/imageapi-optimize-pipelines`
   (add: `/admin/config/media/imageapi-optimize-pipelines/add`).
2. In **Select new processor** choose **Kraken.io** and add it.
3. Fill the processor form (fields below), save.
4. Point an image style — or the sitewide default — at the pipeline under
   `/admin/config/media/image-styles`. Derivatives generated from then on run through Kraken.

## Processor config keys

Schema `imageapi_optimize.processor.kraken`; form built in `KrakenProcessor::buildConfigurationForm()`.

| Key | Type | Form element | Default | Meaning |
|---|---|---|---|---|
| `api_key` | string | textfield (required) | `NULL` | Kraken.io account API key. |
| `api_secret` | string | textfield (required) | `NULL` | Kraken.io account API secret. |
| `lossy` | boolean | checkbox | `TRUE` | Use lossy compression (smaller files) vs lossless. |
| `webp` | boolean | checkbox | `FALSE` | Convert the derivative to WebP (`convert.format=webp`). |
| `logging` | boolean | checkbox | `FALSE` | Log every optimize *success* to the `imageapi_optimize` channel (watchdog). Off by default; errors are always logged. |

`getSummary()` renders a one-line status on the pipeline listing (compression mode, WebP on/off,
logging on/off, or "Could not locate Kraken PHP library" when `\Kraken` is missing).

## Set it from code

The processor config is nested in the pipeline entity. Example adding a Kraken processor to a
pipeline programmatically:

```php
$pipeline = \Drupal::entityTypeManager()
  ->getStorage('imageapi_optimize_pipeline')
  ->load('my_pipeline');
$pipeline->addProcessor([
  'id' => 'kraken',
  'data' => [
    'api_key' => getenv('KRAKEN_API_KEY'),
    'api_secret' => getenv('KRAKEN_API_SECRET'),
    'lossy' => TRUE,
    'webp' => FALSE,
    'logging' => FALSE,
  ],
]);
$pipeline->save();
```

## Status report

Once at least one pipeline has a Kraken processor with credentials, the **Reports → Status report**
page shows a "Kraken.io Account" line per distinct account (grouped by `getApiKeyHash()`): plan name,
total plan size, and remaining quota — WARNING under 5% remaining, ERROR if the account is
unreachable. See [../api/kraken-client.md](../api/kraken-client.md).
