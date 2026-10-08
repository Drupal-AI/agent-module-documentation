# Configuration Selector — agent index

Developer utility: ship multiple alternative versions of the same *optional* configuration and
auto-enable one based on installed modules + a priority number. Only ever disables config (never
deletes), so switching is reversible. Driven by module install/uninstall hooks; no Drush, no
module-defined permissions, `configure` is null. Config schema ships for Views and Blocks.

- **The whole mechanism** — the `third_party_settings.config_selector` YAML pattern (feature +
  priority), required dependency, adding schema for other config entity types, selection/priority
  behavior, the `config_selector` service, and the `/admin/structure/config_selector` UI →
  [configure/features.md](configure/features.md)

Key facts:
- A config entity joins a feature via `third_party_settings.config_selector.feature: <name>` and
  `priority: <int>`, plus `config_selector` in its `dependencies.module`.
- On install/uninstall, among all enabled variants sharing a feature the highest `priority` stays
  enabled; the rest are set to `status: false`.
- Only works with config entities that **can be disabled**. Built-in schema: `views.view.*` and
  `block.block.*`; other types need a `config_selector_third_party` schema mapping.
- Admin list at `/admin/structure/config_selector` (`administer site configuration`); add/edit/delete
  forms are stubbed — intended for developers editing YAML.
