# Address Processor — manual setup guide

**Address Processor** (`address_processor`) is a small helper for
[Search API](https://www.drupal.org/project/search_api). When you index content
that has an [Address](https://www.drupal.org/project/address) field, Address
Processor adds the **full, human-readable country name** to the index — so a search
for "Germany" matches, not just the raw ISO code "DE".

It works as a Search API **processor plugin**: it runs at index time on
address-type fields, converts each stored country code into a localized country
name, and stores that name in the index alongside the rest of the item. It has no
routes, no permissions, and no admin form of its own — its configuration lives on
your Search API index, in the Processors tab.

Because it only transforms data during indexing, there is nothing for a visitor to
interact with and no security surface. The one operational thing to remember is
that turning it on (or off) requires a reindex before the change takes effect. It
requires the Address and Search API modules and targets Drupal 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module has no settings page of its own; you switch it on inside your Search
API index:

1. Go to **Configuration → Search and metadata → Search API** and edit your index.
2. Open the **Processors** tab.
3. Enable the Address Processor (the country-name processor for Address fields) and
   save.
4. **Reindex** the content so the country names are added to the existing index.
5. Expose the field in your search view or query, optionally pairing it with facets
   for country-based filtering.

To confirm it worked, reindex and then search for a known country name — matching
content should come back. To revert, disable the processor and reindex again.
