A single-trait developer helper that lets Drupal plugins implementing `ContainerFactoryPluginInterface` autowire their constructor dependencies from the service container instead of hand-writing a `create()` method.

---

The module provides one trait, `Drupal\autowire_plugin_trait\AutowirePluginTrait`, that
implements a generic static `create()`. It reflects over your plugin's `__construct()` and,
for each parameter, injects `$configuration`, `$plugin_id`/`$pluginId`,
`$plugin_definition`/`$pluginDefinition` by name, and otherwise resolves the argument from the
container by its type-hinted service id (or by an explicit `#[Autowire(service: '…')]`
attribute on the parameter). If a required service is not found it throws
`AutowiringFailedException`. This removes the usual boilerplate `create()` on blocks, field
widgets/formatters, actions, and other container-aware plugins. It is purely a code library:
no routes, no permissions, no config, no services of its own. The implementation mirrors a
proposed Drupal core trait ([drupal.org issue #3452852](https://www.drupal.org/project/drupal/issues/3452852))
so it can be used today.

---

- Drop the hand-written `create()` from a custom Block plugin and let dependencies autowire.
- Autowire services into a custom field widget or field formatter plugin.
- Autowire dependencies into a custom Action, Condition, or other `ContainerFactoryPluginInterface` plugin.
- Inject a service by type-hint alone (e.g. `EntityTypeManagerInterface $entityTypeManager`).
- Inject a specific service id via `#[Autowire(service: 'my.service')]` when the type is ambiguous.
- Use either snake_case (`plugin_id`) or camelCase (`pluginId`) constructor parameter names.
- Reduce boilerplate across many plugins in a large custom module.
- Adopt the core-proposed autowiring pattern now, ahead of it landing in core.
- Keep plugin constructors clean by relying on the parent's four positional args when there is no `__construct`.
- Fail fast with a clear `AutowiringFailedException` when a required service is missing.
- Standardise DI style across a team's custom plugins.
- Prototype a plugin quickly without wiring `create()` first.
- Migrate legacy plugins toward constructor-property-promotion + autowiring.
- Avoid mistakes from manually mismatching `create()` argument order.
- Combine `$configuration` handling with autowired services in one constructor.
- Pair with modules that ship many plugin types to cut repetitive DI code.
