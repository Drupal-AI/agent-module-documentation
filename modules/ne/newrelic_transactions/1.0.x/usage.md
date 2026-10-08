<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
New Relic Transactions renames the transactions the New Relic PHP agent records — using the Drupal route, the entity bundle, and the user's highest-weight role instead of the `index.php` entry point — and can optionally attach the current user's id and roles as New Relic custom parameters.

---

An APM tool groups timing data by transaction name, and that grouping is the whole value: it is how you learn that article pages are slow and event pages are not, or that the same route is fast for anonymous visitors and slow for editors. Out of the box the New Relic PHP agent sees `index.php` for every request, so a Drupal site's entire traffic collapses into one bucket and the dashboard says the site takes 400 ms on average — which is true and useless. Naming transactions by route separates them; adding the **bundle** separates node pages by content type, which is where real differences live because one type has forty fields and another has three; and adding the **highest-weight role** separates the anonymous request served from cache from the editor's request that rebuilds everything, which is the single most common reason an average is misleading. The mechanism is one `KernelEvents::REQUEST` subscriber that is only registered when the `newrelic` PHP extension is loaded: it builds the name from `$route->getPath()` (substituting `{entity}` placeholders with the entity's `{bundle}`), appends the role in parentheses, and calls `newrelic_name_transaction()`. A separate, **opt-in** step calls `newrelic_add_custom_parameter()` to send the current user's **id** and/or **roles**, chosen on the config form at `/admin/config/development/newrelic-transactions` — both ship off. Version **1.0.5** on `^8.8` through `^11`. Two things worth attaching. **Cardinality is the constraint** — an APM charges and aggregates by distinct transaction name, so a naming scheme that includes an entity id produces a name per node and buries the signal in noise; route plus bundle plus role is a deliberate choice of three low-cardinality dimensions, and it is the right shape. And **role (and the optional uid) in the APM is a small disclosure** to whoever reads it: it says which roles exist and how traffic distributes across them, which is unremarkable for most sites and worth a moment on one where the role names themselves are sensitive — but it never sends emails, tokens, or session data.

---

- Separate transaction timing by route.
- Distinguish article pages from event pages.
- Compare anonymous and editor performance.
- Fix an APM showing only index.php.
- Find which content type is slow.
- Measure a route's real performance.
- Separate cached from uncached requests.
- Improve New Relic dashboard usefulness.
- Diagnose slow editorial pages.
- Compare performance across bundles.
- Identify a slow admin route.
- Support a performance investigation.
- Measure the cost of a role's permissions.
- Attach the acting user's id to slow transactions for debugging.
- Tag transactions with the user's roles.
- Limit which roles appear in transaction names.
- Find a slow view's route.
- Track performance after a release.
- Separate API traffic from page traffic.
- Support capacity planning.
- Improve APM signal quality.
