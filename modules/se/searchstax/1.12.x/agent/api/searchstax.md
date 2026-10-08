<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SearchStax services (programmatic API)

Two public services (`searchstax.services.yml`). Both talk to a live SearchStax account or a
SearchStax Solr server, so calls only succeed with a subscription + network access.

## `searchstax.api` — SearchStax account/app API client

Service id `searchstax.api`, interface `Drupal\searchstax\Service\ApiInterface`
(`src/Service/Api.php`). Wraps the SearchStax REST API; keeps a short-lived auth token in
expirable key-value + cache. Selected methods:

- `login(string $username, string $password, ?string $tfa_token = NULL): void` — obtain a token.
- `isLoggedIn(): bool`
- `getAccounts(): array` / `getApps(string $account): array` / `getApp(string $account, int $app_id): array`
- `getAvailableLanguages(...)` / `setLanguages(...)`
- `setStopwords(...)`, `setSynonyms(...)`, `setSorts(...)`, `setResultFields(...)`,
  `setSearchedFields(...)`, `enableSortSelect(...)`
- `getRelevanceModels(...)`, `getOrCreateDefaultRelevanceModel(...)`, `publishRelevanceModel(...)`
- `checkDrupalVersionCompatibility(string $account, int $app_id, int $major_version): array`
- `upgradeForDrupalVersionCompatibility(...)`
- `publishStopwordsSynonymsAndResultSettings(...)`, `clearCache(): void`

```php
$api = \Drupal::service('searchstax.api');
$api->login($user, $pass);
$accounts = $api->getAccounts();
```

## `searchstax.utility` — tracking & Solr query service

Service id `searchstax.utility`, interface
`Drupal\searchstax\Service\SearchStaxServiceInterface` (`src/Service/SearchStax.php`). This is
the front-end/query-time helper: it injects the SearchStudio tracking JS into result builds,
decides who is tracked, and detects/annotates SearchStax Solr servers. Selected methods:

- `isSearchStaxSolrServer(ServerInterface $server): bool` — is this Search API server a SearchStax one?
- `isSearchstaxSolr(array $config): bool` — same check from a raw connector config array.
- `isTrackingDisabled(?RefinableCacheableDependencyInterface $cache = NULL): bool` — respects
  `untracked_roles` + EU Cookie Compliance.
- `addTracking(ResultSet $result_set, array &$build = [], ?string $keys = NULL): bool` — attach the tracker.
- `alterSolrQuery(...)`, `postCreateSolariumResult(...)`, `getSearchLanguage(QueryInterface $query)`,
  `getQueryKeys(QueryInterface $query)`.
- `getAutosuggestCore(ServerInterface $server): ?string` / `getAutosuggestEndpoint(...)` — auto-suggest wiring.

```php
$util = \Drupal::service('searchstax.utility');
if ($util->isSearchStaxSolrServer($server)) { /* … */ }
```

Also present: `searchstax.migrate_to_keys` (moves plaintext credentials into Key entities) and
`searchstax.flood_subscriber` (enforces the `flood_protection.*` settings). These are internal
event subscribers / helpers rather than an intended public API.
