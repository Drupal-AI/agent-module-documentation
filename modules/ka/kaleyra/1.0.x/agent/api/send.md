<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sending SMS via kaleyra

Inject or fetch the service and call `send()`:

```php
/** @var \Drupal\kaleyra\MessageApiAdapter $sms */
$sms = \Drupal::service('kaleyra.sms_api_adapter');
$sms->send('+15551234567', 'Your code is 123456');
```

`send($to, $message)` reads `kaleyra.settings` and issues:
`GET {api_domain}/{api_version}?method=sms&sender=…&to=…&message=…&api_key=…&unicode=…`

Notes:
- API version is fixed to `v4` in the config form.
- The request is fire-and-forget; a `GuzzleException` is caught and logged to the `kaleyra` channel, so callers get no delivery confirmation or return value.
- The API key travels in the query string; rely on TLS (the `https://` API domain) to protect it.
