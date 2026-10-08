<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Field Datasource indexes field values as items keyed by field rather than entity.

---

Search API Field Datasource provides a Search API datasource that keys on a field instead of the entity — so each field value (e.g. each paragraph, each multi-value item) becomes an indexable item in its own right, enabling field-granular search results rather than only entity-level ones.

It's a Search API datasource plugin with no content or access role of its own (index access follows Search API/entity access). Depends on `search_api`; supports Drupal 10 and 11.

---

- Provide a field-keyed datasource.
- Index field values as items.
- Enable field-granular search.
- Index each multi-value item.
- Go beyond entity-level results.
- Follow Search API/entity access.
- Depend on `search_api`.
- Support Drupal 10 and 11.
- Carry no content/access role.
- Configure the datasource.
- Index paragraphs/fields.
- Support granular indexing.
- Return field-level results
- Integrate with Search API
- Key on fields.
- Index granularly.
- Support search.
- Provide a datasource
