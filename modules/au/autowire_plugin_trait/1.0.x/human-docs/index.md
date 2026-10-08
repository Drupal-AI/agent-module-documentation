# Autowire Plugin Trait — manual setup guide

**Autowire Plugin Trait** (`autowire_plugin_trait`) is a small developer helper. It
provides a single PHP trait that lets Drupal plugins **autowire** their constructor
dependencies from the service container, so you can delete the repetitive `create()`
method you would normally hand‑write on blocks, field widgets and formatters,
actions, and other container‑aware plugins.

Normally a plugin that needs services implements `ContainerFactoryPluginInterface`
and writes a `create()` method that pulls each service out of the container and
passes it to the constructor in the right order — boilerplate that is easy to get
wrong. With this trait, you add `use AutowirePluginTrait;` to the plugin and remove
your `create()`. The trait's generic `create()` reflects over your constructor and
injects the standard plugin arguments (`$configuration`, the plugin id, the plugin
definition) by name, and resolves every other parameter from the container by its
type‑hinted service — or by an explicit `#[Autowire(service: '…')]` attribute when the
type is ambiguous. If a required service can't be found, it fails fast with a clear
exception.

The implementation mirrors a trait proposed for Drupal core
([issue #3452852](https://www.drupal.org/project/drupal/issues/3452852)), so you can
adopt the pattern today. It is purely a code library: no routes, no permissions, no
configuration, and no services of its own.

This guide is written for a **human** (well, a developer) setting the module up. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — this module has **no admin UI, no settings, and no permissions**. It exists
only so your custom code can `use` its trait.

## How to use it

On any plugin that implements `ContainerFactoryPluginInterface`, add the trait and
delete your own `create()`:

```php
use Drupal\Core\Block\BlockBase;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\autowire_plugin_trait\AutowirePluginTrait;
use Symfony\Component\DependencyInjection\Attribute\Autowire;

class MyBlock extends BlockBase implements ContainerFactoryPluginInterface {
  use AutowirePluginTrait;

  public function __construct(
    array $configuration,
    $plugin_id,
    $plugin_definition,
    protected EntityTypeManagerInterface $entityTypeManager,
    #[Autowire(service: 'my_module.thing')] protected ThingInterface $thing,
  ) {
    parent::__construct($configuration, $plugin_id, $plugin_definition);
  }
  // No create() needed.
}
```

How the trait resolves each constructor parameter, by name:

- `configuration` → the plugin's `$configuration` array.
- `plugin_id` or `pluginId` → the plugin id.
- `plugin_definition` or `pluginDefinition` → the plugin definition.
- any other parameter → the service whose id matches the parameter's type‑hint,
  unless a `#[Autowire(service: '…')]` attribute overrides it. A missing service
  throws `AutowiringFailedException`.

Notes: the order of the four standard arguments doesn't matter (resolution is by
name). The type‑hint must correspond to a real service id (or use an explicit
`#[Autowire]`); plain value objects that aren't services will not resolve. If the
class has no constructor at all, the trait falls back to the classic four‑argument
construction.
