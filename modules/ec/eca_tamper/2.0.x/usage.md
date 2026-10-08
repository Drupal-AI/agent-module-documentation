<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Tamper exposes every Tamper plugin as an ECA action and (where applicable) as an ECA condition, so ECA models can transform string/data values with Tamper's library without custom code.

---

The module is a thin integration between [ECA](https://www.drupal.org/project/eca) and [Tamper](https://www.drupal.org/project/tamper). It defines two derivers that iterate the Tamper plugin manager's definitions and mint one plugin per Tamper plugin: an **action** `eca_tamper:<tamper_id>` (base plugin `eca_tamper`, e.g. `eca_tamper:trim`, `eca_tamper:find_replace`) and, for Tamper plugins in the Text/Date-time/Number/Other categories, an **ECA condition** `eca_tamper_condition:<tamper_id>`. Actions add two config keys of their own — `eca_data` (the value to tamper, token-aware) and `eca_token_name` (the token the tampered result is written to) — on top of the wrapped Tamper plugin's own settings; at runtime the shared `TamperTrait::doTamper()` token-replaces the config, runs `TamperInterface::tamper()`, and stores the result via the ECA token service. Conditions extend ECA's `StringComparisonBase`: they tamper `left` and compare it against `right` using ECA's comparison operators. Tamper plugins that require item context (`itemUsage === 'required'`) are skipped. The module also implements `hook_config_schema_info_alter()` to graft each Tamper plugin's config schema onto the derived action/condition config, and marks free-text form fields with `#eca_token_replacement` so ECA's UI offers token input. It has no admin UI, no configure route, no permissions, and no Drush commands of its own — you use it entirely from within ECA models.

---

- Trim whitespace from a token value inside an ECA model with the `eca_tamper:trim` action.
- Find-and-replace text in a value during an ECA workflow (`eca_tamper:find_replace`).
- Apply a regular-expression find/replace to data mid-model (`eca_tamper:find_replace_regex`).
- Convert a string's case (upper/lower/title) as an ECA action before saving a field.
- Base64/JSON/serialize encode or decode a value with `eca_tamper:encode` in a model.
- Explode a delimited string into an array token for later ECA processing.
- Implode an array token back into a delimited string.
- Cast a value to integer/boolean with a Tamper plugin as an ECA action.
- Offset or reformat a date/time value using a Tamper date plugin inside ECA.
- Provide a default value when a token is empty via the Tamper default_value plugin.
- Sanitize user-submitted text in an ECA-driven form workflow before persisting it.
- Normalize imported/migrated data on the fly within an ECA model.
- Store a transformed result under a named token (`eca_token_name`) for downstream actions.
- Chain several `eca_tamper:*` actions to build a small transformation pipeline in one model.
- Use an `eca_tamper_condition:*` to branch a model on whether a *tampered* value equals another.
- Gate a workflow on a case-insensitive comparison of a cleaned-up string.
- Compare a trimmed/normalized token against an expected value to decide a gateway path.
- Feed token values (`[node:title]`, etc.) into a Tamper transformation via `eca_data`.
- Convert a country name to its ISO code inside a model with a Tamper plugin (if installed).
- Keep transformation logic declarative in an ECA/BPMN model instead of writing a custom action.
- Reuse any custom Tamper plugin you have written automatically as an ECA action, no glue code.
- Truncate, pad, or sprintf-format a string within an ECA model using the matching Tamper plugin.
- Strip tags / sanitize HTML from a value as part of an automated content workflow.
- Build reusable data-cleaning steps shared between Feeds (Tamper) and ECA (this module).
- Transform a value and immediately compare the result, all inside one ECA model, no PHP.
