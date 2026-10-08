# Autowire Plugin Trait — manual setup guide

**Autowire Plugin Trait** (`autowire_plugin_trait`) is a small developer helper. It
provides a single PHP trait that lets your Drupal plugins **autowire their constructor
dependencies** from the service container, so you can delete the boilerplate `create()`
method you would otherwise hand‑write on every container‑aware plugin.

The trait, `Drupal\autowire_plugin_trait\AutowirePluginTrait`, implements a generic
static `create()`. It reflects over your plugin's `__construct()` and, for each
argument, supplies `$configuration`, the plugin id, and the plugin definition by name,
and resolves everything else from the container by its type hint (or by an explicit
`#[Autowire(service: '…')]` attribute when the type is ambiguous). If a required
service cannot be found it throws a clear `AutowiringFailedException`. Use it on blocks,
field widgets and formatters, actions, conditions — any plugin implementing
`ContainerFactoryPluginInterface`.

This is purely a code library: it has **no configuration, no admin UI, no routes, no
permissions, and no services of its own**. Enabling the module simply makes the trait
available for your custom code to `use`.

One important caveat: this branch caps at Drupal `^10 || >=11 <11.3`, because the module
is **obsolete from Drupal 11.3**. Core's `PluginBase` gained its own autowiring
`create()` factory in 11.3, so on 11.3+ you should drop the trait and rely on
`PluginBase` instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for this module — it has no settings form and adds
nothing to the admin menu. Everything happens in your own PHP code.

## How to use it

In a container‑aware plugin, add the trait and remove your hand‑written `create()`:

```php
use Drupal\autowire_plugin_trait\AutowirePluginTrait;

class MyBlock extends BlockBase implements ContainerFactoryPluginInterface {

  use AutowirePluginTrait;

  public function __construct(
    array $configuration,
    string $plugin_id,
    array $plugin_definition,
    protected EntityTypeManagerInterface $entityTypeManager,
  ) {
    parent::__construct($configuration, $plugin_id, $plugin_definition);
  }

}
```

The trait's `create()` fills the first three arguments automatically and resolves
`$entityTypeManager` from the container by its type hint. When a type is ambiguous, name
the exact service with `#[Autowire(service: 'my.service')] MyInterface $thing`.
Constructor parameter names may be either snake_case (`plugin_id`) or camelCase
(`pluginId`).
