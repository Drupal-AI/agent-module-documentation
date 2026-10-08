<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce SQL Sanitize (commerce_sql_sanitize) — agent index

Extends Drush's built-in **`sql:sanitize`** command with a set of Commerce-specific scrub
operations, so that copying a production database down to a development environment (typically via
`drush sql:sync … --sanitize`) also removes Commerce personal data that core's sanitizer does not
touch. It ships no UI, no config, no permissions and no routes — five service classes tagged
`drush.command` register as Drush `SanitizePluginInterface` plugins and attach to `sql:sanitize`
through Drush command hooks: `@hook post-command sql-sanitize` does the work, `@hook option
sql-sanitize` adds the `--…` toggles, and `@hook on-event sql-sanitize-confirms` adds the
confirmation lines. All statements are built with the Drupal database API (`->update()`,
`->truncate()`, `->condition()`); table and column names come from each entity's table mapping, not
from raw command input.

On `drush sql:sanitize` the module, by default: sets `commerce_order.mail` to `sanitized@local.test`
and `commerce_order.ip_address` to `127.0.0.1`; deletes all cart orders (orders with `cart = TRUE`,
via a chunked entity delete); overwrites every `address`-type field column on **`profile`** entities
(and their revision tables) with fixed placeholder values; truncates the `commerce_log` and
`commerce_payment_method` entity tables; and truncates `profile__tax_number` (+ its revision table).
Every operation is individually guarded so it silently no-ops when the relevant Commerce entity
type/field is absent, and every one can be disabled with a command-line option (a value of `no` or
`0` disables). Nothing runs until you invoke `sql:sanitize`; the module has no automatic hooks.

- Depends on: nothing in `.info.yml`; **`drupal/commerce ^2.3 || ^3.0`** via `composer.json` only.
  The scrubs only fire once the matching Commerce submodules (commerce_order, commerce_log,
  commerce_payment, commerce_tax) and the `profile` entity type are installed.
- Core: `^9.1 || ^10 || ^11`. Package: `Commerce (contrib)`. Version `1.0.0`.
- No settings page / `configure` route, no permissions, no config schema, no plugin types defined.
  All behaviour is Drush-time.
- Drush surface: five `drush.command`-tagged services that hook the existing `sql:sanitize` command.
  It adds **options and hooks to `sql:sanitize`, not a new standalone command.**

## What you'd do → where

- **Run it, know exactly what each default scrub touches, and disable a specific operation** →
  [drush/sanitize.md](drush/sanitize.md)
- **Understand the Drush `SanitizePluginInterface` hook mechanism, or write your own sanitize
  plugin** → [api/hook_sql_sanitize.md](api/hook_sql_sanitize.md)

## Key facts (real machine names)

- Drush service ids (all tagged `{ name: drush.command }`, in `drush.services.yml`):
  `commerce_sql_sanitize.commands.sanitize.commerce_log`,
  `commerce_sql_sanitize.commands.sanitize.commerce_order`,
  `commerce_sql_sanitize.commands.sanitize.commerce_payment`,
  `commerce_sql_sanitize.commands.sanitize.address`,
  `commerce_sql_sanitize.commands.sanitize.tax_number`.
- Classes (`src/Commands/`): `SanitizeOrderCommands`, `SanitizeAddress`, `SanitizeTaxNumber`,
  `TruncateCommerceLogCommands`, `TruncatePaymentMethodsCommands`, and the abstract base
  `TruncateEntityTablesCommands`. All implement `Drush\Drupal\Commands\sql\SanitizePluginInterface`.
- Options added to `sql:sanitize`: `--sanitize-orders`, `--delete-carts`, `--sanitize-address-field`,
  `--sanitize-address-fields=<comma,list>`, `--sanitize-commerce-log`,
  `--sanitize-commerce-payment-method`, `--delete-tax-numbers`.
- Tables / entities touched: `commerce_order` (`mail`, `ip_address` on the base table); cart orders
  deleted via `getQuery()->condition('cart', TRUE)->accessCheck(FALSE)`; `address` field columns on
  `profile` only; `commerce_log` and `commerce_payment_method` entity tables truncated whole;
  `profile__tax_number` (+ `profile_revision__tax_number`) truncated.
- Address columns replaced (`SanitizeAddress::FIELD_COLUMNS`, 13 columns): `country_code`→`US`,
  `administrative_area`→`DC`, `postal_code`→`20500`, all others → `[Sanitized]`.
