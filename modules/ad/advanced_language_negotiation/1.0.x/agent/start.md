<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Language Negotiation (advanced_language_negotiation) — agent index

Adds one core-style language negotiation method, **"URL (Domain and Path)"** (id
**`language-domain-url`**), that resolves the language from **both** the request **domain** and the
URL **path prefix** at once. Package `Multilingual`. Depends on core **`content_translation`** (which
pulls in the core **Language** module the plugin builds on). Core requirement `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.0-beta3.

- **The negotiation plugin, path processing, switch links, config form and config storage** →
  [plugins/negotiation.md](plugins/negotiation.md)

## What it provides (from source)

- **Language negotiation plugin** `src/Plugin/LanguageNegotiation/AdvancedLanguageNegotiation.php`
  (`#[LanguageNegotiation]` attribute, id `language-domain-url`, weight `-8`, types INTERFACE +
  CONTENT + URL, `config_route_name: advanced_language_negotiation.config`). Extends
  `LanguageNegotiationMethodBase` and implements `InboundPathProcessorInterface`,
  `OutboundPathProcessorInterface`, `LanguageSwitcherInterface`.
- **Config form** `src/Form/AdvancedLanguageNegotiationForm.php` (`ConfigFormBase`) at route
  `advanced_language_negotiation.config`, path
  `/admin/config/regional/language/detection/domain-url`, permission **`administer languages`**.
  Editable config: **`language.negotiation`** (writes the `domain_url` key).
- **Service provider** `src/AdvancedLanguageNegotiationServiceProvider.php` — `alter()` replaces the
  core `redirect_response_subscriber` service class with
  `src/EventSubscriber/RedirectResponseSubscriber.php`, which resolves non-secured redirects through
  the **Domain** module's `DomainRedirectResponse` (allows redirects between registered domains;
  falls back to a 400 for external targets).
- A PHPUnit unit test at `tests/src/Unit/AdvancedLanguageNegotiationTest.php`.

## Routes & permissions

- `advanced_language_negotiation.config` — `_form` for `AdvancedLanguageNegotiationForm`,
  requirement `_permission: 'administer languages'`. This is the only route. No new permissions.

## Mechanism (from source)

- `getLangcode()` reads `language.negotiation:domain_url`, compares the request host (`getHost()`)
  and the leading path segment to each language's configured `domain`/`prefix`, and returns the match
  (else `'en'`).
- `processInbound()` removes a matched language prefix from the path; `processOutbound()` adds the
  prefix and/or rewrites `options['base_url']` to the language domain (preserving port and honoring an
  explicit `https` option), adding `languages:language_url` / `url.site` cache contexts.
- `getLanguageSwitchLinks()` builds one link per native language, cloning the `Url` and carrying the
  parsed current query string.

## Config storage

- Everything is stored in the **core** `language.negotiation` config object under `domain_url`
  (per-langcode `domain` and `prefix`). No config object, install config or schema is shipped by this
  module. Details and an example in [plugins/negotiation.md](plugins/negotiation.md).

## Notes / caveats

- The replaced redirect subscriber references `\Drupal\domain\DomainRedirectResponse`; the **Domain**
  module must be available for that path to resolve.
- `info.yml` declares a `content_translation` dependency; the plugin itself is built on the core
  Language module APIs.
