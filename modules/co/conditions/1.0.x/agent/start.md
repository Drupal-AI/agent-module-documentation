<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conditions (conditions) — agent index

**Reusable form elements, widgets and a service for configuring and evaluating groups of Drupal condition plugins.**

- **Version:** 1.0.x (1.0.0-rc7)
- **Core:** ^10 || ^11
- **Dependency:** plugin_form_element
- **Submodules:** `conditions_field` (a `conditions` field type on json_field + widgets/formatter + `ConditionsFieldService`), `conditions_test`.
- **Elements:** `src/Element/Conditions`, `src/Element/ConditionsGroups`.
- **Service:** `conditions.service` (`ConditionsService`) → `resolveConditionsGroups(array): bool`, `initializeConditions(array &, array $contexts)`.

**Security:** Developer library; no routes/permissions of its own. `ConditionsFieldService` builds JSON_EXTRACT SQL where match values are parameterized (`:key`); column/field names come from field config (not request input) and are `assert()`-guarded — internal-config driven, no user-input SQLi surface. No security findings.

See [api/service-and-elements.md](api/service-and-elements.md).