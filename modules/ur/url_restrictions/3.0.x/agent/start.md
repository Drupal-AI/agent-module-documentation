<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Url Restrictions — agent index

Restricts default Drupal URLs (`node/*`, `taxonomy/*`, `user/*`) via a `KernelEvents::REQUEST` subscriber
that **redirects** users lacking the `allow_all_url` permission. Config at `url_restrictions.config.form`;
provides permissions. Version **3.0.0**. Core `>=8`.

**Caveat: redirect-based, NOT entity access control** — redirects matched paths but the content isn't
access-restricted (still reachable via aliases/JSON:API/REST/Views). URL-tidying/soft deterrent; use
entity access for real confidentiality.
