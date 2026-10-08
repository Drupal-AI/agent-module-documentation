<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Commerce Abandoned Carts

Single config object: **`commerce_abandoned_carts.settings`**. Form: `AdminForm`
(`ConfigFormBase`) at route **`commerce_abandoned_carts.configuration`** →
`/admin/commerce/config/abandoned_carts`, gated by permission
**`administer commerce abandoned carts`**. Menu link sits under *Commerce → Configuration*.

## Settings keys (with shipped defaults from `config/install`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `timeout` | integer | `1440` | Minutes a cart must be idle before a reminder is sent (1440 = 1 day). |
| `history_limit` | integer | `21600` | How far back (minutes) to look for abandoned carts (21600 = 15 days). |
| `batch_limit` | integer | `5` | Max emails per cron run. Form options: 5/10/25/50/75/100. |
| `from_email` | email | *(unset)* | Sender address; blank → store email → site email. |
| `from_name` | string | `''` | Sender name; blank → store name. |
| `subject` | string | `Your order is incomplete.` | Email subject. |
| `customer_service_phone_number` | string | `''` | Phone shown in the template; blank omits it. |
| `bcc_active` | boolean | `false` | When TRUE, BCC every reminder to `bcc_email`. |
| `bcc_email` | email | *(unset)* | BCC recipient (required in the form when `bcc_active`). |
| `testmode` | boolean | `true` | When TRUE, all mail goes to `testmode_email` and orders are **not** marked sent. |
| `testmode_email` | email | *(unset)* | Test recipient (required in the form when `testmode`). |

> Note: `config/install` also sets `from_name: ''`, `subject`, `customer_service_phone_number: ''`,
> `bcc_active: false`, `testmode: true`. `from_email`, `bcc_email`, `testmode_email` have no
> shipped default (unset/NULL until you enter one).

## Read / write with drush

```bash
drush cget commerce_abandoned_carts.settings
drush cget commerce_abandoned_carts.settings testmode

# Go live: turn test mode off
drush cset commerce_abandoned_carts.settings testmode 0 -y

# Send 2 hours after abandonment, cap 25 per run
drush cset commerce_abandoned_carts.settings timeout 120 -y
drush cset commerce_abandoned_carts.settings batch_limit 25 -y

# BCC an internal mailbox
drush cset commerce_abandoned_carts.settings bcc_active 1 -y
drush cset commerce_abandoned_carts.settings bcc_email ops@example.com -y
```

## Form validation quirks

`AdminForm::validateForm()` requires `bcc_email` when `bcc_active` is checked, and
`testmode_email` when `testmode` is checked. Setting the values directly via `drush cset`
bypasses this form validation, so keep them consistent yourself.

## Going live checklist

1. Set `from_email` / `from_name` (or rely on the store defaults).
2. Set a real `subject`.
3. Turn `testmode` **off** (`0`). Reminders now go to customers and orders are recorded as
   notified in the `commerce_abandoned_carts` table so they are not re-sent.
4. Ensure real cron runs on a schedule — sending only happens on `hook_cron()`.
