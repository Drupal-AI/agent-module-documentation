<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Noindex on empty views prevents empty view/listing pages from being indexed.

---

Noindex on empty views adds a `noindex` robots meta tag to a view's page when it returns no results — so empty listing pages (e.g. a filtered search with zero matches) aren't indexed by search engines, avoiding thin/empty pages hurting SEO.

It's an SEO enhancement with no content or access role of its own. Depends on core `views`; supports Drupal 10 and 11.

---

- Add noindex to empty views.
- Prevent indexing empty listings.
- Avoid thin/empty pages in search.
- Improve SEO.
- Detect zero-result views.
- Add a robots meta tag.
- Depend on core `views`.
- Support Drupal 10 and 11.
- Carry no content/access role.
- Handle empty listings.
- Support search hygiene.
- Apply per view.
- Avoid indexing empties
- Configure the behavior
- Improve crawl quality.
- Handle no-result pages.
- Emit noindex.
- Support SEO
