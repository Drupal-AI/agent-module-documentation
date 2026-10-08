Domain Early Negotiation runs the Domain module's active-domain negotiation as an HTTP middleware early in the stack, so domain_config overrides are resolved before other middlewares (and, by default, before the page cache) read Drupal configuration.

---

The module registers an HTTP middleware `http_middleware.domain_negotiation` (`DomainNegotiationMiddleware`) tagged at a configurable priority (default 220). On the main request it pushes the request onto the `request_stack` and calls `domain.negotiator`'s `getActiveDomain()`, so the active domain is resolved from the (reverse-proxy-corrected) hostname before later middlewares run. The default priority (220) sits below ReverseProxy (300) but above the page cache (200), meaning negotiation happens on every request including cached ones; on Drupal < 11.1 it also calls `ModuleHandler::loadAll()` so procedural `#[LegacyHook]` implementations like `hook_domain_request_alter` fire, while on 11.1+ OOP hooks dispatch via the container and `loadAll()` is only a cold-cache fallback. `DomainEarlyNegotiationServiceProvider` reads the `priority` setting via `BootstrapConfigStorageFactory` during container build and rewrites the middleware's `http_middleware` tag priority; `ConfigSubscriber` invalidates the container when `domain_early_negotiation.settings:priority` changes so the new priority takes effect. A settings form (`DomainEarlyNegotiationSettingsForm`, route `domain_early_negotiation.settings` at `/admin/config/domain/early-negotiation`, requires the `administer domains` permission, linked under the Domain admin menu) exposes the single `priority` integer (1–299). An OOP hook implementation adds `domain_early_negotiation.settings` to `hook_domain_config_ui_disallowed_configurations_alter` so the priority setting itself is not domain-overridable. Config: `domain_early_negotiation.settings` (`priority`, default 220), with schema. Depends only on `domain:domain`.

---

- Make domain_config overrides available to other middlewares by negotiating the active domain before they run.
- Ensure the active domain is resolved before the page cache serves cached responses (default priority 220).
- Tune the middleware priority (1–299) at `/admin/config/domain/early-negotiation`.
- Lower the priority below 200 so negotiation runs after the page cache when overrides are not needed that early.
- Keep the priority under 300 so ReverseProxy has already corrected `HTTP_HOST` before negotiation.
- Have negotiation read the proxy-corrected hostname via the pushed `request_stack` entry.
- Fire `hook_domain_request_alter` and other domain hooks early in the request on Drupal < 11.1.
- Rely on OOP-hook dispatch without forcing full module loading on Drupal 11.1+.
- Automatically rebuild the container when the priority setting is saved (via `ConfigSubscriber`).
- Restrict priority changes to users with the `administer domains` permission.
- Keep the priority setting out of per-domain configuration overrides.
- Install alongside modules like CleanTalk that read Drupal config in their own middleware and need the domain resolved first.
- Set the default priority programmatically through `domain_early_negotiation.settings:priority`.
- Read the negotiated active domain later in the request via `domain.negotiator`.
- Add it to any Domain Access site that needs domain context established before other request-time processing.
