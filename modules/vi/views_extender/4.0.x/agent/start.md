<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Extender (views_extender) — agent index

**Extra Views filter and argument plugins: token/ECA entity-field comparison, current-datetime default, and taxonomy term-alias/field-as-id validators.**

- **Version:** 4.0.x (4.0.0)
- **Core:** ^10.3 || ^11
- **Dependencies:** drupal:views (ECA submodule also requires `eca:eca ^2`)
- **Filter:** `entity_field_compare` (`EntityFieldCompare`) — token-resolved, placeholder-bound / `escapeLike()`
- **Argument default:** `CurrentDateTime`
- **Argument validators:** `TermFieldAsId`, `TermAlias` (id `taxonomy_term_alias`)
- **Submodule:** `views_extender_eca` — ECA event `ViewsExtenderEvent`, memory-state read/write actions, ECA views plugins

**Security:** No routes, permissions, or public endpoints — pure Views configuration (requires "administer views"). The comparison filter parameterizes values via `addWhereExpression` placeholders and `Connection::escapeLike()`; no raw SQL concatenation of user input. No security findings.

See [plugins/plugins.md](plugins/plugins.md).
