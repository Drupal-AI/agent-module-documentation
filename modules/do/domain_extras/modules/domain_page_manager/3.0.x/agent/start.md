<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain for Page Manager (domain_page_manager) 3.0.x

Part of **domain_extras**. Adds the active domain to Page Manager as a runtime context so
page variants can be selected by the domain the visitor is on.

## Facts
- **Dependencies:** `page_manager:page_manager`, `domain:domain` (info.yml). Package: Domain.
- **Routes / permissions / config / schema / plugins:** none. No `configure` route.
- **Service:** `page_manager.current_domain_context` →
  `Drupal\domain_page_manager\EventSubscriber\CurrentDomainContext`
  (`domain_page_manager.services.yml`, autowired). Constructor takes
  `ContextRepositoryInterface`.
- **Event subscriber:** listens on `PageManagerEvents::PAGE_CONTEXT` via `onPageContext()`
  (`src/EventSubscriber/CurrentDomainContext.php`).
- **What it does:** fetches the current domain with
  `contextRepository->getRuntimeContexts(['@domain.current_domain_context:domain'])`
  (context provided by base `domain`), and if a `ContextInterface` is returned calls
  `$event->getPage()->addContext('domain', $context)`. If no domain is resolved (e.g. the
  event fires during permission-cache warming / language negotiation before domain
  negotiation), it adds nothing — avoids passing null into a typed argument.

## How to use
1. Enable the module (`drush en domain_page_manager -y`); it depends on Page Manager and
   the base Domain module.
2. No configuration form — the `domain` context is wired onto every Page Manager page
   automatically once enabled.
3. Editing a Page Manager page/variant, use the Domain suite's domain-based selection
   criteria on a variant; the variant is then chosen when the criteria match the current
   domain. The context appears on the page as `domain`.

## Docs
- (none — single-file module)
