<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TwigExtensionBase — the shared base service

The parent module's whole job is one service:

```yaml
# bamboo_twig.services.yml
services:
  bamboo_twig.twig.base:
    private: true
    class: Drupal\bamboo_twig\TwigExtension\TwigExtensionBase
    arguments: ['@service_container']
```

`\Drupal\bamboo_twig\TwigExtension\TwigExtensionBase` extends Twig's `AbstractExtension` and holds
the service container. It exposes **protected lazy getters** so an extension resolves a Drupal
service only when a template actually calls one of its functions (performance: nothing is
instantiated at build time). It registers no Twig function itself.

## How submodules use it

Each submodule service declares `parent: bamboo_twig.twig.base` and tags `twig.extension`, e.g.:

```yaml
services:
  bamboo_twig_loader.twig.loader:
    class: Drupal\bamboo_twig_loader\TwigExtension\Loader
    tags: [{ name: twig.extension }]
    parent: bamboo_twig.twig.base
```

The subclass overrides `getName()` and implements `getFunctions()` / `getFilters()`, calling the
inherited getters (e.g. `$this->getEntityTypeManager()`).

## Available lazy getters (selection)

`getEntityTypeManager()`, `getEntityRepository()`, `getCurrentRouteMatch()`,
`getPluginManagerBlock()`, `getFormBuilder()`, `getMenuLinkTree()`, `getSettingsSingleton()`,
`getConfigFactory()`, `getStateFactory()`, `getCurrentUser()`, `getUserStorage()`,
`getBlockStorage()`, `getFileStorage()`, `getImageStyleStorage()`, `getImageFactory()`,
`getFieldTypeManager()`, `getToken()`, `getExtensionGuesser()` (a `Symfony\Component\Mime\MimeTypes`),
`getDateFormatter()`, `getLanguageManager()`, `getFileSystemObject()`, `getStreamWrapperManager()`,
`getContextRepository()`, `getContextHandler()`, `getFileUrlGenerator()`,
`getExtensionPathResolver()`, `getRequestStack()`, `getTitleResolver()`.

## Writing your own Bamboo-style extension

```php
namespace Drupal\my_module\TwigExtension;

use Drupal\bamboo_twig\TwigExtension\TwigExtensionBase;
use Twig\TwigFunction;

class MyExt extends TwigExtensionBase {
  public function getName() { return 'my_module.twig.my'; }
  public function getFunctions() {
    return [new TwigFunction('my_current_uid', $this->currentUid(...))];
  }
  public function currentUid() { return $this->getCurrentUser()->id(); }
}
```

```yaml
# my_module.services.yml
services:
  my_module.twig.my:
    class: Drupal\my_module\TwigExtension\MyExt
    tags: [{ name: twig.extension }]
    parent: bamboo_twig.twig.base
```

Your module just needs to depend on `bamboo_twig`. No config or hooks required — the tagged
`twig.extension` service is discovered automatically.
