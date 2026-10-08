<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Early Negotiation (domain_early_negotiation) 3.0.x

![Domain Early Negotiation settings form (/admin/config/domain/early-negotiation)](../../../../../../../../screenshots/domain_early_negotiation/3.0.x/settings.png)

Runs Domain's active-domain negotiation as an early HTTP middleware so domain_config
overrides are resolved before other middlewares (and, by default, the page cache) read config.
Part of **domain_extras**; depends on **domain**.

## Facts
- **Dependency:** `domain:domain` (info.yml).
- **Middleware:** `http_middleware.domain_negotiation` → `Drupal\domain_early_negotiation\StackMiddleware\DomainNegotiationMiddleware`, tagged `http_middleware` priority **220** (default). On MAIN_REQUEST it pushes the request onto `request_stack`, calls `domain.negotiator->getActiveDomain()`, then pops. Below ReverseProxy (300), above page cache (200). Drupal < 11.1: also calls `ModuleHandler::loadAll()` so procedural `#[LegacyHook]`s fire; 11.1+: `loadAll()` only as a cold entity-type-cache fallback. (`src/StackMiddleware/DomainNegotiationMiddleware.php`, `domain_early_negotiation.services.yml`)
- **Service provider:** `Drupal\domain_early_negotiation\DomainEarlyNegotiationServiceProvider` reads `domain_early_negotiation.settings:priority` via `BootstrapConfigStorageFactory` at container build (`register()` sets param `domain_early_negotiation.priority`, default 220) and rewrites the middleware's tag priority (`alter()`). (`src/DomainEarlyNegotiationServiceProvider.php`)
- **Event subscriber:** `Drupal\domain_early_negotiation\EventSubscriber\ConfigSubscriber` on `config.save`: invalidates the container (`kernel->invalidateContainer()`) when `priority` changes so a new priority is applied. (`src/EventSubscriber/ConfigSubscriber.php`)
- **Route / form:** `domain_early_negotiation.settings` → `/admin/config/domain/early-negotiation`, `_form: DomainEarlyNegotiationSettingsForm`, requires permission **`administer domains`**. One field `priority` (`#type` number, min 1, max 299, `#config_target` `domain_early_negotiation.settings:priority`). (`domain_early_negotiation.routing.yml`, `src/Form/DomainEarlyNegotiationSettingsForm.php`)
- **Menu link:** `domain_early_negotiation.settings` "Early negotiation" under parent `domain.admin`, weight 10. (`domain_early_negotiation.links.menu.yml`)
- **Hook:** OOP `Drupal\domain_early_negotiation\Hook\DomainEarlyNegotiationHooks::disallowedConfigurationsAlter()` (`#[Hook('domain_config_ui_disallowed_configurations_alter')]`, mirrored by a `#[LegacyHook]` shim in `.module`) adds `domain_early_negotiation.settings` to the domain_config_ui disallowed list — the priority setting is not per-domain overridable.
- **Config:** `domain_early_negotiation.settings` (`config/install`, `priority: 220`) with schema (`config/schema`, `priority` integer). `provides_config_schema: true`.
- **Permissions:** none defined (uses core/domain `administer domains`). No Drush commands, no plugin types.
- **Configure route (Extend):** `domain_early_negotiation.settings`.
- **Tests:** `tests/src/Kernel/DomainEarlyNegotiationTest.php` (container param, middleware/subscriber registration, priority-change container rebuild, negotiation from Host header).

## Setup / How to use
1. Install; the middleware is active immediately at priority 220 — no config required.
2. To tune ordering, go to **`/admin/config/domain/early-negotiation`** (Configuration → Domain → Early negotiation; needs `administer domains`) and set **Middleware priority** (1–299). Higher runs earlier; keep it under 300 (ReverseProxy) and above any middleware that needs domain_config overrides.
3. Values above 200 run before the page cache, so negotiation executes on every request (including cached pages); lower it below 200 if you do not need overrides before the page cache. On Drupal < 11.1 a priority above the page cache also forces all module files to load.
4. Saving a changed priority invalidates the container so the new priority takes effect on the next request/rebuild.
