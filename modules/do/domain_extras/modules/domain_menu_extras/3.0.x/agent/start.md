<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Menu Extras (domain_menu_extras) 3.0.x

Part of the **domain_extras** suite. Makes core's local-task (menu tab) plugin
discovery cache vary by active domain, so menu derivers that read domain-overridable
config compute the right tabs per domain instead of freezing on the first domain
that warmed the cache.

A **layered, opt-in fix** (per info.yml): "install only if you need it." No routes,
UI, config, permissions, or hooks — enabling the module is the entire setup.

## Facts

- **Dependency:** `domain:domain` (needs `Drupal\domain\DomainNegotiationContext`).
- **Core:** `^10.2 || ^11`. Package `Domain`.
- **Routes / UI / permissions / hooks / config / config schema:** none.
- **Service alter** — `src/DomainMenuExtrasServiceProvider.php`
  (`DomainMenuExtrasServiceProvider::alter()`): if `plugin.manager.menu.local_task`
  is defined, `setClass(DomainAwareLocalTaskManager::class)` and
  `addArgument(new Reference('domain.negotiation_context'))`. `setClass()` +
  `addArgument()` (not a full redefinition) inherit core's argument list, so the
  swap survives upstream constructor changes.
- **Manager** — `src/Menu/DomainAwareLocalTaskManager.php`
  (`DomainAwareLocalTaskManager extends \Drupal\Core\Menu\LocalTaskManager`):
  constructor takes core's args plus `protected DomainNegotiationContext $domainContext`,
  then calls `setCacheBackend()` with key
  `local_task_plugins:LANGCODE:DOMAIN_ID` (tag `local_task`).
  `$domain_id = $this->domainContext->getDomainId() ?? 'und'`.
- **Why:** core keys this cache on language only (`local_task_plugins:LANGCODE`).
  Derivers like `Drupal\block\Plugin\Derivative\ThemeLocalTask` read overridable
  config (e.g. `system.theme.default`), so tabs vary per domain but the key does
  not — the first domain freezes the result. Appending the domain id gives each
  visited domain its own slot; `und` is the sentinel for CLI/install/unbound
  contexts. Cost: one string concat; fragmentation bounded by domains visited.
- **Upstream issue:** https://www.drupal.org/project/domain_extras/issues/3588108
- **Test:** `tests/src/Kernel/DomainAwareLocalTaskManagerTest.php` asserts the class
  swap takes effect and the cache key includes/varies by the active domain id
  (`local_task_plugins:en:a_example_com`, and `:und` when unbound).

## Setup

No configuration. `composer require drupal/domain_extras`, then
`drush en domain_menu_extras -y`. The service alter takes effect on the next
container rebuild; uninstall to restore core's language-only cache key.
