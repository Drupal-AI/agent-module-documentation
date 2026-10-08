# BulkGate SMS — manual setup guide

**BulkGate SMS Module** (`bulkgate_sms`) connects Drupal to
[BulkGate](https://www.bulkgate.com/), an SMS provider, so your site can send
text messages through your BulkGate account. It works as a plug-in for the
[SMS Framework](https://www.drupal.org/project/smsframework) module: BulkGate SMS
adds one gateway (a "BulkGate" gateway plugin), and SMS Framework handles the
rest of the sending machinery — routing, recipient selection, delivery reports,
and so on.

This is an **outbound-only** integration. It sends messages out (one recipient
per message) using BulkGate's PHP SDK over HTTPS, and it maps BulkGate's
responses back into SMS Framework delivery statuses (delivered, invalid
recipient, account error). It does **not** register any inbound webhook or
public route, so there is no callback endpoint to secure. Typical uses are OTP /
verification codes and transactional site notifications.

Once you have added and configured the gateway, its form also shows your BulkGate
account's wallet, credit, currency, and free-message balance — a quick way to
confirm your credentials work and to keep an eye on your balance without leaving
Drupal.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside SMS Framework.
2. [Configuration](configuration/index.md) — add the BulkGate gateway, enter your
   credentials, and set the optional sender name.

## Where it lives in the admin menu

BulkGate SMS does not add a menu item of its own. You configure it through SMS
Framework's gateways page at **Configuration → SMS Framework → Gateways**
(`/admin/config/smsframework/gateways`), where you add a gateway using the
**BulkGate** plugin.
