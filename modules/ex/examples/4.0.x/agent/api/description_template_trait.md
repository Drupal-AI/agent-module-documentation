# DescriptionTemplateTrait — reusable intro-page renderer

`Drupal\examples\Utility\DescriptionTemplateTrait` (`src/Utility/DescriptionTemplateTrait.php`) is
the one reusable API the parent module exports. Almost every example submodule uses it so its
"description" page (the tray target) is a translatable Twig template instead of hand-built markup.

## What it provides

| Member | Purpose |
| --- | --- |
| `description()` | Returns a render array: an `#type => 'inline_template'` element whose `#template` is the file contents of the module's `templates/description.html.twig`, with `#context` from `getDescriptionVariables()`. |
| `getModuleName()` | **abstract** — the consumer must return its module machine name. |
| `getDescriptionVariables()` | Context passed to the template; default returns `['module' => $this->getModuleName()]`. Override to add variables. |
| `getDescriptionTemplatePath()` | Resolves `<module path>/templates/description.html.twig` via `extension.list.module`. |

Because the template is loaded with `file_get_contents()` and rendered as an inline template, the
`{% trans %}` / `{% endtrans %}` tags inside it are picked up by Drupal's localization the same as a
normal theme template.

## Using it in your own controller

```php
namespace Drupal\my_module\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\examples\Utility\DescriptionTemplateTrait;

class MyDescriptionController extends ControllerBase {

  use DescriptionTemplateTrait;

  protected function getModuleName() {
    return 'my_module';
  }

  // Optional: add template variables.
  protected function getDescriptionVariables() {
    return ['module' => $this->getModuleName(), 'foo' => 'bar'];
  }

}
```

Route the controller's `description` method and add `my_module/templates/description.html.twig`:

```yaml
my_module.description:
  path: '/examples/my-module'
  defaults:
    _controller: '\Drupal\my_module\Controller\MyDescriptionController::description'
    _title: 'My module'
  requirements:
    _permission: 'access content'
```

The trait itself has no service dependency beyond the `extension.list.module` service it calls
statically to locate the template; using it only requires the `examples` module to be installed.
