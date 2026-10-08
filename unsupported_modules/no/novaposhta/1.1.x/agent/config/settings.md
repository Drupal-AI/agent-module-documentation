<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NovaPoshta settings, cron and drush

Install/enable (project is `basket_novaposhta`, module machine name is `novaposhta`):

```bash
composer require drupal/basket_novaposhta
drush en novaposhta -y
```

Requires `basket` + core `views` to be present. Settings live at
`/admin/config/development/novaposhta` (route `novaposhta.settings`, permission
**`access novaposhta settings`**), rendered by `src/Form/NovaPoshtaSettingsForm.php` (`FormBase`,
form id `novaposhta_settings_form`). The form has four independently-submitted sections, each with
its own `#name` handled in `submitForm()`.

## Config objects (written by the form)

- **`novaposhta.settings`** — the only object with a schema (`config/schema/novaposhta.schema.yml`).
  Keys under `config.`:
  - `api_key` (string) — the Nova Poshta API key (section `api`, submit `saveAPI`).
  - `hide_labels` (bool) — hide the basket field labels.
  - `jquery_style` (string) — checkout select widget: `chosen` (default) or `select2` (only offered
    when `webform` provides the `jquery.select2` library; see `getJqueryStyleOptions()`).
  - `calculate_delivery_cost` (bool) — calculate delivery via the API (section `cash_on_delivery`,
    submit `saveCashOnDelivery`; defaulted `TRUE` by `novaposhta_update_8010`).
  - `cash_on_delivery.display_commission` (bool) — show the cash-on-delivery fee.
  - `cash_on_delivery.payment_ids` (sequence of Basket payment term ids) — payment methods for which
    the redelivery/COD fee is calculated.
- **`novaposhta.en.settings`** (no schema) — invoice/waybill section (`saveEN`): `recipient.auto`
  (auto-create recipient from order), `recipient.fields.{LastName,FirstName,MiddleName,Phone,Email}`
  (token / `{{ node.* }}` templates), `print` (`printDocumentPdf` | `printMarking100x100` |
  `printMarking85x85`), `use_description_items_info`.
- **`novaposhta.en.template`** (`config.sender`) — cached sender template; cleared on `saveAPI`.
- **`novaposhta.OptionsSeat`** (`config.sizes.N.{height,width,length}`) — parcel seat dimensions
  (section `saveOptionsSeat`); `NovaPoshta::getOptionsSeat()` merges these with `DEF_OPTIONS_SEAT`.

Saving the API key (`saveAPI`) also calls `NovaPoshta::clearTmp()` and wipes the sender template so
cached lists keyed to the old key are dropped.

Runtime override (README): to skip cron pulls, set in `settings.php`
`$config['novaposhta']['disabled.cron.document.list' | 'disabled.cron.area.list' |
'disabled.cron.city.list'] = TRUE` — read via `$GLOBALS['config']['novaposhta'][...]` in
`NovaPoshta::cronRun()`.

## Cron and drush

`hook_cron` (`NovaposhtaHooks::cron` → `NovaPoshta::cronRun()`) deletes month-old temp dirs,
refreshes the waybill list for the last `NOVAPOSHTA_EN_DAYS` (14) days, updates statuses of pending
waybills, and rebuilds `area` / `city` reference lists (each gated by its `disabled.cron.*` flag).

Drush (`drush.services.yml` → `src/Commands/NovaPoshtaCommands.php`):
- `novaposhta:status_update` — runs `cronRun()` (intended as an external scheduler entry; the form's
  read-only "Scheduler" textarea prints the exact command line).
- `novaposhta:list <type>` — `NovaPoshta::runUpdate($type)` for `area` or `city`.

## Install

`novaposhta.install` `hook_schema()` creates `novaposhta`, `novaposhta_en`, `novaposhta_en_orders`,
`novaposhta_lists`. `hook_install()` runs `novaposhta_update_8005` (fetch area+city lists) and
`_8010` (enable `calculate_delivery_cost`). Menu links: `novaposhta.settings` under
*Configuration → Development*, plus Basket-menu entries in `novaposhta.links.menu.yml`.
