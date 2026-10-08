<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing an Embedded Content plugin

The `embedded_content` plugin type is what actually renders an embedded component. The module ships
**no concrete plugins** — you add them in a module. (The `embedded_content_test` module's `Shape` and
`NoConfig` plugins are working references.)

## Anatomy

- **Location:** `src/Plugin/EmbeddedContent/<Name>.php` in any module.
- **Annotation:** `@EmbeddedContent(id = "…", label = @Translation("…"))` (optionally `description`).
- **Base class:** extend `Drupal\embedded_content\EmbeddedContentPluginBase` and implement
  `Drupal\embedded_content\EmbeddedContentInterface`.
- **Manager / discovery:** `plugin.manager.embedded_content` (namespace `Plugin/EmbeddedContent`,
  alter hook `embedded_content_info`).

## Methods

| Method | Required | Purpose |
|---|---|---|
| `build(): array` | ✓ | Return the render array shown in content and CKEditor preview. |
| `isInline(): bool` | ✓ (abstract) | TRUE → inline (`<embedded-content-inline>`); FALSE → block (`<embedded-content>`). |
| `defaultConfiguration(): array` | optional | Default settings (base returns `[]`). |
| `buildConfigurationForm($form, $form_state)` | optional | The per-instance config form shown in the insert dialog (base returns `[]`). |
| `validateConfigurationForm(&$form, $form_state)` | optional | Validate dialog input. |
| `massageFormValues(&$values, $form, $form_state)` | optional | Transform submitted values before they are stored in the tag's `data-plugin-config`. |
| `getAttachments(): array` | optional | `#attached`-style libraries to add when rendered (base returns `[]`). |
| `submitConfigurationForm(&$form, $form_state)` | — | Present but **never called** by the module. |

Configuration is stored/merged via `ConfigurableInterface`; `setConfiguration()` deep-merges over
`defaultConfiguration()`. Read instance settings from `$this->configuration`.

## Minimal example

```php
namespace Drupal\my_module\Plugin\EmbeddedContent;

use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Render\Markup;
use Drupal\embedded_content\EmbeddedContentPluginBase;
use Drupal\embedded_content\EmbeddedContentInterface;

/**
 * @EmbeddedContent(
 *   id = "callout",
 *   label = @Translation("Callout box"),
 * )
 */
final class Callout extends EmbeddedContentPluginBase implements EmbeddedContentInterface {

  public function defaultConfiguration(): array {
    return ['text' => ''];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['text'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Text'),
      '#default_value' => $this->configuration['text'],
    ];
    return $form;
  }

  public function build(): array {
    return ['#type' => 'html_tag', '#tag' => 'div', '#attributes' => ['class' => ['callout']],
            '#value' => Markup::create($this->configuration['text'])];
  }

  public function isInline(): bool {
    return FALSE;
  }
}
```

Need a service? Implement `ContainerFactoryPluginInterface` and add a `create()` (see the test
`NoConfig` plugin, which injects `state`).

## Making it insertable

Defining the plugin is not enough — an editor inserts it through a **button** and the **filter**. The
button's `conditions` decide which plugins it offers (empty = all). See
[../configure/buttons.md](../configure/buttons.md) and [../api/filter.md](../api/filter.md).
