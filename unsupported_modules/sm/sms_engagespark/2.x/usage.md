<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
engageSPARK is an SMS Framework gateway plugin that lets Drupal send text messages through the engageSPARK service.
---
The module registers an engageSPARK gateway with SMS Framework (`smsframework`), so any SMS the framework dispatches can be routed through engageSPARK. It contributes a param-converter service for the third-party gateway plugin and relies on `giggsey/libphonenumber-for-php` for number handling. There is no admin form of its own — you create and configure the gateway through SMS Framework's gateway UI (`/admin/config/smsframework/gateways`), supplying the engageSPARK API token and organization/sender settings there.

Operationally, once the gateway is configured and selected (as default or per-route), SMS sends from any module using SMS Framework will be delivered via engageSPARK. This module has a recorded security finding (see the module's local security.md) — review it before enabling in production. Setup: install SMS Framework, enable this module, add an engageSPARK gateway, enter credentials, and set it as the active/default gateway.
---
- Send SMS from Drupal through the engageSPARK gateway.
- Add engageSPARK as a gateway in SMS Framework.
- Route transactional messages (OTP, alerts) via engageSPARK.
- Configure the engageSPARK API token on the gateway.
- Set engageSPARK as the site's default SMS gateway.
- Use engageSPARK for a specific phone-number route only.
- Combine with SMS Framework's queueing for bulk sends.
- Validate recipient numbers with libphonenumber.
- Integrate SMS notifications into custom modules via SMS Framework.
- Send verification codes for two-factor or sign-up flows.
- Deliver marketing/engagement SMS campaigns.
- Switch providers by swapping the active gateway.
- Test message delivery from the SMS Framework test form.
- Log SMS delivery through SMS Framework's reporting.
- Support Drupal 10 and 11 sites.
- Send appointment or reminder texts.
- Fan out one message to many recipients.
- Use engageSPARK's sender ID / org configuration.
