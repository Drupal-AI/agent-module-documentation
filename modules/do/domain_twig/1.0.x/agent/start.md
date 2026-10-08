<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Twig (domain_twig) — agent index

A one-class Twig extension that exposes a single `domain()` function to templates, returning the
current active domain entity from the `drupal/domain` module. Lets Twig read the active domain
(id/label/hostname/url) and branch on it without a preprocess hook. Package `Custom`. License
GPL-2.0-or-later. Core `^8 || ^10 || ^11`. Version 1.0.x.

- **The Twig extension, the `domain()` function, its return value, and template examples** →
  [api/twig-extension.md](api/twig-extension.md)

## What it actually is

- One service: `domain_twig.twig_extension` (`domain_twig.services.yml`), class
  `Drupal\domain_twig\TwigExtension\DomainTwigExtension`, tagged `twig.extension`, constructed with
  the `@domain.negotiator` service.
- One Twig function registered in `getFunctions()`: **`domain()`** → `getCurrentDomain()`, which
  returns `$this->domainNegotiator->getActiveDomain()` (a `\Drupal\domain\DomainInterface`, or
  `NULL`).
- **Depends on** `domain` (module machine name `domain`). No routes, no permissions, no config,
  no schema, no Drush, no hooks, no submodules.

## Notes

- `domain()` can return `NULL` (CLI / unmatched request) — templates should guard with
  `{% if domain() %}` before reading properties.
- The function returns an entity object, not a string; no filter/function marks output as safe.
