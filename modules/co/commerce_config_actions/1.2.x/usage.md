<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Config Actions provides experimental custom config actions for building Drupal Commerce sites from recipes.

---

Commerce Config Actions is an experimental developer module that adds Commerce-specific
[config actions](https://www.drupal.org/docs/extending-drupal/config-actions) — the declarative
operations a recipe (or a `config:actions` block, or a programmatic config-action apply) runs
while configuration is imported. Keeping the actions in a standalone module lets them be
released independently of the Commerce core release cycle. Each action is a core
`#[ConfigAction]` plugin under `src/Plugin/ConfigAction/`; the module ships no routes, forms,
controllers, services, hooks, permissions, or config schema of its own, so it has no runtime
behavior — the actions only ever run at recipe-apply / config-import / install time, which is
an admin/deploy operation. It depends on Commerce `commerce_price` and requires Drupal 11.

---

The actions it provides:

- `enableCommerceTrait` — enable a single Commerce entity trait on a bundle.
- `enableCommerceTraits` — enable a list of Commerce entity traits on a bundle in one action.
- `currencyImport` — import a currency definition via Commerce Price's currency importer.
- `grantExistingPermissions` — grant one or more already-defined permissions to a role
  (permissions that aren't registered by any enabled module are silently skipped).
- `movePropertyBefore` / `movePropertyAfter` / `movePropertyToOffset` — reorder a key within an
  associative-array config property, for config where array order matters (e.g. a Views
  `fields` display option).
- `setPropertyByTheme` — set config property values chosen by the site's default theme, with a
  `_default` fallback.

It is a tool for developers and recipe authors: there is no admin UI, settings page, or content
or access role. A test-only submodule (`commerce_config_actions_test`) supplies dummy entity
traits for the kernel tests and is not installed on real sites. Because the module is explicitly
experimental and its APIs are marked `@internal`, pin the version you deploy.
