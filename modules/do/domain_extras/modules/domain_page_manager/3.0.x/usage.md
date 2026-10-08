Domain for Page Manager exposes the active domain to Page Manager as a runtime context, so page variants can be selected based on which domain the visitor is on.

---

Domain for Page Manager is a small glue module that bridges the Domain suite with Page Manager. Its only moving part is an event subscriber, `Drupal\domain_page_manager\EventSubscriber\CurrentDomainContext` (service `page_manager.current_domain_context`, registered in `domain_page_manager.services.yml` with autowiring), which listens on `PageManagerEvents::PAGE_CONTEXT`. When Page Manager assembles the contexts for a page, the subscriber pulls the current domain from the context repository (`@domain.current_domain_context:domain`, provided by the base `domain` module) via `ContextRepositoryInterface::getRuntimeContexts()` and, if a domain context is present, adds it to the page as a context named `domain` (`$event->getPage()->addContext('domain', $context)`). The guard is deliberate: the PAGE_CONTEXT event also fires during early request phases (permission-cache warming, language negotiation) before any domain has been negotiated, so when the repository yields nothing the subscriber adds no context rather than passing a null through Page Manager's typed API. With the `domain` context available on the page, Page Manager's selection UI can use the domain-based selection criteria shipped by the Domain suite to route different variants to different domains. The module defines no routes, permissions, config, schema, or plugin types; it depends on `page_manager:page_manager` and `domain:domain`.

---

- Make the active domain available to Page Manager pages as a `domain` context.
- Select a different page variant per domain using domain selection criteria.
- Serve distinct landing pages for each affiliate domain from one Page Manager page.
- Show or hide a page variant depending on the visitor's current domain.
- Combine domain criteria with Page Manager's other selection rules on the same variant.
- Reference the current domain in a variant's blocks/contexts on multi-domain sites.
- Route traffic on example.com vs. example.org to different Page Manager layouts.
- Build domain-specific homepages without duplicating whole pages.
- Rely on automatic context wiring — no configuration form to fill in.
- Let variants fall back gracefully on requests where no domain is resolved yet.
- Pair with Domain Access to align page-building with per-domain content.
- Enable the module and open any Page Manager page to gain the domain context immediately.
