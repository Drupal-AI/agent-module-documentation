<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS.ru (smsru) — agent index

**An SMS Framework gateway plugin sending texts and reading delivery reports via the SMS.ru API.**

- **Version:** 2.0.x · PHP 7.2+
- **Core:** ^8.7.7 || ^9 || ^10 || ^11 || ^12
- **Runtime companion:** SMS Framework (`drupal/sms`) — the gateway plugin `@SmsGateway(id="smsru")` plugs into it (not declared in info.yml)
- **Endpoint:** `https://sms.ru` over HTTPS (Guzzle, TLS default on)
- **Auth:** API ID *or* login+password, chosen on the gateway form; stored in `state` key `smsru.smsframework.auth_settings`, secret fields masked
- **Config on:** the SMS Framework gateway add/edit form (no route of its own)

**Security:** credentials are `password`/masked inputs stored in state, with a forget-credentials option; requests use HTTPS with TLS verification at Guzzle's secure default (no `verify => false`). No routes, no anonymous surface. `test_mode` prevents real dispatch.

See [configure/gateway.md](configure/gateway.md)
