<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mollie for Drupal (mollie) — agent index

Integrates the **Mollie** payment service provider (iDEAL, cards, PayPal, local methods) into
Drupal. The base module holds the API connector (`mollie.mollie` service, wrapping
`mollie/mollie-api-php ^2.52`), an API-backed `mollie_payment` entity, a payments overview, and
the redirect/webhook routes. Submodules add the payment contexts. Payments are created on Mollie
and their status is read back through the API; nothing about a payment is stored in the local
database.

- Core: `^10.1 || ^11`. Declared `php: 8.3` in the info file. Depends on `datetime`, `options`.
- Configure route: `mollie.configuration` → `/admin/config/services/mollie`.
- Defines permissions: yes. Config schema: yes. Drush: no. Plugin types: none (submodules
  provide plugins for Commerce/Webform).

Submodules shipped in this project (documented separately, not here):

| Submodule | Purpose |
|---|---|
| `mollie_commerce` | Drupal Commerce off-site payment gateway (needs `commerce_payment`) |
| `mollie_webform` | Take payment as part of a Webform submission (needs `webform >= 6`) |
| `mollie_customers` | Mollie Customers API records (`mollie_customer` entity) |

## Solution docs

- **Set up credentials, test mode, config object** → [configure/settings.md](configure/settings.md)
- **Permissions and entity access** → [permissions/permissions.md](permissions/permissions.md)
- **Create a payment, use the `mollie.mollie` service, routes, `mollie_payment` entity** → [api/payments.md](api/payments.md)
- **Hook into payment status / redirect / refund from another module** → [events/events.md](events/events.md)

## Key facts

- Service: `mollie.mollie` (`Drupal\mollie\Mollie`); helper `mollie.config_validator`
  (`Drupal\mollie\MollieConfigValidator`).
- Config object: `mollie.config` — keys `test_mode` (boolean), `webhook_base_url` (string).
- Credentials live in `settings.php` as `$settings['mollie.settings']` (`live_key`, `test_key`,
  `access_token`), read via `Settings::get('mollie.settings')` — never in exported config or the UI.
- Entity: `mollie_payment` (`Drupal\mollie\Entity\Payment`), storage `PaymentStorage` (API-backed).
- Permissions: `access mollie payments overview`, `administer mollie`, plus dynamic
  `create mollie_payment entities` / `view mollie_payment entities`.
- Routes: `mollie.admin` (`/admin/mollie`), `entity.mollie_payment.collection`
  (`/admin/mollie/payments`), `mollie.redirect` (`/mollie/redirect/{context}/{context_id}`),
  `mollie.webhook.status_change` (`/mollie/webhook/{context}/{context_id}`),
  `mollie.webhook.aftercare` (`.../aftercare`).
- Events: `mollie.redirect_event`, `mollie.transaction_event.status_change`,
  `mollie.transaction_event.refund`, `mollie.transaction_event.chargeback`
  (+ deprecated `mollie.notification_event`).
- Key/value collection: `mollie_last_webhook_invocation`.
