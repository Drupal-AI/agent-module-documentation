<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Extender is a toolbox of extra Views plugins: a filter that compares an entity field against a token- (or ECA-) resolved value, a "current date/time" default argument, and two taxonomy-term argument validators (by field-as-id and by path alias). An optional submodule `views_extender_eca` wires the comparison into the ECA (Events-Conditions-Actions) engine.

---

The problem it solves is expressing dynamic, context-driven view constraints that core Views cannot: the `entity_field_compare` filter (`src/Plugin/views/filter/EntityFieldCompare.php`) takes an admin-configured value, runs it through Drupal's token service against contextual data, and adds it to the query — using `addWhereExpression` with a **bound placeholder** for equality and `Connection::escapeLike()` for LIKE/NOT-LIKE operators, so values are parameterized rather than concatenated. The `CurrentDateTime` default argument injects "now" as a contextual filter value. `TermFieldAsId` and `TermAlias` argument validators resolve a taxonomy argument from a term field value or a path alias respectively (`TermAlias` loads the `path_alias` matching the argument, extracts `/taxonomy/term/{id}`, and validates the term).

Operational/security notes: everything here is Views configuration authored by users with the "administer views" permission — there are no routes, permissions, or public endpoints of its own. The comparison filter's value is admin-configured and passed through tokens, and the query builders use placeholder binding / `escapeLike()`, so there is no raw SQL concatenation of user input. The ECA submodule additionally requires `eca:eca ^2` and dispatches a `ViewsExtenderEvent` so ECA models can supply comparison values and read/write a small in-memory state. Typical setup: enable the module, add the `entity_field_compare` filter or one of the argument validators to a View, and configure the token value or term-resolution behavior.
---
- Filter a view by comparing an entity field to a token-resolved value.
- Use `[current-user:uid]` or similar tokens as a filter value.
- Compare a field with equals, contains (LIKE), or not-like operators.
- Default a contextual filter to the current date/time.
- Validate a taxonomy argument by matching a term field value.
- Validate a taxonomy argument by its URL path alias.
- Drive comparison values from an ECA model via the ECA submodule.
- Read and write a small ECA memory state during view building.
- Dispatch a `views_extender_entity_field_compare` event for ECA.
- Build user-context-aware listings without custom code.
- Restrict a listing to rows whose field matches the current route context.
- Add a "term alias" argument validator to a taxonomy-driven view.
- Reuse the current-datetime default across multiple displays.
- Combine token comparison with exposed filters for hybrid filtering.
- Enforce parameterized queries when comparing fields (no SQL injection).
- Extend arguments with ECA-provided defaults via `ArgumentDefaultEca`.
- Validate arguments with ECA logic via `ArgumentValidatorEca`.
- Compare entity fields using ECA conditions via `EntityFieldCompareEca`.
- Filter content per the viewing user's stored preferences.
