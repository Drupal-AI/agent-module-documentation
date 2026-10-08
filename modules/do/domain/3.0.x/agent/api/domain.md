<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain API (services & entity)

## Negotiation — `domain.negotiator` (`DomainNegotiatorInterface`)

Resolves the **active domain** for the current request by matching the HTTP host.

```php
$negotiator = \Drupal::service('domain.negotiator');   // Drupal\domain\DomainNegotiatorInterface
$active = $negotiator->getActiveDomain();              // DomainInterface|NULL
$id     = $negotiator->getActiveId();                  // machine id string
```

Match-type constants: `DOMAIN_MATCHED_NONE = 0`, `DOMAIN_MATCHED_EXACT = 1`,
`DOMAIN_MATCHED_ALIAS = 2` (aliases come from the `domain_alias` submodule).
Other useful methods: `setRequestDomain($hostname)`, `setActiveDomain($domain)`,
`negotiateActiveHostname()`, `getHttpHost()`.

## Storage — `getStorage('domain')` (`DomainStorageInterface`)

```php
$storage = \Drupal::entityTypeManager()->getStorage('domain');
$default = $storage->loadDefaultDomain();              // DomainInterface|NULL
$id      = $storage->loadDefaultId();
$byHost  = $storage->loadByHostname('example.com');    // DomainInterface|FALSE
$sorted  = $storage->loadMultipleSorted();             // by weight
$options = $storage->loadOptionsList();                // [id => name] for form #options
$machine = $storage->createMachineName('example.com'); // 'example_com'
```

`create()` auto-fills `hostname` (current host) and `domain_id` when omitted.

## The domain entity — `DomainInterface`

State: `isActive()`, `isDefault()`, `isHttps()`, `getMatchType()`.
Identity/URL: `getHostname()` / `setHostname()`, `getDomainId()`, `getScheme()`,
`getPath()`, `getUrl()`, `getLink()`, `getPathPrefix()` / `setPathPrefix()`.
Mutation helpers: `saveDefault()` (make this the default), `saveProperty($name, $value)`
(save one field), `addProperty()` (attach transient data), `getRedirect()` / `setRedirect($code)`.

## Tokens — `domain.token`

Domain registers tokens for the **current** and **default** domain (id, name, hostname,
url, path). Use them in any tokenized text; programmatically call
`\Drupal::token()->replace('[domain:current:url]', [])`.

## Cache context — `@domain`

Add `'contexts' => ['url.site']` is core; Domain adds a `domain` cache context so render
arrays / responses can vary per active domain. Tag renderables with `['#cache' =>
['contexts' => ['domain']]]`.
