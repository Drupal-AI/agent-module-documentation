<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Config Pages (domain_config_pages) — agent index

Adds a single **domain context plugin** to the **Config Pages** module so one Config Pages "type"
(a fielded settings entity) can hold **different values per Domain** on a Domain-module multi-site.
The whole module is ~40 lines: one `ConfigPagesContext` plugin whose id is `domain`
(`src/Plugin/ConfigPagesContext/Domain.php`) plus one `hook_config_schema_info_alter()`
(`domain_config_pages.module`) that adds the `domain` key to the config_pages `context.fallback`
schema. It defines **no routes, services, permissions, forms, controllers, libraries or drush
commands of its own** — everything visible to an editor (the type UI, the edit form, the
entity-access checks) lives in `config_pages`.

Mechanism: `config_pages` lets a plugin of type `ConfigPagesContext` return a discriminator string;
config_pages then stores/loads a separate value set per distinct discriminator. This plugin's
`getValue()` returns `\Drupal\domain\DomainNegotiatorInterface::getActiveId()` — the id of the
domain the visitor is currently on — so each domain sees its own values. `getLabel()` returns the
active domain's label and `getLinks()` lists all domains as switch links (used inside the config_pages
admin UI). Because the value varies by active domain, anything that renders a per-domain config value
should vary its cache by domain, and the **fallback** you set on the type decides what a domain with
no value of its own is served (default-domain value, empty, or field default) — settle it before
adding a second domain.

- **Depends on:** `config_pages:config_pages`, `domain:domain` (both required; this module is inert
  without them).
- **Core:** `^10 || ^11`. **Package:** `Domain`. **Version:** `1.0.1`.
- **Settings page / configure route:** none of its own — you configure it inside the config_pages
  type form at `/admin/structure/config_pages/types/manage/{config_pages_type}`.
- **Permissions:** none defined here; access is enforced by config_pages' own permissions
  (`administer config_pages types`, `edit config_pages entity`, `config_pages.update` entity access).
- **Plugin types:** provides none (it supplies one *instance* of config_pages' `ConfigPagesContext`
  type). **Drush:** none. **Config schema:** adds one key via alter hook.

## What you'd do → where
- Enable/configure the per-domain context on a Config Pages type, set the fallback → [configure/domain-context.md](configure/domain-context.md)
- Understand the plugin contract, its methods and the schema alter (read/extend it from PHP) → [api/context-plugin.md](api/context-plugin.md)

## Key facts (real machine names)
- Context plugin: id `domain`, class `Drupal\domain_config_pages\Plugin\ConfigPagesContext\Domain`,
  annotation `@ConfigPagesContext(id="domain", label=@Translation("Domain"))`, extends
  `Drupal\config_pages\ConfigPagesContextBase`.
- Plugin type is owned by config_pages: manager service `plugin.manager.config_pages_context`,
  discovery dir `Plugin/ConfigPagesContext`, interface `Drupal\config_pages\ConfigPagesContextInterface`.
- Methods: `getValue(): string` → `domain.negotiator`→`getActiveId()`; `getLabel(): string` →
  `getActiveDomain()->label()`; `getLinks()` → array of `{title, href, selected, value}` for every
  `domain` entity.
- Services consumed (injected): `domain.negotiator` (`DomainNegotiatorInterface`), `entity_type.manager`.
- Hook: `domain_config_pages_config_schema_info_alter()` adds
  `config_pages.type.*` → `context.mapping.fallback.mapping.domain` = `{type: string, label: 'Domain'}`.
- No `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, `*.links.*.yml`, controllers, forms,
  templates, JS or CSS ship with this module.
