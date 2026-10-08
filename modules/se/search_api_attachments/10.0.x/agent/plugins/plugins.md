# Plugin type: TextExtractor

Search API Attachments defines one plugin type — a **text extractor** — so extraction backends
are pluggable.

| Aspect | Value |
|---|---|
| Manager service | `plugin.manager.search_api_attachments.text_extractor` (`TextExtractorPluginManager`) |
| Discovery namespace | `Plugin/search_api_attachments` (of any module) |
| Interface | `Drupal\search_api_attachments\TextExtractorPluginInterface` |
| Base class | `Drupal\search_api_attachments\TextExtractorPluginBase` |
| Annotation | `@SearchApiAttachmentsTextExtractor` (id, label, description) |
| Alter hook | `hook_text_extractor_info_alter()` |

The interface extends `ConfigurableInterface` + `PluginFormInterface`, so each extractor
carries its own configuration and settings subform. The one required method is:

```php
public function extract(\Drupal\file\Entity\File $file): string;
```

It receives a file entity and returns the extracted text (throw an `\Exception` to signal
failure — the processor logs it and queues the file for retry).

Bundled extractors (all in `src/Plugin/search_api_attachments/`): `tika_extractor`,
`tika_server_extractor`, `solr_extractor`, `pdftotext_extractor`, `python_pdf2txt_extractor`,
`docconv_extractor`.

## Add your own extractor

```php
namespace Drupal\mymodule\Plugin\search_api_attachments;

use Drupal\file\Entity\File;
use Drupal\Core\Form\FormStateInterface;
use Drupal\search_api_attachments\TextExtractorPluginBase;

/**
 * @SearchApiAttachmentsTextExtractor(
 *   id = "my_extractor",
 *   label = @Translation("My Extractor"),
 *   description = @Translation("Extracts text my way."),
 * )
 */
class MyExtractor extends TextExtractorPluginBase {

  public function extract(File $file) {
    $path = $this->getRealpath($file->getFileUri());
    // ... run your engine, return the text ...
    return $text;
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    // Optional: expose settings, stored under my_extractor_configuration.
    return $form;
  }

}
```

`drush cr`, then select **My Extractor** at
`/admin/config/search/search_api_attachments`. Its config is saved on
`search_api_attachments.admin_config` under `<id>_configuration`. See
[../configure/configure.md](../configure/configure.md) for enabling the processor and indexing
the field.
