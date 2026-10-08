<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Tamper — agent index

Exposes every [Tamper](https://www.drupal.org/project/tamper) plugin to [ECA](https://www.drupal.org/project/eca):
- an **ECA action** `eca_tamper:<tamper_id>` (base plugin `eca_tamper`, deriver over the
  Tamper manager), e.g. `eca_tamper:trim`, `eca_tamper:find_replace`, `eca_tamper:encode`;
- an **ECA condition** `eca_tamper_condition:<tamper_id>` for Tamper plugins whose category
  is Text / Date-time / Number / Other.

No admin UI, no configure route, no permissions, no Drush. You use it inside ECA models.
Depends on `eca` and `tamper`.

- **The derived actions & conditions, their config keys, and how to reference them in an ECA
  model** → [plugins/actions-and-conditions.md](plugins/actions-and-conditions.md)

Key facts:
- **Action** adds `eca_data` (value to tamper, token-aware) + `eca_token_name` (token that
  receives the result), plus the wrapped Tamper plugin's own settings. Result is written to
  the ECA token `eca_token_name`.
- **Condition** extends ECA `StringComparisonBase`: it tampers `left` and compares to
  `right` with an ECA operator/type; also has `case`/`negate`.
- Derivative id = `eca_tamper:` (or `eca_tamper_condition:`) + the Tamper plugin id; the
  original Tamper id is kept in the plugin definition's `original_id`.
- Tamper plugins needing item context (`itemUsage === 'required'`) are **not** derived.
