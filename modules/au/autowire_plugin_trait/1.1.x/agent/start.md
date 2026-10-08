# Autowire Plugin Trait — agent index

One trait that gives plugins a generic autowiring `create()`. No config, routes, permissions,
services, or Drush. Core `^10 || >=11 <11.3` — **obsolete from Drupal 11.3** (core `PluginBase`
now ships an autowiring `create()`, [CR #3542837](https://www.drupal.org/node/3542837)).

- **How to use the trait, name-matched args, and `#[Autowire]` overrides** → [api/trait.md](api/trait.md)

Key facts:
- Trait: `Drupal\autowire_plugin_trait\AutowirePluginTrait` (namespace `autowire_plugin_trait`).
- Use it on any `ContainerFactoryPluginInterface` plugin and delete your own `create()`.
- Trait code is unchanged from 1.0.x; this branch only caps core below 11.3 and documents the obsolescence.
