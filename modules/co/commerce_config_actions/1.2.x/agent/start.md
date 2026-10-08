<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Config Actions (commerce_config_actions) — agent index

Extra **[config actions](https://www.drupal.org/docs/extending-drupal/config-actions)** for
building **Drupal Commerce** sites from **recipes**. Each action is a core `#[ConfigAction]`
plugin (under `src/Plugin/ConfigAction`) that a recipe (or a `config:actions` block, or
programmatic config-action apply) invokes while configuration is imported. All are marked
`@internal` / experimental. There is **no runtime surface** — no routes, forms, controllers,
services, hooks, permissions, or config schema of its own. Package `Commerce (Contrib)`.
Core `^11`. License GPL-2.0-or-later. Installed as **1.2.0** (version dir `1.2.x`).

## Dependencies

- Drupal module: **`commerce:commerce_price`** (`.info.yml`); Composer requires
  `drupal/commerce ^2.40 || ^3` and `drupal/core ^11` (`composer.json`).
- Several actions additionally use Commerce's entity-trait manager and Commerce Price's
  currency importer (available whenever Commerce is installed).

## What it provides (from source)

Nine config-action plugins, each declared with the `#[ConfigAction]` attribute:

- **`enableCommerceTrait`** — enable one Commerce entity trait on a bundle.
- **`enableCommerceTraits`** — enable a list of traits on a bundle in one action (the singular
  action can't be repeated for one config object, since recipe actions are keyed by action id).
- **`currencyImport`** — import a currency definition via `commerce_price.currency_importer`
  (`entity_types: [commerce_currency]`).
- **`grantExistingPermissions`** — grant already-defined permission(s) to a role
  (`entity_types: [user_role]`); silently drops any permission that isn't registered.
- **`movePropertyBefore`** / **`movePropertyAfter`** / **`movePropertyToOffset`** — reorder a
  key within an associative-array config property (order matters e.g. for a Views `fields`
  display option). Share `MovePropertyActionBase`.
- **`setPropertyByTheme`** — set config property values chosen by the site's default theme,
  with a `_default` fallback.

No submodule ships in a release. `tests/modules/commerce_config_actions_test` is a **test-only
fixture** (provides two dummy Commerce entity traits `test_trait_one` / `test_trait_two` for the
kernel tests) — not installed on real sites.

## Solution docs

- **Every config action: id, value shape, apply() behavior, YAML examples** →
  [actions/config-actions.md](actions/config-actions.md)
