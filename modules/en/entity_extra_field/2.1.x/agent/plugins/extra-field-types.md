<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — the `ExtraFieldType` plugin type

## The plugin type

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.extra_field_type` (`ExtraFieldTypePluginManager`) |
| Discovery dir | `src/Plugin/ExtraFieldType/` |
| Annotation | `@ExtraFieldType(id, label)` (`src/Annotation/ExtraFieldType.php`) |
| Interface | `ExtraFieldTypePluginInterface` (extends `PluginFormInterface`, `ContainerFactoryPluginInterface`, `ConfigurableInterface`, `DependentPluginInterface`) |
| Base class | `ExtraFieldTypePluginBase` |
| Alter hook | `hook_extra_field_type_info_alter()` (alter id `extra_field_type_info`) |
| Cache | `extra_field_type` |

Interface methods beyond the config-form/configurable ones:
- `label(): string`
- `build(EntityInterface $entity, EntityDisplayInterface $display): array` — return the renderable content.
- `static isApplicable(ModuleHandlerInterface $module_handler): bool` — gate availability (base returns TRUE).

`ExtraFieldTypePluginBase` injects `token`, `module_handler`, `current_route_match`, `entity_type.manager`, `entity_field.manager`, and provides helpers: `processEntityToken()` (token replace with entity + referenced-entity data), `getEntityTokenData()` / `getEntityTokenTypes()` (build token data incl. entity_reference targets), `getPluginFormStateValue()`, `getTargetEntityTypeId()/Bundle()/Definition()` (read from route during config), and an AJAX helper pair (`extraFieldPluginAjax()` / `extraFieldPluginAjaxCallback()`) for dependent config forms. `submitConfigurationForm()` stores `$form_state->cleanValues()->getValues()` as the plugin config.

## Shipped plugins & their config (schema `entity_extra_field.plugin.<id>`)

| id | Class | Config keys | Renders |
|---|---|---|---|
| `block` | `ExtraFieldBlockPlugin` | `block_type`, `block_config` (`block.settings.<block_type>`) | any block plugin, with its config form + entity/context; logs + skips on block build errors |
| `views` | `ExtraFieldViewsPlugin` | `view_name`, `display`, `offset` (int), `arguments` (string, token-replaceable), `view_use_title` (bool) | an embedded view display; can override the field title with the view title |
| `token` | `ExtraFieldTokenPlugin` | `type` (`textfield` \| `text_format`), `token`, `unfiltered` (bool, textfield only) | token-replaced text; plain by default, raw HTML when `unfiltered`, or a formatted `text_format` value |
| `twig` | `ExtraFieldTwigPlugin` | `twig_template` (text) | an inline Twig template (`#type => inline_template`) with site + `entity` context |
| `entity_link` | `ExtraFieldEntityLinkPlugin` | `link_text`, `link_template`, `link_target` | an entity link (e.g. canonical/edit/delete link template) |
| `component` | `ExtraFieldComponentPlugin` | `component`, `settings.mapping.{slots,props}` | a Single Directory Component with mapped slots/props |

Conditions are stored separately on the config entity (`field_type_condition`, using core `condition.plugin.*`), not in the plugin config — see [../configure/extra-fields.md](../configure/extra-fields.md).

## Twig plugin context

`ExtraFieldTwigPlugin::getContext()` exposes: `theme`, `theme_directory`, `base_path`, `front_page`, `is_front`, `language`, `is_admin`, `logged_in`, and `entity` (the host content entity, e.g. `{{ entity.title.value }}`). The context is passed through `hook_entity_extra_field_twig_context_alter()` before `build()`. Templates are validated on save by rendering in isolation (`renderInIsolation`); a render error becomes a form error.

## Implementing a custom plugin

```php
namespace Drupal\my_module\Plugin\ExtraFieldType;

use Drupal\Core\Entity\Display\EntityDisplayInterface;
use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Extension\ModuleHandlerInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\entity_extra_field\ExtraFieldTypePluginBase;

/**
 * @ExtraFieldType(
 *   id = "my_extra_type",
 *   label = @Translation("My extra type")
 * )
 */
class MyExtraType extends ExtraFieldTypePluginBase {

  public function defaultConfiguration(): array {
    return ['greeting' => ''] + parent::defaultConfiguration();
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $form = parent::buildConfigurationForm($form, $form_state);
    $form['greeting'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Greeting'),
      '#default_value' => $this->getConfiguration()['greeting'],
    ];
    return $form;
  }

  public function build(EntityInterface $entity, EntityDisplayInterface $display): array {
    return ['#markup' => $this->getConfiguration()['greeting']];
  }

  public static function isApplicable(ModuleHandlerInterface $module_handler): bool {
    return TRUE; // e.g. return $module_handler->moduleExists('views');
  }
}
```

Add a `config/schema` entry `entity_extra_field.plugin.my_extra_type` mapping your keys. Return proper cache metadata / `#cache` in `build()` where relevant (the shipped block/views plugins do).

## Security / trust boundary (document, by design)

These are gated by `administer entity extra field` (a powerful admin permission), but note when granting it:
- **`twig`** renders an admin-supplied inline Twig template with full Twig capabilities — effectively arbitrary code for whoever can edit extra fields. Treat this permission as trusted-admin-only, like the core PHP/Twig-Tweak surface.
- **`token` + `unfiltered`** passes token output through as raw HTML (the form itself warns "this might be a security risk"). Leave it off unless the token source is trusted; otherwise output is plain-text escaped.
