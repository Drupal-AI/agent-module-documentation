<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `currency.permissions.yml`. Currency admin lives under
*Configuration → Regional and language*.

| Permission | Gates |
|---|---|
| `currency.amount_formatting.administer` | The amount-formatting settings form (`/admin/config/regional/currency-formatting`) — choose the default formatter |
| `currency.exchange_rate_provider.administer` | Enable/order exchange rate providers (`/admin/config/regional/currency-exchange`) |
| `currency.exchange_rate_provider.fixed_rates.administer` | Add/edit/delete fixed exchange rates (`/…/currency-exchange/fixed`) |
| `currency.currency.view` | View the currencies list (`entity.currency.collection`) |
| `currency.currency.create` | Add / import currencies |
| `currency.currency.update` | Edit (and enable/disable) currencies |
| `currency.currency.delete` | Delete currencies |
| `currency.currency_locale.view` | View currency locales |
| `currency.currency_locale.create` | Add / import currency locales — **`restrict access: true`** |
| `currency.currency_locale.update` | Edit currency locales — **`restrict access: true`** |
| `currency.currency_locale.delete` | Delete currency locales |

Currency and currency-locale entity operations (view/create/update/delete, plus enable/disable
for currencies) are enforced through the entity access system
(`CurrencyAccessControlHandler`), mapping to the permissions above. The two `restrict access`
locale permissions are flagged because editing a locale's pattern affects how every amount is
rendered — grant them only to trusted admins.

Grant e.g. `drush role:perm:add editor 'currency.currency.view'`.
