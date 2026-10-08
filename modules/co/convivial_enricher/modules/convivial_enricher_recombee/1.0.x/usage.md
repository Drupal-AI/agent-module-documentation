Adds a `recombee_user_merge` Enricher datasource that merges a visitor's anonymous Recombee user into their identified user id when they are recognised via the enricher token.

---

This submodule of Convivial Enricher registers the `recombee_user_merge` EnricherDatasource plugin (`RecombeeEnricherDatasource`). It is configured per enricher with a Recombee database id ("API Identifier"), a Recombee private token, the Recombee cookie name (default `RecombeeUserId`), and a client-id prefix (default `ac_`). At request time it reads the current Recombee user id from the browser cookie, computes the target user id as `prefix + token`, and — when the two differ and the cookie user is not already prefixed — sends a `MergeUsers(target, source, cascadeCreate: true)` request through the Recombee PHP SDK, consolidating the anonymous interaction history into the identified user. On success it writes a `convivial_enricher_ConvivialEnricherClientId` cookie (1 year) holding the target user id. Recombee API errors are logged, not surfaced. Requires the parent `convivial_enricher` module and the contrib Recombee module (which provides the SDK and the Recombee cookie).

---

- Merge an anonymous visitor's Recombee recommendation history into their identified user id.
- Recognise the identified user from the enricher token (e.g. an email-campaign identifier).
- Read the current Recombee user id from the configurable Recombee cookie (default `RecombeeUserId`).
- Prefix the identified user id (default `ac_`) to build the Recombee target user id.
- Skip merging when the cookie user is already the prefixed/identified user (idempotent).
- Preserve pre-identification browsing/recommendation signals across the login boundary.
- Write the resolved client id back as a long-lived (1 year) cookie for downstream tooling.
- Auto-create the target Recombee user on merge via `cascadeCreate`.
- Point the datasource at any Recombee database via its id and private token.
- Improve personalised recommendations by unifying anonymous and known user profiles.
- Combine Recombee user-merge with other enricher datasources on the same endpoint.
- Diagnose merge failures from the site's recent log messages (Recombee API errors are logged).
- Feed the unified Recombee user id into recommendation blocks/personalisation.
