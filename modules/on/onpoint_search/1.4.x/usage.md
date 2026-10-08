<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OnPoint Search integrates the OnPoint Search service into a Drupal site, providing search backed by the OnPoint platform.

---

OnPoint Search integrates the OnPoint Search service — a hosted search platform — into Drupal,
providing site search backed by OnPoint rather than a local index. It configures the connection to an
OnPoint account (at `onpoint_search.settings`) and surfaces OnPoint-powered search on the site; it
ships an `onpoint_search_d8` submodule and provides its own permissions.

Use it where search is outsourced to OnPoint for its features/relevance. As with any hosted-search
integration, store the OnPoint API credentials as secrets, and note that query terms (and possibly
crawled content) are sent to the external service — the usual SaaS trade-off of less local
infrastructure for a dependency on OnPoint's availability and data handling.

---

- Add OnPoint hosted search to Drupal.
- Back site search with OnPoint.
- Configure the OnPoint connection.
- Store OnPoint credentials as secrets.
- Use OnPoint instead of a local index.
- Configure at onpoint_search.settings.
- Provide its own permissions.
- Surface OnPoint-powered search.
- Depend on OnPoint availability.
- Send query terms to OnPoint.
- Outsource site search.
- Use the onpoint_search_d8 submodule.
- Rely on OnPoint relevance.
- Trade infra for a SaaS dependency.
- Present OnPoint results.
- Handle OnPoint authentication.
- Connect to an OnPoint account.
- Replace local search with OnPoint.
- Mind data sent to the service.
- Integrate hosted search.
