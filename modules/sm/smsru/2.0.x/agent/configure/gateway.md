<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS.ru — gateway configuration

## Prerequisites
Install and enable the SMS Framework: `composer require drupal/sms` then `drush en sms`. `smsru` only provides the gateway plugin.

## Add the gateway
1. Go to **Configuration → SMS & messaging → Gateways** (`/admin/config/smsframework/gateways`).
2. Add a gateway, choose **SMS.ru**.
3. Pick an authentication method:
   - **API ID (recommended):** paste the ID from `https://sms.ru/?panel=api`. It is stored masked; the field shows the current masked value.
   - **Login and password:** enter your SMS.ru account login and password.
4. Optionally tick **Testing mode** (messages appear in the SMS.ru account but are not actually delivered).
5. Save, then set this gateway as the site default (or route specific numbers to it).

## Credential storage
Values live in Drupal `state` under `smsru.smsframework.auth_settings`. Tick **Forget credentials** on submit to wipe API ID, login and password.

## Programmatic API client
`\Drupal\smsru\SmsRu` (constructed with a `Client\HttpClient` + an `Auth\ApiIdAuth`/`LoginPasswordAuth`) exposes: `smsSend`, `smsStatus`, `smsCost`, `myBalance`, `myLimit`, `myFree`, `mySenders`, `authCheck`, `stoplistAdd/Del/Get`, `callbackAdd/Del/Get`, `callcheckAdd/Status`. Build messages with `\Drupal\smsru\Message\Message` (`setFrom`, `setTime`, `setTtl`, `setTranslit`, `setTest`, ...).

## Delivery reports
`getDeliveryReports()` maps SMS.ru status codes → framework statuses (100/101/102 queued, 103 delivered, 104 expired, 105-108 rejected, 150 invalid recipient, 203 content invalid).
