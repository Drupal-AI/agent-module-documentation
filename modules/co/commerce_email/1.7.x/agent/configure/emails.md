<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & configure a Commerce Email

An email is the config entity **`commerce_email`** (config prefix
`commerce_email.commerce_email.<id>`, schema `commerce_email.commerce_email.*`). Managed at
**`/admin/commerce/config/emails`** (collection); add form `/admin/commerce/config/emails/add`.
Permission: **`administer commerce_email`**.

## Config keys (`config_export`)

| Key | Meaning |
|---|---|
| `id`, `label` | Machine name + admin label. |
| `event` | Email event plugin id (e.g. `order_placed`, `order_paid`, `order_transition:fulfill`). Fixed after creation. Determines which store event triggers it. |
| `targetEntityType` | Entity type the event fires for (e.g. `commerce_order`, `user`). Derived from the event plugin if empty. |
| `from` | From address (token-enabled). Blank ⇒ store default. |
| `toType` | `email` or `role`. Selects how `to`/`toRole` are used. |
| `to` | Recipient address(es) when `toType=email`; supports tokens like `[commerce_order:mail]`. |
| `toRole` | Role id when `toType=role`; sends to all users with that role. |
| `cc`, `bcc`, `replyTo` | Extra addresses (token-enabled). |
| `subject` | Subject line (tokens allowed). |
| `body` | `{ value, format }` — HTML body + text format; tokens allowed. |
| `conditions` | Array of Commerce inline conditions (plugin configs). |
| `conditionOperator` | `AND` or `OR` — how multiple conditions combine (`applies()`). |
| `queue` | Boolean. TRUE ⇒ defer send to the `commerce_email` queue instead of sending immediately. |
| `logToEntity` | Boolean. TRUE ⇒ record each send on the order via Commerce Log. |
| `status` | Standard config-entity enabled flag; only enabled emails are considered. |

## UI flow

1. Go to **Commerce › Configuration › Emails** (`/admin/commerce/config/emails`), click **Add email**.
2. Choose the **Event** (locked after save) and give it a label.
3. Set **Send this email to**: *Specific email address* (`toType=email`, fill `to`) or *Users with
   a role* (`toType=role`, pick `toRole`). Optionally set From/Cc/Bcc/Reply-to.
4. Write the **Subject** and **Body** using tokens (e.g. `[commerce_order:order-number]`).
5. Add **Conditions** (and choose AND/OR) to limit when it sends.
6. Toggle **Use a queue for sending** and **Log to entity** as needed. **Save**.
7. Use the **Test email** tab (`/admin/commerce/config/emails/{id}/test`) to send a test.

## Scriptable

```php
use Drupal\commerce_email\Entity\Email;

Email::create([
  'id' => 'order_confirmation',
  'label' => 'Order confirmation',
  'event' => 'order_placed',          // -> commerce_order.place.post_transition
  'targetEntityType' => 'commerce_order',
  'toType' => 'email',
  'to' => '[commerce_order:mail]',
  'subject' => 'Your order [commerce_order:order-number]',
  'body' => ['value' => '<p>Thanks for your order!</p>', 'format' => 'basic_html'],
  'queue' => FALSE,
  'logToEntity' => TRUE,
  'status' => TRUE,
])->save();
```

Read it back: `drush cget commerce_email.commerce_email.order_confirmation`.

Notes:
- Several enabled emails may target the **same** event; each is evaluated and sent independently.
- Conditions use Commerce's condition plugins (e.g. order total, store, order type).
- `queue: true` needs cron (core Queue) or the `advancedqueue` module (uses the `commerce_email`
  Advanced Queue installed from `config/optional`).
