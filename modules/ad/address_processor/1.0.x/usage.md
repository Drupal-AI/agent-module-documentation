<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Address Processor is a Search API processor that enriches indexed Address data with the full country name, so searches match "Germany" rather than only "DE".

Use it on Search API indexes containing Address fields where end users search by country name.

- Adds a Search API processor plugin for Address fields.
- Maps ISO country codes to human-readable country names at index time.
- Requires the `address` and `search_api` modules.

---

Install and configure:

- Require `drupal/address_processor` (needs `address` and `search_api`).
- Enable `drush en address_processor`.
- Edit your Search API index's Processors tab and enable the address processor.
- Reindex so country names are added to the index.
- Expose the field/processor in your search view or query.

---

- The processor runs during Search API indexing on Address-type fields.
- It resolves the country code to a localized country name.
- Enables keyword search by country name across indexed content.
- No routes, permissions, or admin forms of its own.
- Configuration lives in the Search API index config.
- Reindex after enabling or changing the processor.
- Works with any Search API backend (DB, Solr, etc.).
- Purely an index-time transformation; no runtime request input.
- No security surface (no user-supplied data handling beyond index items).
- Combine with facets for country-based filtering.
- Country names follow the site/interface language where supported.
- Disable and reindex to revert.
- Test by searching a known country name.
- Verify the Address field is included in the index.
- Keep `address`/`search_api` versions compatible.
