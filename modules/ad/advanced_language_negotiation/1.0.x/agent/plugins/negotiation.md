<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "URL (Domain and Path)" negotiation method

## Install & enable

```bash
composer require drupal/advanced_language_negotiation
drush en advanced_language_negotiation -y
drush cr
```

`info.yml` depends on core **`content_translation`** (and thus the core **Language** module). Then go
to **Administration → Configuration → Regional and language → Languages → Detection and selection**
(`/admin/config/regional/language/detection`), enable **URL (Domain and Path)** for the language types
you want, and order it in the negotiation stack. There are **no module-specific permissions**; the
config form uses core **`administer languages`**.

## The plugin

`src/Plugin/LanguageNegotiation/AdvancedLanguageNegotiation.php`

```php
#[LanguageNegotiation(
  id: 'language-domain-url',            // METHOD_ID
  name: 'URL (Domain and Path)',
  types: [INTERFACE, CONTENT, URL],
  weight: -8,
  config_route_name: 'advanced_language_negotiation.config',
)]
```

Extends `LanguageNegotiationMethodBase` and implements `InboundPathProcessorInterface`,
`OutboundPathProcessorInterface`, `LanguageSwitcherInterface`.

### `getLangcode(?Request $request)`

- Loads `this->config->get('language.negotiation')->get('domain_url')`.
- Takes the leading path segment (`urldecode(trim(getPathInfo(),'/'))`, first `/`-part) as the
  candidate `$prefix` and the request host (`$request->getHost()`) as `$http_host`.
- Iterates `languageManager->getLanguages()`; for each language whose config `domain` normalizes
  (via `parse_url('http://'.stripped_scheme, PHP_URL_HOST)`) to the request host: if that language
  also has a `prefix`, it matches only when the prefix equals the leading segment; if it has no
  prefix, the domain match alone selects it. Returns the matched langcode, else `'en'`.

### `processInbound($path, $request)`

Strips a matched language prefix: if the request host equals a language's configured domain and that
language's non-empty `prefix` equals the leading path segment, it rebuilds `$path` without that
segment so internal routing matches the unprefixed path.

### `processOutbound($path, &$options, ?$request, ?$bubbleable_metadata)`

- Determines the target language (from `$options['language']` or the current URL language); returns
  early for languages not in the enabled set.
- If the language has a `prefix`, sets `$options['prefix'] = prefix.'/'` and adds cache context
  `languages:language_url`.
- If the language has a `domain`, requests an absolute URL and sets
  `$options['base_url'] = scheme.'://'.domain`, retaining a port from the original base URL or a
  non-standard request port, honoring an explicit `$options['https']` boolean, and appending Drupal's
  subfolder from `base_path()`. Adds cache contexts `languages:language_url` and `url.site`.

### `getLanguageSwitchLinks($request, $type, Url $url)`

Builds one link per `getNativeLanguages()`: a **cloned** `Url` (so per-link options do not leak),
the language's native name as title, class `language-link`, and the current query (parsed from
`$request->getQueryString()` via `parse_str`). Links are returned as a render-array structure that
Drupal renders through the standard link/Url pipeline.

## Configuration form & storage

`src/Form/AdvancedLanguageNegotiationForm.php` (`ConfigFormBase`, form id
`language_negotiation_configure_url_form`), route **`advanced_language_negotiation.config`**, path
`/admin/config/regional/language/detection/domain-url`, permission **`administer languages`**.

- `buildForm()` renders, per enabled language, a **domain** textfield (maxlength 128) and a **prefix**
  textfield (maxlength 10, `/` field-prefix), defaulting from `language.negotiation:domain_url`.
- `validateForm()` rejects a prefix containing `/`, requires a non-empty domain per language, and
  verifies the domain is a bare host (`parse_url('http://'.host, PHP_URL_HOST)` must equal the input,
  i.e. no scheme/port/trailing slash).
- `submitForm()` saves `domain_url` into the **core** config object **`language.negotiation`**
  (`getEditableConfigNames()` returns `['language.negotiation']`).

Stored shape:

```yaml
# language.negotiation
domain_url:
  en:
    domain: 'example.com'
    prefix: ''
  de:
    domain: 'example.de'
    prefix: ''
  en-de:
    domain: 'example.de'
    prefix: 'en'
```

The module ships **no** `config/install` or `config/schema` of its own; it writes into core's
existing config object.

## Redirect subscriber swap

`src/AdvancedLanguageNegotiationServiceProvider::alter()` sets the class of the core
`redirect_response_subscriber` service to
`src/EventSubscriber/RedirectResponseSubscriber.php`. That subclass mirrors core's
`checkRedirectUrl()` but, for a redirect that is not already a `SecuredRedirectResponse`, wraps it in
the **Domain** module's `DomainRedirectResponse` (so redirects to other **registered** domains are
permitted); a target that resolves to no registered/local site yields a **400** response. The Domain
module must be present for this class to load.

## Operating notes

- Enable the method per language type on the Detection and selection page; weight `-8` places it high
  in the stack by default.
- Each language needs a valid bare domain; the prefix is optional and is what distinguishes multiple
  languages sharing one domain.
- `getLangcode()` defaults to `'en'` when nothing matches — set that language up as the sensible
  fallback, or rely on lower-weighted core methods in the stack.
