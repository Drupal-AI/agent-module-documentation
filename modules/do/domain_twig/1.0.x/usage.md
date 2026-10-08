<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Twig adds a `domain()` Twig function that returns the current active domain entity from the Domain module.

---

Domain Twig is a small developer/theming utility for sites running the `drupal/domain` module. It registers one Twig extension (`DomainTwigExtension`) that exposes a `domain()` function to every template. Calling `domain()` returns the active domain config entity (a `\Drupal\domain\DomainInterface`) resolved by the `domain.negotiator` service, or `NULL` when no domain is active (for example on CLI or an unmatched request). From the returned entity a template can read the domain machine id (`domain().id`), label, hostname, URL, scheme, weight and default/active flags, letting you render domain-specific markup directly in Twig instead of writing a preprocess hook or custom Twig extension. The module ships no configuration UI, no routes, no permissions and no config schema — enabling it (with Domain as a dependency) is all that is required.

---

- Read the current active domain inside any Twig template.
- Get the active domain's machine name with `{{ domain().id }}`.
- Branch template markup on the current domain (`{% if domain().id == 'example' %}`).
- Show the current domain's hostname with `{{ domain().getHostname }}`.
- Print the current domain's human label with `{{ domain().label }}`.
- Output the domain's base URL via `{{ domain().getUrl }}`.
- Read the domain's scheme (http/https) with `{{ domain().getScheme }}`.
- Check whether the current domain is the default one (`{% if domain().isDefault %}`).
- Read the domain's configured weight for ordering logic.
- Swap logos, banners or CSS classes per domain in a template.
- Render domain-specific navigation or footer content.
- Show or hide a promotional block only on a particular domain.
- Set a per-domain body class in `html.html.twig`.
- Guard for a missing domain with `{% if domain() %}` before reading properties.
- Add domain-aware markup in field, node, block or region templates.
- Avoid writing a custom preprocess hook just to expose the active domain.
- Avoid writing a bespoke Twig extension for the same purpose.
- Drive domain-specific analytics snippets or meta tags from a template.
- Display the active domain id for debugging multi-domain theming.
- Build a component library that adapts per active domain.
