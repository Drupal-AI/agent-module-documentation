<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emulsify Twig Extensions — agent index

Two Twig functions, nothing else. No config, no routes, no permissions, no schema, no plugins,
no module dependencies. `emulsify_twig.services.yml` registers exactly two `twig.extension`
services.

- **`bem()` — BEM class builder** → [theming/bem.md](theming/bem.md)
- **`add_attributes()` — merge extra attributes into a template** →
  [theming/add-attributes.md](theming/add-attributes.md)

Key facts:

| Service | Class | Provides |
|---|---|---|
| `emulsify_twig.twig.emulsify_twig_bem` | `Drupal\emulsify_twig\BemTwigExtension` | `bem()` |
| `emulsify_twig.twig.emulsify_twig_add_attributes` | `Drupal\emulsify_twig\AddAttributesTwigExtension` | `add_attributes()` |

- Both functions are registered with `needs_context: TRUE` and `is_safe: ['html']`, return a
  `Drupal\Core\Template\Attribute`, and **strip the attributes they consumed out of the Twig
  context** so they do not leak into `{% include %}`d templates.
- `package: Emulsify`, `core_version_requirement: ^10 || ^11`, composer name
  `emulsify-ds/emulsify_twig` (not `drupal/…`).
- Per the project README this 5.0.x branch is the **last supported release**; development
  continues in the separate *Emulsify Tools* module.
- Test a function against a live site without a theme:
  `drush ev '$t=\Drupal::service("twig"); print $t->createTemplate("<h1 {{ bem(\"title\", [\"big\"], \"card\") }}>")->render([]);'`
