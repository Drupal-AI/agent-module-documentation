<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynatrace Transactions (dynatrace_transactions) — agent index

Renames each Drupal request's **Dynatrace transaction/trace** from the matched **route path
template**, with entity-type route parameters swapped for the **entity bundle**, plus the visitor's
**highest-weight enabled role** in parentheses — e.g. `node/{article} (editor)`. A port of the New
Relic Transactions module for Dynatrace. Package `Dynatrace`. **No dependencies** (core only), no
external libraries, no composer.json. Core requirement `^8.8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Only release: **1.0.0-rc2** (pre-release on 1.0.x; no stable, not security-advisory
covered).

- **How the name is computed (event subscriber mechanism)** → [internals/naming.md](internals/naming.md)
- **The TransactionNamer service other modules can call** → [api/transaction-namer.md](api/transaction-namer.md)
- **Settings form: restricting which roles are used** → [config/settings.md](config/settings.md)

## What it actually is

- **No permissions of its own, no Drush, no plugins, no hooks, no entities, no fields.** Just one
  event subscriber, one tiny service, and one config form.
- **How it reaches Dynatrace:** Dynatrace has **no PHP extension**. The module computes a name and
  passes it as the argument of `TransactionNamer::setTransactionName(string $name)`
  (`src/TransactionNamer.php`). That method only stores the value on a protected property — it makes
  **no HTTP call, sets no header, uses no credential/env var/key**. Dynatrace's OneAgent is
  configured *on the Dynatrace side* to capture that method argument as a **request attribute**,
  which is then used to name the trace. Nothing in this module talks to Dynatrace over the network.

## Services (`dynatrace_transactions.services.yml`)

- `dynatrace_transactions.event_subscriber` → `EventSubscriber\EventSubscriber` — args:
  `@config.factory`, `@entity_type.manager`, `@current_route_match`,
  `@dynatrace_transactions.transaction_namer`. Tagged `event_subscriber`.
- `dynatrace_transactions.transaction_namer` → `TransactionNamer` (no args).

## Route & config

- Route `dynatrace_transactions.config` → path `/admin/config/development/dynatrace-transactions`,
  form `Form\DynatraceTransactionsConfig`, permission **`administer site configuration`**. Menu link
  under *Configuration → Development* (`dynatrace_transactions.links.menu.yml`, weight 10).
- Config object **`dynatrace_transactions.config`** with one key `transaction_roles` (a
  role-machine-name → enabled map). Install default: `anonymous`, `authenticated`, `administrator`
  all `"0"` (disabled). Schema: `config/schema/dynatrace_transactions.schema.yml` (a `sequence` of
  strings). `provides_config_schema: true`.
