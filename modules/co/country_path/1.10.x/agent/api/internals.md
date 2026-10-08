# Country Path internals

How the module hooks into Domain and routing. Useful when debugging why a country is (not) detected or a
link is (not) prefixed.

## Active-domain detection — `country_path_domain_request_alter(DomainInterface &$domain)`

In `country_path.module`. On each request it reads the path (`\Drupal::request()->getPathInfo()`, or
`$_SERVER['REQUEST_URI']` when called before the request service exists), takes segment 1 as
`$path_prefix`, then:

1. If the prefix is empty → load the default domain for the hostname (`country_path_set_default_domain`).
2. If `domain_alias` exists → try `loadByHostname("$hostname/$path_prefix")`, then `loadByHostname($hostname)`;
   on a hit set match type `DOMAIN_MATCHED_ALIAS` and apply any alias redirect.
3. Otherwise load all domains with `hostname == $hostname` and pick the one whose
   `country_path.domain_path` third-party setting equals `$path_prefix`.
4. No match → default domain.

`getActiveDomain()` (in `CountryPathTrait`) memoises the negotiated domain and forces a re-negotiation if
empty, mirroring Domain's own source path processor.

## Path rewriting — `src/HttpKernel/CountryPathProcessor.php`

Registered (`country_path.services.yml`) as `path_processor_inbound` (priority **400**) and
`path_processor_outbound` (priority **10**).

- `processInbound()`: if the active domain has a `domain_path`, strips a leading `/<prefix>` from the path
  (`preg_match`/`preg_replace`, case-insensitive) so routing sees the clean internal path.
- `processOutbound()`: prepends `"<prefix>/"` to `$options['prefix']` (so the country segment leads,
  before e.g. the language segment) and adds the `url.country` cache context. Skips external URLs.

## Cache context — `url.country`

`src/Cache/Context/CountryPathCacheContext.php` (service `cache_context.url.country`). `getContext()`
returns the active domain id (or `'0'`), so render caches vary per country.

## Language negotiation plugin

`src/Plugin/LanguageNegotiation/LanguageNegotiationCountryPathUrl.php` (`METHOD_ID =
'country-path-language-url'`) extends core `LanguageNegotiationUrl`. `getLangcode()` supports both the
`path_prefix` source (checks segment 1 and segment 2 so a language prefix can sit after the country
prefix) and the `domain` source (matches `$request->getHost()` to a per-language domain). `weight = -8`,
`config_route_name = language.negotiation_url`.

## Service / entity overrides

- `country_path_entity_type_build/alter()` swap the Domain entity class to `CountryPathDomain`
  (relaxed unique-hostname `preSave`), the domain + domain_alias form handlers, and the domain list builder.
- `CountryPathServiceProvider::alter()` replaces the `domain_alias.validator` service with
  `CountryPathDomainAliasValidator` (so `host/prefix` alias patterns validate).
- `country_path_module_implements_alter()` / `country_path_language_types_info_alter()` order this module
  after core `language` so its negotiator is discovered (e.g. by Simple Sitemap's multilingual check).

## Extending it

Only Domain's own hooks apply; this module invites no hooks of its own (no `*.api.php`). To add ranges of
logic, decorate the `country_path.path_processor` service or implement Domain/language hooks.
