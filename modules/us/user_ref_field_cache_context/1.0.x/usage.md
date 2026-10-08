<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A cache context that varies by a reference field on the current user.

---

User Reference Field Cache Context provides a cache context based on a reference field for the current user — so render caching can vary by the value of an entity-reference field on the logged-in user (e.g. their organisation or assigned terms), letting personalised output cache correctly per that field. It's a developer/performance primitive (used by e.g. Search API Solr Boost By User Term). Supports Drupal 8 through 11.

---

- Provide a user-reference cache context.
- Vary caching by a user's reference field.
- Cache personalised output correctly.
- Key on the current user's field value.
- Serve as a developer primitive.
- Support other modules.
- Support Drupal 8 through 11.
- Configure nothing (an API).
- Aid caching.
- Handle cache contexts.
- Vary by user field.
- Personalise caching
- Support Drupal.
- Support Drupal.
- Support Drupal.
