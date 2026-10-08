<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring & operating csp_google

## Install & enable

```bash
composer require drupal/csp_google
drush en csp_google -y
```

Requires the **CSP** module (`drupal/csp`, `^1.31 || ^2.0`; Drupal module `csp`). No submodules,
no permissions, no Drush commands, no config-install objects. On enable, `hook_install()`
(`csp_google.install`) calls `csp_google.helper`'s `updateSupportedDomains()` once to prime the
domain cache; if the site cannot reach `https://www.google.com/supported_domains` at that moment
it throws `\RuntimeException` (the list is otherwise fetched lazily on first use).

## Where you configure it

There is **no dedicated settings route**. The module alters the CSP module's own settings form
(`csp_settings`, at CSP's `/admin/config/system/csp`). `csp_google_form_csp_settings_alter()`
adds a checkbox **"Add Google supported domains"** to each directive that has a *sources* option,
under both the **report-only** and **enforce** policies. Description links to
`GoogleSupportedDomainsHelper::URL`.

Turn the checkbox on for the specific directives (e.g. `script-src`, `img-src`, `frame-src`,
`connect-src`) that must allow localized Google hosts, then save the CSP settings form.

## Config storage & schema

Flags are stored inside the **CSP** config object `csp.settings`, not a config object of this
module. `csp_google_form_csp_settings_form_submit()` writes, per policy type (`report-only`,
`enforce`) and per directive, the key `csp_google_add_google_domain_sources` (bool). Policies
whose `enable === FALSE` are skipped.

`hook_config_schema_info_alter()` (in `csp_google.module`) registers the schema for that key by
adding to the existing `csp_policy` mapping:

```php
$definitions['csp_policy']['mapping']['csp_google_add_google_domain_sources'] = [
  'type' => 'boolean',
  'label' => 'Add Google domains to sources',
];
```

So the module ships **no** `config/schema/*.yml` file of its own — it extends CSP's schema.

## How domains are added to the header

`Drupal\csp_google\EventSubscriber\CspPolicy` (service `csp_google.csp_policy_subscriber`)
subscribes to `CspEvents::POLICY_ALTER`. `onCspPolicyAlter(PolicyAlterEvent $alterEvent)`:

1. Reads `report-only` vs `enforce` from `csp.settings` via `$policy->isReportOnly()`.
2. For each directive on the policy whose stored config is an array with a truthy
   `csp_google_add_google_domain_sources`, it lazily loads the cached domain list
   (`getSupportedDomains()`, memoized in a `static`).
3. For each domain it appends `*.<domain>` and `<domain>` to the directive (skipping entries
   already present), then `$policy->setDirective($key, $directive)`.

This runs while CSP builds the response header, so no outbound HTTP happens at request time —
the domains come from cached state.

## The domain cache (state)

`Drupal\csp_google\GoogleSupportedDomainsHelper` (service `csp_google.helper`,
args `@state`, `@http_client`):

- `const URL = 'https://www.google.com/supported_domains'`
- `const STATE_KEY = 'csp_google_supported_domains'`
- `updateSupportedDomains()` — GETs `URL` with the core Guzzle `http_client` (default TLS
  verification), reads the body, throws `\RuntimeException` on non-200 or empty body, splits on
  `"\n"`, trims each line of whitespace and leading/trailing dots, drops empties, and
  `state->set(STATE_KEY, $domains)`. Throws again if the parsed list is empty.
- `getSupportedDomains()` — returns the state array; if it is not an array, calls
  `updateSupportedDomains()` and returns the refreshed value (throws if still not an array).

### Refreshing the list

There is no scheduled refresh. To pull Google's current list again, clear the state key so the
next CSP build re-fetches lazily:

```bash
drush php:eval "\Drupal::state()->delete('csp_google_supported_domains');"
```

or re-run the install hook logic:

```bash
drush php:eval "\Drupal::service('csp_google.helper')->updateSupportedDomains();"
```

`hook_uninstall()` deletes the state key on uninstall.

## Operational caveats

- **Header size**: enabling the option on many directives adds a long domain list to the
  `Content-Security-Policy` header; if it exceeds your reverse proxy / CDN header limit you can
  get a 502. Enable it only on the directives that truly need Google ccTLD hosts. (README cites
  core issues 2844620 and 2954339.)
- Only Google features that load from country-code domains (mostly ad-related) need this; basic
  Analytics does not.
- If the site cannot reach Google at install time the install throws; ensure outbound HTTPS to
  `www.google.com` is available, or the list will fetch lazily on first policy build.
