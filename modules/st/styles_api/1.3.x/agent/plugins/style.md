# Define a Style plugin (`@Style`)

Two ways to register a style: an **annotated PHP plugin** in `src/Plugin/Style/`, or a
**YAML entry** in a `<provider>.themes.yml` file (module or theme).

## Plugin type mechanics

| Piece | Value |
|---|---|
| Discovery dir | `src/Plugin/Style/` (annotation) |
| YAML discovery | `<provider>.themes.yml` (key = plugin id) |
| Annotation | `@Style` (`Drupal\styles_api\Annotation\Style`) |
| Interface | `Drupal\styles_api\Plugin\Style\StyleInterface` |
| Base class | `Drupal\styles_api\Plugin\Style\StyleBase` (concrete: `StyleDefault`) |
| Manager service | `plugin.manager.styles_api` (`StylePluginManager`) |
| Alter hook | `hook_styles_alter(array &$definitions)` |
| Cache | `cache.discovery`, cid `styles` |

## `@Style` / YAML properties

| Property | Meaning |
|---|---|
| `id` | Plugin id (required). |
| `type` | `block`, `region`, or `element` (default `block`). |
| `label` | Human-readable name. |
| `description` | Optional (used for accessibility summaries). |
| `category` | Human-readable category for grouping. |
| `template` | Template file (relative to `path`); Styles API registers it with `hook_theme()` **for you**. Mutually exclusive with `theme`. |
| `theme` | An existing theme hook you register yourself. Mutually exclusive with `template`. |
| `path` | Base path to resources (relative to the providing module/theme). |
| `icon` | Preview image path (relative to `path`). |

`StylePluginManager::processDefinition()` prefixes `path`/`icon` with the providing module or
theme's base path automatically, and records `provider_type` (`module` or `theme`).

## Annotated plugin example

```php
namespace Drupal\my_module\Plugin\Style;

use Drupal\styles_api\Plugin\Style\StyleBase;

/**
 * @Style(
 *   id = "my_callout",
 *   type = "element",
 *   label = @Translation("Callout"),
 *   category = @Translation("Cards"),
 *   template = "my-callout",
 *   path = "templates",
 *   icon = "icons/callout.png",
 * )
 */
class MyCallout extends StyleBase {}
```

Extend `StyleBase` (or use `StyleDefault`) — most styles need no extra PHP. Because `template`
is set, Styles API registers the `my-callout` theme hook via its own `hook_theme()`; ship
`templates/my-callout.html.twig`.

## YAML example (`my_module.themes.yml`)

```yaml
my_callout:
  type: element
  label: 'Callout'
  category: 'Cards'
  template: my-callout
  path: templates
```

The provider may be a **theme** too (`my_theme.themes.yml`) — themes can register or override
styles.

## Register / verify

```bash
drush cr
drush php:eval 'var_export(array_keys(\Drupal::service("plugin.manager.styles_api")->getDefinitions()));'
```

Your `id` appears in the manager's definitions once caches are cleared. See
[../api/manager.md](../api/manager.md) for listing/rendering.
