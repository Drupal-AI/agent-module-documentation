<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Tax Conditions lets a store make a **tax rate conditional** — the configured tax type only
applies when the order matches the attached Commerce conditions (order total, customer, store, etc.).

Use it when a single flat tax type is not enough and tax must depend on business rules: e.g. only charge a
rate above a threshold, for specific stores, or for specific customers. It extends Commerce Tax's own
condition support and is aimed at site builders configuring tax types, not developers writing code.
---
- Requires Drupal Commerce with the **Commerce Tax** submodule (`>= 8.x-2.20`); enable both first.
- Install like any module: `ddev composer require drupal/commerce_tax_conditions` then `ddev drush en commerce_tax_conditions`.
- No dedicated permission or admin page of its own — it plugs into the existing tax-type UI.
- Configure a tax type at `/admin/commerce/config/tax-types`; the module exposes a **Conditions** section on
  the tax type form.
- Conditions are evaluated per order at tax-calculation time; when they fail, the tax type is skipped.
- The module ships config schema so exported tax types carry their condition settings.
---
- Attach order-level conditions to a Commerce tax type.
- Apply a tax rate only when the order total is over/under a limit.
- Restrict a tax type to specific stores.
- Restrict a tax type to specific customers or roles.
- Combine several conditions with AND/OR logic (Commerce condition group behavior).
- Skip tax entirely for orders that do not match.
- Reuse core Commerce condition plugins (no custom code needed).
- Keep tax logic in configuration so it is deployable.
- Model region- or channel-specific tax rules.
- Support promotional or B2B tax exemptions via conditions.
- Evaluate conditions dynamically at checkout.
- Layer on top of Commerce Tax's built-in zone/rate resolution.
- Avoid writing a custom TaxType plugin for simple rule needs.
- Export condition settings with the tax type config.
- Verify the resulting tax on a real test order before go-live.
- Treat all configuration as admin-only (store manager) surface.
