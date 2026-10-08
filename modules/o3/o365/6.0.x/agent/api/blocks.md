# API: block base classes for Graph-backed blocks

To build a block that shows Microsoft 365 data, extend one of the module's base classes in
`src/Block/`. Both inject the Graph service and enforce the correct access rule.

| Base class | When to use |
|---|---|
| `Drupal\o365\Block\O365BlockBase` | A block whose Graph output is the same for everyone who can see it (cacheable). |
| `Drupal\o365\Block\O365UncachedBlockBase` | A block that renders **per-user** Graph data. Adds `UncacheableDependencyTrait` so one user's Microsoft data is never cached and shown to another. |

Both:
- Implement `ContainerFactoryPluginInterface` and receive `@o365.graph` as `$this->graphService`.
- Override `access()` so the block is **forbidden for anonymous users** and **allowed only when
  `$this->graphService->getCurrentUserId()` is truthy** (i.e. the current user is signed in via
  `o365_sso`).

```php
namespace Drupal\my_module\Plugin\Block;

use Drupal\o365\Block\O365UncachedBlockBase;

/**
 * @Block(id = "my_o365_block", admin_label = @Translation("My M365 block"))
 */
class MyO365Block extends O365UncachedBlockBase {

  public function build() {
    $data = $this->graphService->getGraphData('/me/messages?$top=5');
    return [
      '#theme' => 'item_list',
      '#items' => array_column($data['value'] ?? [], 'subject'),
    ];
  }
}
```

Rule of thumb: anything reflecting the signed-in user's own mailbox, calendar, files, or profile
should extend `O365UncachedBlockBase`. Every `o365_*` block also gets the CSS class `o365-block`
added by `o365_preprocess_block()`.

## Persona theming

The module registers theme hooks `o365_persona_render_{small,medium,large}`, `o365_brandicon`, and
`o365_auth_scopes_table` (`o365.module`). Render a persona card with
`PersonaRenderService::renderPersona()` (see [services.md](services.md)); it attaches the
`o365/persona` library. Other libraries in `o365.libraries.yml`: `o365/general`, `o365/icons`
(Fluent UI, loaded from an external CDN), `o365/callout`, `o365/persona.component.presence`.
