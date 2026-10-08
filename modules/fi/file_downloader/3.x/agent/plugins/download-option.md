<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `DownloadOption` plugin type

A download option is an annotated plugin that decides *what file to serve* for a given source
`File` entity and *whether the current user may*.

- Manager service: `plugin.manager.download_option` (`DownloadOptionPluginManager`,
  `file_downloader.services.yml`), extends `default_plugin_manager`.
- Discovery dir: `src/Plugin/DownloadOption/`. Interface:
  `Drupal\file_downloader\DownloadOptionPluginInterface`. Base class:
  `Drupal\file_downloader\DownloadOptionPluginBase`. Annotation:
  `Drupal\file_downloader\Annotation\DownloadOption` (`id`, `label`, `description`).
- Alter hook: `hook_download_option_alter()` (alter info key `download_option`).
- `DownloadOptionPluginManager::getOptions()` returns `id => label` for the plugin select on the
  config-entity add form.
- Plugins are configurable and form-bearing: the base implements `ConfigurableInterface`,
  `PluginFormInterface`, `ContainerFactoryPluginInterface`, `ContextAwarePluginInterface`. Config is
  stored in the owning `download_option_config` entity's `settings` key, wrapped in a
  `DownloadOptionPluginCollection` (a `DefaultSingleLazyPluginCollection`).

## Bundled plugins

- **`original_file`** (`Plugin/DownloadOption/OriginalFile.php`) — empty subclass of the base; serves
  the stored file unchanged. `getFileUri()` = `$file->getFileUri()`.
- **`image_style`** (`Plugin/DownloadOption/ImageStyle.php`) — adds an **Image Style** select
  (`downloadOptionForm`, stored as `settings.image_style`). `getFileUri()` returns
  `$imageStyle->buildUri($file->getFileUri())`; `downloadFileExists()` builds the derivative on
  demand *when checked by the formatter* (`imageStyleFileExists` calls `createDerivative`), and
  overrides `getHeaders()` to set `Content-Length` from the derivative's `filesize()`. Injects
  `stream_wrapper_manager` + `entity_type.manager` (for `image_style` storage).

## Interface methods (`DownloadOptionPluginInterface`)

| Method | Purpose | Base behavior |
| --- | --- | --- |
| `deliver(FileInterface $file, DownloadOptionConfigInterface $config): BinaryFileResponse` | Stream the file. | Resolves URI, 404s if missing, returns `BinaryFileResponse` (private-aware). |
| `getFileUri(FileInterface $file): string` | The URI to serve. | `$file->getFileUri()`. |
| `downloadFileExists(FileInterface $file): bool` | Is the deliverable file present? | `file_exists($file->getFileUri())`. |
| `access(AccountInterface $account, FileInterface $file)` | Plugin-specific access. | Forbidden unless `$file->access('view', $account)`, else neutral. |
| `downloadOptionForm(array $form, FormStateInterface $form_state): array` | Extra config-form elements. | `[]`. |
| `downloadOptionValidate(...)` / `downloadOptionSubmit(...)` | Form validate/submit for those elements. | no-op / no-op. |

Base also provides `getHeaders()` (protected), `getConfiguration()` / `setConfiguration()` /
`getConfigurationValue($key)`, `defaultConfiguration()`, and `baseConfigurationDefaults()`
(seeds `id` + `extensions`).

## Writing a custom plugin

```php
namespace Drupal\my_module\Plugin\DownloadOption;

use Drupal\file_downloader\DownloadOptionPluginBase;

/**
 * @DownloadOption(
 *   id = "watermarked",
 *   label = @Translation("Watermarked"),
 *   description = @Translation("Serve a watermarked copy."),
 * )
 */
class Watermarked extends DownloadOptionPluginBase {

  // Override getFileUri() to point at the variant you generate.
  public function getFileUri(\Drupal\file\FileInterface $file): string {
    return '…'; // e.g. a derivative uri you build/verify.
  }

  // Optionally add settings:
  public function downloadOptionForm(array $form, \Drupal\Core\Form\FormStateInterface $fs): array {
    $form['opacity'] = ['#type' => 'number', '#title' => $this->t('Opacity')];
    return $form;
  }
  public function downloadOptionSubmit($form, \Drupal\Core\Form\FormStateInterface $fs) {
    $this->configuration['opacity'] = $fs->getValue('opacity');
  }
}
```

The plugin then appears in the **Plugin** select when creating a Download Option Config. If it needs
extra services, override `create()`/`__construct()` — note the base constructor already takes
`stream_wrapper_manager` as its 4th arg (see `ImageStyle` for the pattern of adding more). Keep
`access()` returning forbidden for files the user may not view (or defer to `parent::access()`), since
this is the last access gate before delivery.
