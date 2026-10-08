# Configuration

Open the settings form (route
`govdelivery_bulletins.govdelivery_bulletins_admin_form`) as a user with
permission to administer the module. There are two things to get right: the
GovDelivery **connection**, and the **send switches** that control whether
anything actually goes out.

## Basic operations — the safety switches

The "Basic operations" section has **two checkboxes**, and they start out
**disabled** on purpose:

- One controls whether bulletins are **queued** at all.
- The other controls whether the **queue is processed** (i.e. sent to
  GovDelivery).

With both off, nothing is queued and nothing is delivered — which is exactly what
you want during initial setup and testing. **Only turn both on when you are
genuinely ready to send**, because processing the queue reaches real subscribers.

## The GovDelivery API endpoint

The endpoint depends on your environment and on whether you want to send
immediately or create a draft bulletin. Substitute your own `ACCOUNT_CODE` (you
can find it in the URL of the GovDelivery administrative interface):

- **Staging** (use for lower environments and initial testing):
  - Send immediately:
    `https://stage-api.govdelivery.com/api/account/ACCOUNT_CODE/bulletins/send_now`
  - Create draft bulletin:
    `https://stage-api.govdelivery.com/api/account/ACCOUNT_CODE/bulletins.xml`
- **Production**:
  - Send immediately:
    `https://api.govdelivery.com/api/account/ACCOUNT_CODE/bulletins/send_now`
  - Create draft bulletin:
    `https://api.govdelivery.com/api/account/ACCOUNT_CODE/bulletins.xml`

Always use the `https://` endpoints so credentials and content travel over TLS.

## Storing the endpoint, username and password securely

The GovDelivery **username and password are secrets** and must not be committed
to version control or exported in your site's configuration. The module reads
them from configuration overrides, so the recommended pattern is to set them in
`settings.local.php` (which is not committed), sourcing the actual values from
environment variables rather than hard‑coding them:

```php
// settings.local.php — values come from the environment, not from code.
$config['govdelivery_bulletins.settings']['govdelivery_endpoint'] = getenv('GOVDELIVERY_ENDPOINT');
$config['govdelivery_bulletins.settings']['govdelivery_username'] = getenv('GOVDELIVERY_USERNAME');
$config['govdelivery_bulletins.settings']['govdelivery_password'] = getenv('GOVDELIVERY_PASSWORD');
```

If you use DDEV, store the secret values as environment variables so they are
present in the web container without ever being committed:

```bash
ddev dotenv set .ddev/.env --govdelivery-username=<value> --govdelivery-password=<value> --govdelivery-endpoint=<value>
ddev restart
```

(The flag `--govdelivery-username` becomes the variable `GOVDELIVERY_USERNAME`,
and so on. Keep `.ddev/.env` out of version control.) After restarting, the
`getenv()` calls above pick the values up.

## Who can trigger bulletins

The module provides its own **permissions**. Because a send can reach a large
subscriber audience, grant the ability to trigger or queue bulletins only to
trusted roles. Combined with keeping the send switches off until you are ready,
this is your main protection against accidental mass sends.

## A safe testing workflow

1. Point the endpoint at **staging** and enter staging credentials.
2. Leave both "Basic operations" switches **off** while you wire up your custom
   code.
3. Queue a bulletin with the `test` flag and an explicit test recipient address
   (see the [guide index](../index.md)) rather than a live topic/list.
4. Only when you are confident, switch to production credentials and turn on the
   two send switches.
