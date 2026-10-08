# Autowire Plugin Trait — agent index

One trait that gives plugins a generic autowiring `create()`. No config, routes, permissions,
services, or Drush. Core `^10 || ^11`.

- **How to use the trait, name-matched args, and `#[Autowire]` overrides** → [api/trait.md](api/trait.md)

Key facts:
- Trait: `Drupal\autowire_plugin_trait\AutowirePluginTrait` (namespace `autowire_plugin_trait`).
- Use it on any `ContainerFactoryPluginInterface` plugin and delete your own `create()`.
