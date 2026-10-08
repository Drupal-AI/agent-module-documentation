Submodule of Redirect that redirects requests from one whole domain to another (optionally mapping sub-paths), rather than mapping individual URLs.

---

`redirect_domain` adds a **Domain redirects** admin form (`/admin/config/search/redirect/domain`) where you list domains and, for each, the destination they should redirect to — optionally per sub-path. Its configuration lives in a single config object (`redirect_domain.domains`) as a map of `domain → [{sub_path, destination}]`, so whole-domain rules are exportable and deployable. At runtime a request subscriber (`DomainRedirectRequestSubscriber`) inspects the incoming host and, using Redirect's shared `redirect.checker` and the path matcher, issues a redirect to the configured destination before the page renders. This is the tool for consolidating parked or legacy domains onto a canonical domain, handling brand or rename migrations, or steering country/vanity domains to specific sections of the main site. It complements the parent module's per-URL redirects: use Redirect for individual paths and Redirect Domain for entire hostnames. Requires the Redirect module; access is gated by the `administer redirects` permission.

---

- Redirect an entire old domain to a new one after a rebrand.
- Consolidate several parked domains onto one canonical domain (good for SEO).
- Point a country/vanity domain at a specific sub-path of the main site.
- Force `example.net` traffic to `example.com`.
- Migrate a legacy site's domain while keeping links working.
- Map each alias domain to a different landing section via sub-paths.
- Keep whole-domain rules in exportable config for staging → production.
- Handle acquired-brand domains by forwarding them to a campaign page.
- Retire a microsite domain by redirecting it wholesale.
- Redirect a marketing domain to a product page.
- Enforce a single canonical hostname across many registered domains.
- Send a short/branded domain to the corresponding deep link.
- Combine with the parent Redirect module: domains here, individual URLs there.
- Configure per-domain destinations from one admin screen.
- Redirect before Drupal renders, using the shared redirect checker.
