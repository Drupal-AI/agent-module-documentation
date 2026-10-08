<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — extractor backends

## Plugin type
- Attribute: `Drupal\file_extractor\Attribute\FileExtractorExtractor`
  (`id`, `label`, `description`, `moduleDependencies[]`, `packageDependencies[]`).
- Interface: `ExtractorPluginInterface` (`extract(FileInterface $file): string`, extends
  `ConfigurableInterface`). Base class: `ExtractorPluginBase`.
- Discovery dir: `Plugin/file_extractor/Extractor`. Manager:
  `plugin.manager.file_extractor.extractor`, cache key `file_extractor_extractor_plugins`, alter hook
  `file_extractor_extractor_info`.
- `alterDefinitions()` drops any plugin whose `moduleDependencies` (module not enabled) or
  `packageDependencies` (Composer package not installed via `InstalledVersions`) are unmet — so a plugin
  only appears when its backend is available. CLI extractors declare `packageDependencies: ['symfony/process']`.

## Built-in extractors and their config keys
Config lives under `file_extractor.settings:extraction_method_settings`, schema
`file_extractor.plugin.extractor.<id>`.

| id | Backend | Config keys | Notes |
|---|---|---|---|
| `pdftotext_extractor` | `pdftotext` binary | `pdftotext_path` (default `pdftotext`) | PDF only (MIME-guarded). Runs `pdftotext <file> -` → stdout. |
| `docconv_extractor` | docconv `docd` | `docconv_path` (default `/usr/bin/docd`) | Runs `docd -input <file>`. |
| `python_pdf2txt_extractor` | Python pdfminer | `python_path` (default `python`), `python_pdf2txt_script` (default `/usr/bin/pdf2txt.py`) | PDF only. Runs `<python> <script> -C -t text <file>`. |
| `tika_extractor` | Apache Tika JAR (CLI) | `java_path` (default `java`), `tika_path`, `tika_config_path` (optional) | Runs `java -Djava.awt.headless=true [-Dfile.encoding=UTF8 -cp <jar>] -jar <jar> [--config=…] -t <file>`. |
| `tika_server_extractor` | Tika JAX-RS server | `scheme` (http/https), `host` (default localhost), `port` (default 9998), `timeout` (default 5) | HTTP `PUT <scheme>://<host>:<port>/tika` with the file body, `Accept: text/plain`. No `symfony/process`. |
| `search_api_solr_extractor` | Search API Solr | `solr_server` (server id) | `moduleDependencies: ['search_api_solr']`. Calls `SolrBackend::extractContentFromFile()` and parses the `<body>` out of the XML. |

## How CLI extractors run (security-relevant)
- All CLI extractors use `new Symfony\Component\Process\Process([...array args...])` — **array form, no
  shell string / no `fromShellCommandline`** — so the file path and binary path are passed as separate
  argv elements and are not subject to shell interpretation (a maliciously named uploaded file cannot
  inject a command).
- Binary/interpreter paths come only from `extraction_method_settings`, editable only via the settings
  form gated by `file_extractor_administer_settings` (`restrict access: true`, trusted admin).
- The file argument is the real path from the file's stream wrapper (`getRealpath()`; local wrappers →
  real path, otherwise the external URL).
- `ExtractorPluginBase` helpers: `checkBinaryAndFile()` (existence checks), `isBinaryName()`,
  `getUtf8Locale()` (sets `LANG` env), `getPdfMimeTypes()`.

## Writing a custom extractor
```php
namespace Drupal\my_module\Plugin\file_extractor\Extractor;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\file\FileInterface;
use Drupal\file_extractor\Attribute\FileExtractorExtractor;
use Drupal\file_extractor\Extractor\ExtractorPluginBase;

#[FileExtractorExtractor(
  id: 'my_extractor',
  label: new TranslatableMarkup('My Extractor'),
  description: new TranslatableMarkup('…'),
  // moduleDependencies: ['some_module'],
  // packageDependencies: ['vendor/pkg'],
)]
class MyExtractor extends ExtractorPluginBase {
  public function extract(FileInterface $file): string {
    $uri = $file->getFileUri();
    // … return extracted text, or '' on failure/unsupported mime.
    return '';
  }
}
```
Implement `Drupal\Core\Plugin\PluginFormInterface` too if the plugin needs a config subform
(`buildConfigurationForm` / `validateConfigurationForm` / `submitConfigurationForm`), and add a schema
`file_extractor.plugin.extractor.my_extractor`. The manager's `createInstance()` calls
`setConfiguration()` for you.
