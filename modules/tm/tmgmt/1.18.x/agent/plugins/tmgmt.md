# Plugin types — Translator (provider) & Source

TMGMT defines two plugin types via `default_plugin_manager` subclasses. Both support the modern
PHP **Attribute** and legacy **Annotation** discovery styles.

| Plugin type | Manager service | Namespace | Attribute / Annotation | Interface | Base class |
|---|---|---|---|---|---|
| Translator (provider) | `plugin.manager.tmgmt.translator` (`TranslatorManager`) | `Plugin/tmgmt/Translator` | `Drupal\tmgmt\Attribute\TranslatorPlugin` / `Annotation\TranslatorPlugin` | `TranslatorPluginInterface` | `TranslatorPluginBase` |
| Source | `plugin.manager.tmgmt.source` (`SourceManager`) | `Plugin/tmgmt/Source` | `Drupal\tmgmt\Attribute\SourcePlugin` / `Annotation\SourcePlugin` | `SourcePluginInterface` | `SourcePluginBase` |

Alter hooks: `hook_tmgmt_translator_plugin_info_alter()` (alter id `tmgmt_translator_info`) and
`hook_tmgmt_source_plugin_info_alter()` (`tmgmt_source_plugin_info`).

## Add a translation provider (Translator plugin)

Create `src/Plugin/tmgmt/Translator/MyTranslator.php`:

```php
namespace Drupal\my_module\Plugin\tmgmt\Translator;

use Drupal\tmgmt\Attribute\TranslatorPlugin;
use Drupal\tmgmt\TranslatorPluginBase;
use Drupal\tmgmt\JobInterface;
use Drupal\tmgmt\Translator\AvailableResult;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[TranslatorPlugin(
  id: 'my_translator',
  label: new TranslatableMarkup('My Translator'),
  description: new TranslatableMarkup('Translates via My API.'),
  ui: 'Drupal\\my_module\\MyTranslatorUi',   // extends TranslatorPluginUiBase
  default_settings: ['api_key' => ''],
  map_remote_languages: TRUE,
)]
class MyTranslator extends TranslatorPluginBase {
  public function checkAvailable(TranslatorInterface $translator): AvailableResult { /* ... */ }
  public function requestTranslation(JobInterface $job) {
    $data = \Drupal::service('tmgmt.data')->filterTranslatable($job->getData());
    // ...call your API, then add translations back and save:
    $job->submitted();               // move to ACTIVE
    // $job->addTranslatedData($translated);
  }
}
```

Attribute params: `id`, `label`, `description`, `default_settings`, `ui`, `logo`, `files`
(supports file round-trip), `map_remote_languages`. The `ui` class (a
`TranslatorPluginUiBase` subclass) renders the provider's settings + checkout form. The
provider becomes selectable once a `tmgmt_translator` config entity references its `id`.

## Add a translation source (Source plugin)

Create `src/Plugin/tmgmt/Source/MySource.php`:

```php
#[SourcePlugin(
  id: 'my_source',
  label: new TranslatableMarkup('My Source'),
  description: new TranslatableMarkup('Exposes X for translation.'),
  ui: 'Drupal\\my_module\\MySourceUi',      // extends SourcePluginUiBase
)]
class MySource extends SourcePluginBase {
  public function getData(JobItemInterface $job_item) { /* return nested translatable data */ }
  public function saveTranslation(JobItemInterface $job_item, $target_langcode) { /* write back */ }
  public function getLabel(JobItemInterface $job_item) { /* ... */ }
}
```

`getData()` returns nested arrays of data items (`['#text' => ..., '#translate' => TRUE]`);
`Drupal\tmgmt\Data` (`tmgmt.data`) flattens/unflattens them. `saveTranslation()` writes the
accepted translation back to the underlying object. See the shipped plugins:
`content` (tmgmt_content), `config` (tmgmt_config), `locale` (tmgmt_locale) for sources;
`file` (tmgmt_file), `local` (tmgmt_local) for translators.

## tmgmt_file's own sub-plugin type: Format

tmgmt_file adds `plugin.manager.tmgmt_file.format` (`FormatManager`, namespace
`Plugin/tmgmt_file/Format`, `FormatPlugin` attribute) with `xlf` (Xliff) and `html` (Html)
plugins — implement `FormatInterface` to add an export/import file format.
