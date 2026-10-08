<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tecla (tecla) — agent index
**Test-only service provider that strips disabled modules' PSR-4 maps from the classloader during PHPUnit.**

- **Version:** 1.0.x (info.yml `1.0.0`)
- **Core:** ^9 || ^10 || ^11
- **Surface:** `TeclaServiceProvider` (ServiceModifierInterface) only — no routes, permissions, config, or services.
- **Behavior:** `alter()` unsets `Drupal\<module>\` PSR-4 prefixes for modules not in `container.modules`; keeps `Drupal\Core\`/`Driver\`/`Component\`.
- **Security:** Test-only; throws `LogicException` unless `drupal_valid_test_ua()` is true, so it cannot run on a live/non-test site. No HTTP surface.
