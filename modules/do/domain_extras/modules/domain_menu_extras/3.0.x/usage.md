Domain Menu Extras makes core's local-task (menu tab) plugin discovery cache vary by active domain, so menu derivers that read domain-overridable config compute the right tabs per domain instead of freezing on whichever domain warmed the cache first.

---

Domain Menu Extras is a small, opt-in fix for a specific multi-domain menu problem: Drupal core keys the local task plugin definition cache on language only (`local_task_plugins:LANGCODE`), but derivers such as `Drupal\block\Plugin\Derivative\ThemeLocalTask` read overridable config (e.g. `system.theme.default`) when building their derivatives, so the computed tabs legitimately vary per domain — yet the cache key does not, and the first domain to populate the cache freezes that answer for every other domain. The module ships no routes, forms, permissions, hooks, or config. It works entirely through `DomainMenuExtrasServiceProvider::alter()`, which swaps the `plugin.manager.menu.local_task` service class for `Drupal\domain_menu_extras\Menu\DomainAwareLocalTaskManager` using `setClass()` + `addArgument()` (appending only a `domain.negotiation_context` reference so it inherits core's argument list and survives upstream constructor changes). The subclass re-binds its cache backend in the constructor with a domain-aware key, appending the active domain id: `local_task_plugins:LANGCODE:DOMAIN_ID`, falling back to the `und` sentinel when no domain is negotiated (CLI, install hooks) so those contexts share one stable slot. Cache fragmentation is bounded by the number of domains actually visited and per-request cost is one extra string concatenation. Depends on the core `domain` module (`domain:domain`) for `DomainNegotiationContext`. The info.yml describes it as a "layered, opt-in fix; install only if you need it" — enable it only when per-domain menu tabs are being frozen across domains.

---

- Install only when per-domain menu tabs are being frozen across domains — it is an opt-in fix, not a default.
- Enable it so local task (menu tab) derivers recompute per domain instead of reusing the first domain's result.
- Fix `ThemeLocalTask` tabs that depend on `system.theme.default` when that config is overridden per domain.
- Give each active domain its own local task plugin discovery cache slot keyed `local_task_plugins:LANGCODE:DOMAIN_ID`.
- Keep menu tabs correct on affiliate domains that override theme or other config read by menu derivers.
- Rely on the `DomainMenuExtrasServiceProvider` service alter to swap in `DomainAwareLocalTaskManager` automatically on enable.
- Depend on the core `domain` module's `domain.negotiation_context` to resolve the active domain id at manager construction.
- Trust the `und` fallback so CLI, Drush, and install-hook contexts share one stable cache slot instead of thrashing.
- Uninstall it cleanly to restore core's language-only cache key when the per-domain behavior is no longer needed.
- Pair it with a multi-domain setup that overrides config consumed by menu/local-task derivers.
- Avoid enabling it on single-domain sites where the language-only key is already correct.
- Keep cache fragmentation bounded to the number of domains actually visited by real requests.
- Inherit core's `LocalTaskManager` argument list so the swap stays resilient to core constructor changes.
- Add it as a targeted layer on top of the Domain suite without touching content, fields, or routes.
