# Configuration

SMS.ru has no settings page of its own — you configure it by adding a gateway to
the **SMS Framework**, which is where its fields appear.

## Prerequisite

Make sure the **SMS Framework** is installed and enabled
(`composer require drupal/sms` then `drush en sms`). The `smsru` module only
provides the gateway plugin.

## Add the gateway

1. Go to **Configuration → SMS & messaging → Gateways**
   (`/admin/config/smsframework/gateways`).
2. Add a gateway and choose **SMS.ru**.

## Choose an authentication method

Pick one of the two methods on the gateway form:

- **API ID (recommended)** — paste the ID from your SMS.ru account
  (`https://sms.ru/?panel=api`). It is stored masked; the field shows the current
  masked value rather than the raw ID.
- **Login and password** — enter your SMS.ru account login and password instead.
  Both are password‑type fields.

## Other options

- **Testing mode** — tick this to have messages appear in your SMS.ru account
  **without actually being delivered**, so you can verify wiring safely.
- **Sender name** — set a custom `from` name on outgoing messages (subject to
  SMS.ru approving your sender names).

Save the gateway, then set it as the site **default** (or route specific numbers
to it).

## Where credentials are stored

Credentials live in Drupal `state` under the key
`smsru.smsframework.auth_settings`. If you ever need to clear them, tick the
**Forget credentials** checkbox when submitting the gateway form — it wipes the
stored API ID, login, and password.

## Delivery reports

The gateway maps SMS.ru status codes to SMS Framework delivery statuses — for
example 100/101/102 → queued, 103 → delivered, 104 → expired, 105–108 → rejected,
150 → invalid recipient, 203 → content invalid — so you can see outcomes in the
framework's reporting.

## For developers: the standalone API client

Beyond the gateway, the module provides a `\Drupal\smsru\SmsRu` client that
exposes the wider SMS.ru API — `smsSend`, `smsStatus`, `smsCost`, `myBalance`,
`myLimit`, `myFree`, `mySenders`, `authCheck`, stop‑list management
(`stoplistAdd/Del/Get`), delivery callbacks (`callbackAdd/Del/Get`), and
call‑check (`callcheckAdd/Status`). Build messages with
`\Drupal\smsru\Message\Message` (`setFrom`, `setTime`, `setTtl`, `setTranslit`,
`setTest`, and so on). Site builders don't need this; it's there for custom code.
