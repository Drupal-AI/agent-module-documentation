<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Twig — the `domain()` Twig function

Source: `src/TwigExtension/DomainTwigExtension.php`, service `domain_twig.twig_extension` in
`domain_twig.services.yml`.

## Install / enable

Requires the `drupal/domain` module (declared in `domain_twig.info.yml` as `domain:domain`).
Enable with `drush en domain_twig -y` (Domain must be present/enabled). Nothing else to configure —
no settings form, no permissions, no config objects.

## The extension class

`DomainTwigExtension extends \Twig\Extension\AbstractExtension`. Constructor takes
`\Drupal\domain\DomainNegotiatorInterface $domain_negotiator` (injected as `@domain.negotiator`)
and stores it in `$this->domainNegotiator`.

`getFunctions()` returns exactly one function:

```php
new TwigFunction('domain', [$this, 'getCurrentDomain']);
```

- Function name in templates: **`domain`** (called as `domain()`).
- **No** `is_safe` flag and **no** `needs_context` / `needs_environment` options — output is
  autoescaped normally and no template context is passed in.
- There are no filters (`getFilters()` is not overridden).

## Return value

`getCurrentDomain()` returns `$this->domainNegotiator->getActiveDomain()`:

- Type: `\Drupal\domain\DomainInterface` (the active domain config entity) **or `NULL`** when no
  domain is active (e.g. CLI, or a request the Domain negotiator did not match).
- It is the domain the current request already resolved to — not an arbitrary or user-supplied
  domain.

Useful accessors on the returned entity (from `Drupal\domain\Entity\Domain` /
`DomainInterface`; properties are protected, so read them through Twig's getter resolution):

| Twig | Method | Returns |
| --- | --- | --- |
| `domain().id` | `id()` | machine name string (e.g. `example_com`) |
| `domain().label` | `label()` | human-readable name |
| `domain().getHostname` | `getHostname()` | hostname (e.g. `example.com`) |
| `domain().getUrl` | `getUrl()` | full base URL |
| `domain().getScheme` | `getScheme()` | `http://` / `https://` |
| `domain().getWeight` | `getWeight()` | integer weight |
| `domain().isDefault` | `isDefault()` | bool — is the default domain |
| `domain().isActive` | `isActive()` | bool — is the active domain |

## Template usage

Branch on the active domain (example mirrors the project page):

```twig
{% set domain_id = domain().id %}
{% if domain_id == 'example' %}
  Cool stuff, huh!
{% endif %}
```

Print domain details (guard against `NULL` first):

```twig
{% if domain() %}
  <p>You are on {{ domain().label }} ({{ domain().getHostname }})</p>
{% endif %}
```

Per-domain body class in `html.html.twig`:

```twig
<body class="domain--{{ domain() ? domain().id : 'none' }}">
```

Because `domain()` returns an entity object rather than markup, printing a scalar accessor such as
`{{ domain().label }}` is autoescaped by Twig like any other value.
