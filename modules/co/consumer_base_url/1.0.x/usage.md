<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a base URL per consumer, used for canonical URLs and URL tokens.

---

Consumer Base URL provides a base URL per consumer and uses it for entity canonical URLs, URL tokens and other URL generation — so in a decoupled setup each API consumer (e.g. a specific frontend) can have its own base URL, and links generated for that consumer point at the right frontend rather than the Drupal backend. Depends on core `path_alias` and `consumers`; supports Drupal 10.3+ and 11.

---

- Provide a base URL per consumer.
- Use it for canonical URLs.
- Use it for URL tokens.
- Point links at the right frontend.
- Support decoupled/headless setups.
- Vary URLs by API consumer.
- Depend on core `path_alias` and `consumers`.
- Support Drupal 10.3+ and 11.
- Configure per-consumer URLs.
- Aid decoupled sites.
- Generate frontend URLs.
- Handle consumer URLs
- Set base URLs
- Support Consumers
- Support Drupal.
