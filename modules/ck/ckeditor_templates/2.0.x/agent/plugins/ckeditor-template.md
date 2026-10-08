<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `@CkeditorTemplate` plugin type

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.ckeditor_template` (`CkeditorTemplatePluginManager`) |
| Discovery dir | `src/Plugin/CkeditorTemplate/` |
| Annotation | `Drupal\ckeditor_templates\Annotation\CkeditorTemplate` (`@CkeditorTemplate`) |
| Interface | `Drupal\ckeditor_templates\CkeditorTemplateInterface` |
| Base class | `Drupal\ckeditor_templates\CkeditorTemplatePluginBase` |
| Alter hook | `hook_ckeditor_template_info_alter(&$definitions)` |
| Cache bin key | `ckeditor_template_plugins:<langcode>` (per current language) |

Annotation properties: `id`, `label`, `description`, `weight` (optional).

Interface methods:

```php
public function label(): string;          // human name shown in the dialog
public function getDescription(): string; // sub-line in the dialog
public function getThumb(): string;       // image URL/path
public function allowedFormats(): array;  // text format ids this template applies to
public function getHtml(): string;        // the HTML inserted into the editor
```

`CkeditorTemplatePluginBase` implements `label()`, `getDescription()` and a `getThumb()` that
falls back to the module's `js/ckeditor5_plugins/ckeditor_templates/theme/images/placeholder.svg`.
The manager adds `getTemplates()`, which sorts definitions with
`SortArray::sortByWeightElement()` and returns instantiated plugins.

## Writing one in code

```php
namespace Drupal\my_module\Plugin\CkeditorTemplate;

use Drupal\ckeditor_templates\CkeditorTemplatePluginBase;

/**
 * @CkeditorTemplate(
 *   id = "my_hero",
 *   label = @Translation("Hero banner"),
 *   description = @Translation("Full-width hero with a heading and CTA."),
 *   weight = -10
 * )
 */
class HeroTemplate extends CkeditorTemplatePluginBase {

  public function allowedFormats(): array {
    return ['full_html'];
  }

  public function getHtml(): string {
    return '<section class="hero"><h1>Heading</h1><a class="cta" href="#">Go</a></section>';
  }

}
```

The base class constructor takes `ModuleExtensionList` as its 4th argument; if you need extra
services, implement `ContainerFactoryPluginInterface` and pass them through (see
`ConfigTemplate`).

## The bundled `config_template` plugin + deriver

`Plugin/CkeditorTemplate/ConfigTemplate.php` is annotated
`@CkeditorTemplate(id = "config_template", deriver = ConfigTemplateDeriver::class)`.
`ConfigTemplateDeriver::getDerivativeDefinitions()` loads every `ckeditor_templates` config
entity with `status = 1`, sorted by `weight`, and emits one derivative per entity keyed by
the entity id — so plugin ids look like **`config_template:promo_banner`**. Each derivative
carries `ckeditor_template_id`, `label`, `description` and `weight`.

`ConfigTemplate` then reads the entity: `getHtml()` returns `code.value`,
`allowedFormats()` returns the `formats` array, and `getThumb()` resolves the uploaded
`thumb` file id through the `thumbnail` image style, falling back to `thumb_alternative` and
then to the base class placeholder.

## Inspecting what exists

```bash
drush php:eval 'print implode("\n", array_keys(\Drupal::service("plugin.manager.ckeditor_template")->getDefinitions()));'
# e.g. config_template:promo_banner
```

## How the dialog consumes them

`CKEditorTemplatesDialogForm` (route `ckeditor_templates.selector`) calls
`getTemplates()`, keeps only those whose `allowedFormats()` contains the current editor id,
renders them as a radios list of thumbnail + label + description, and on submit sends the
selected plugin's `getHtml()` back through an `EditorDialogSave` AJAX command together with
the `replace` flag.
