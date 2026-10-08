# Configuration

Entity 404 applies a set of checks to entities as they are viewed, and returns the
404 page for any entity that fails a check you have left enabled. The module's
settings let you **turn off checks you don't need**, so you enable only the
behaviour that suits your site.

## The checks

By default the module verifies that:

- **A full view is configured** for the entity — if the entity type/bundle has no
  full view display, the page is treated as not found.
- **The entity is translated, or is untranslatable** — an entity that should have
  a translation but doesn't is treated as not found.

Any check you consider unnecessary can be **disabled in the module settings**, so
that condition is no longer applied.

## Adjust the settings

1. Log in as a user with permission to administer the module (Entity 404 provides
   its own permission — review it under **People → Permissions**,
   `/admin/people/permissions`).
2. Open the Entity 404 settings form (reachable from the module's entry on the
   **Extend** page, or from its section under **Configuration**).
3. Enable or disable each check to match how you want entities to be hidden.
4. Save.

## A note on scope

Remember that these settings only affect the **rendered page response**. Disabling
or enabling a check changes when a visitor sees the 404 page, but it does not
change whether the entity exists or whether it can be reached through other routes,
APIs, or listings. Keep real entity access control in place alongside Entity 404.
