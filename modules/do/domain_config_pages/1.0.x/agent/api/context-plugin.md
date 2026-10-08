# Domain context plugin (API)

The module's entire runtime surface is one plugin plus one schema alter. Both are consumed by
`config_pages`; this module registers nothing else in the container.

## The plugin — `domain`

`Drupal\domain_config_pages\Plugin\ConfigPagesContext\Domain` (`src/Plugin/ConfigPagesContext/Domain.php`)
extends `Drupal\config_pages\ConfigPagesContextBase` and is discovered by config_pages' manager
`plugin.manager.config_pages_context` from the `Plugin/ConfigPagesContext` namespace. It is declared
with the **annotation** form only:

```php
/**
 * @ConfigPagesContext(
 *   id = "domain",
 *   label = @Translation("Domain"),
 * )
 */
class Domain extends ConfigPagesContextBase { … }
```

(config_pages' own `Language` plugin uses the newer PHP `#[ConfigPagesContext(...)]` attribute; the
manager registers both discovery mechanisms, so this annotation-only plugin still resolves.)

Dependencies are injected via `create()`: `domain.negotiator`
(`\Drupal\domain\DomainNegotiatorInterface`) and `entity_type.manager`.

## Methods (contract: `Drupal\config_pages\ConfigPagesContextInterface`)

| Method | Returns | Implementation |
|---|---|---|
| `getValue(): string` | the discriminator | `$this->domainNegotiator->getActiveId()` — the active domain's id. This is the string config_pages keys per-domain value sets on. |
| `getLabel(): string` | human label | `$this->domainNegotiator->getActiveDomain()->label()` |
| `getLinks(): array` | switch links | loads every `domain` entity via `entity_type.manager` and returns one `['title' => label, 'href' => Url::fromUri($domain->getUrl()), 'selected' => bool, 'value' => $domain->id()]` per domain. Used by config_pages to render the context switcher in its admin UI. |

`getValue()` is the important one: config_pages calls it while loading/saving a Config Pages entity
whose type has the `domain` context enabled, and uses the returned id to select the correct stored
value set. There is no request parameter that overrides it — the id comes from Domain's negotiator
(hostname/active-domain resolution), not from user input.

## Schema alter — `domain_config_pages_config_schema_info_alter()`

`domain_config_pages.module` adds the fallback key so a Config Pages type can persist a chosen
fallback domain:

```php
$definitions['config_pages.type.*']['mapping']['context']['mapping']['fallback']['mapping']['domain'] = [
  'type' => 'string',
  'label' => 'Domain',
];
```

Effect: on a `config_pages.type.*` config object, `context.fallback.domain` is a valid, typed string —
this is what the type form writes when you pick a default/fallback domain (see
[../configure/domain-context.md](../configure/domain-context.md)).

## Reusing it from PHP

To read the current discriminator yourself:

```php
$manager = \Drupal::service('plugin.manager.config_pages_context');
$domain_context = $manager->createInstance('domain');
$active_domain_id = $domain_context->getValue();   // e.g. "example_com"
```

To add a different discriminator, write your own `ConfigPagesContext` plugin in
`Plugin/ConfigPagesContext/` returning your own `getValue()` — this module is the minimal reference
implementation for that pattern.
