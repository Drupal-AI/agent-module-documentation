Daxko is a thin server-side integration that lets an Open Y (YMCA Website Services) site pull branch, program, session and membership-type data from the Daxko operations API and expose it to the site through the Open Y "Socrates" data-service layer.

---

The module wraps the Daxko REST API in a Guzzle-based client (`DaxkoClient`) built by a factory from the `daxko.settings` config (base URI, account/client id, and HTTP Basic-auth username/password). A single admin form at `/admin/openy/integrations/daxko/daxko` ("administer daxko" permission) stores those credentials. The `DaxkoDataWrapper` service is tagged as an `openy_data_service` and registered with Open Y Socrates, so other Open Y components can request membership price matrices, membership types, branch pins and locations through Socrates rather than calling Daxko directly. Its main real job is `populateDaxkoMembershipTypes()`, which reads Daxko membership types per branch, matches each type name against a built-in whitelist, and creates or updates Open Y `mapping` entities (`membership_type`) that link human membership names to their Daxko membership-type IDs. Note that the price-matrix and branch-pin data returned by `DaxkoDataWrapper`/`DummyDataWrapper` is hard-coded placeholder/example data — this is an "initial" integration scaffold, not a full member-facing product. It has no member-facing routes, no blocks, and no controllers; everything runs server-side under cron or Drush.

---

- Connect an Open Y / YMCA Website Services site to the Daxko operations API.
- Store Daxko API credentials (client id, base URI, Basic-auth user/password) via one admin settings form.
- Provide a reusable Guzzle client (`daxko.client`) for calling Daxko REST endpoints.
- Fetch the list of Daxko branches (`getBranches`).
- Fetch Daxko program sessions (`getSessions`).
- Fetch Daxko programs (`getPrograms`).
- Fetch Daxko child-care programs (`getChildCarePrograms`).
- Fetch Daxko membership types per branch (`getMembershipTypes`).
- Register a Daxko data wrapper as an Open Y Socrates `openy_data_service`.
- Populate Open Y `membership_type` mapping entities from live Daxko membership types.
- Update existing membership-type mappings with current Daxko membership IDs.
- Delete all membership-type mappings to reset the cached mapping data.
- Cache fetched membership data in the `cache.data` bin for reuse (e.g. from cron).
- Skip membership types that Daxko flags as not shown online (`showOnline === FALSE`).
- Normalise Daxko membership-type names to canonical labels via a built-in name map.
- Expose a membership price matrix to Open Y through Socrates (`getMembershipPriceMatrix`).
- Expose membership types and locations to Open Y (`getMembershipTypes`, `getLocations`).
- Build map "branch pins" from Open Y `branch` nodes for the Open Y map (`getBranchPins`).
- Run membership-type population from Drush: `drush ev '\Drupal::service("daxko.data_wrapper")->populateDaxkoMembershipTypes();'`.
- Reset membership mappings from Drush: `drush ev '\Drupal::service("daxko.data_wrapper")->deleteMembershipTypeMappings();'`.
- Restrict who can configure the integration with the "administer daxko" permission.
- Serve as the starting scaffold for a fuller custom Daxko membership integration.
- Swap in `DummyDataWrapper` for local development when no Daxko account is available.
