<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Daxko — HTTP client, data wrapper & Socrates integration

## The HTTP client (`daxko.client`)

- `Drupal\daxko\DaxkoClient` **extends `GuzzleHttp\Client`** and implements the (empty) marker
  `DaxkoClientInterface`. Built by factory `daxko.client.factory` → `DaxkoClientFactory::get()`
  (arg: `@config.factory`).
- `get()` constructs Guzzle config: `base_uri => base_uri . client_id . '/'`,
  `auth => [user, pass]` (HTTP Basic), `headers => ['Accept' => 'application/json']`. It sets
  **no** `verify` option, so Guzzle's default TLS verification applies.
- `DaxkoClient::__call($method, $args)` is a magic dispatcher. `$args[0]` (an assoc array) is
  turned into a query string via `http_build_query` and appended to a fixed endpoint:
  - `getBranches` → `branches`
  - `getSessions` → `sessions`
  - `getPrograms` → `programs`
  - `getChildCarePrograms` → `childcare/programs`
  - `getMembershipTypes` → `membershiptypes`
  - anything else → throws `DaxkoClientException` ("Method … not implemented yet.").
- `makeRequest($method,$uri,$parameters)` calls Guzzle `request()`, requires HTTP 200, JSON-
  decodes the body, and returns `$object->data` (or `$object->tags` if present), else throws
  `DaxkoClientException`. All exceptions are caught and re-wrapped as `DaxkoClientException`.

## The data wrapper (`daxko.data_wrapper`)

- `Drupal\daxko\DaxkoDataWrapper extends DataWrapperBase implements OpenyDataServiceInterface`.
  Tagged `openy_data_service` (priority 100) in `daxko.services.yml`, so Open Y **Socrates**
  discovers it. Constructor deps (`DataWrapperBase`): renderer, entity_type.manager,
  `daxko.client`, `cache.data`, and three `openy_mappings` repositories
  (`MappingRepository`, `LocationMappingRepository`, `MembershipTypeMappingRepository`),
  logger channel, config.factory.
- `addDataServices()` advertises these Socrates methods: `getBranchPins`,
  `getMembershipPriceMatrix`, `getMembershipTypes`, `getLocations`, `getSummary`,
  `getRedirectUrl`.

### Live path — membership types

- `getMembershipData()`: for each Daxko branch id from
  `locationRepo->getAllDaxkoBranchIds()`, calls
  `daxkoClient->getMembershipTypes(['branch_id' => $branch_id])`; result is cached in the
  `cache.data` bin under `cid = __METHOD__` (no explicit expiry; refresh via cron / by clearing
  the bin). This caches Daxko **membership-type** definitions per branch, not individual member
  records.
- `populateDaxkoMembershipTypes()`: iterates the cached data, **skips** types where
  `showOnline === FALSE`, maps each type name to a canonical label via `getMembershipTypeName()`
  (a hard-coded needle→replace whitelist; unmatched names throw and are logged as an error), and
  then creates or updates Open Y `mapping` entities of type `membership_type`
  (`field_daxko_membership_ids`, `field_branch_ct_reference`, owner uid = `MAPPING_OWNER_ID` = 1).
  Existing mappings are updated in place (IDs only).
- `deleteMembershipTypeMappings()`: `mappingRepo->deleteAllMappingsByType('membership_type')`
  and logs an info message.

### Placeholder / example data (not live Daxko data)

- `getMembershipPriceMatrix()` returns a **hard-coded** youth/adult/family matrix with sample
  locations and prices. `DummyDataWrapper` (a second `DataWrapperBase` subclass, not wired as
  the service) returns the same style of dummy matrix and dummy branch pins — useful for local
  dev.
- `getSummary()` returns `['location'=>NULL,'membership'=>NULL]`; `getRedirectUrl()` returns
  `NULL`. These are stubs.
- `getBranchPins()` (from live Open Y content, not Daxko): queries `node` bundle `branch`,
  renders each in the `membership_teaser` view mode, and builds map pins (icon/tags/lat/lng/
  name/markup) using `openy_map.settings`. `getLocations()`/`getMembershipTypes()` in
  `DataWrapperBase` derive from `branch` nodes and the price matrix.

## Operating it (from README)

```
# Populate / refresh membership-type mappings from Daxko:
drush ev '\Drupal::service("daxko.data_wrapper")->populateDaxkoMembershipTypes();'

# Remove all membership-type mappings:
drush ev '\Drupal::service("daxko.data_wrapper")->deleteMembershipTypeMappings();'
```

There are no routes, controllers, or blocks — the integration is entirely server-side and is
driven by these service calls (typically from cron or Drush). `DaxkoClientException` is the
single custom exception type.
