# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Stripe** module (`drupal/stripe` `^2.0`) — provides the Stripe API
  connection, the client-side payment JS, and the signature-verified webhook
  endpoint. **Your Stripe API keys are configured here, not in this module.**
- The **Webform** module (`drupal/webform` `^6.3@alpha`).

Composer pulls both dependencies in with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/stripe_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Stripe, Webform,
and any shared dependencies alongside this module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/stripe_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en stripe_webform -y
```

This enables Stripe and Webform too if they weren't already on.

## Configure your Stripe API keys (in the base Stripe module)

This integration reads the Stripe **secret** and **publishable** keys from the
base Stripe module (`stripe.settings`). Configure them under the Stripe module's
settings.

Keep the **secret key** out of version control. The recommended pattern on this
project is to store it in an environment variable and reference it via a **Key**
entity rather than pasting it into config:

```bash
# Save the secret to DDEV's dotenv (never commit .ddev/.env), then restart
ddev dotenv set .ddev/.env --stripe-secret-key=<your sk_... value>
ddev restart
```

Then create a Key entity backed by that environment variable and point the Stripe
module at it. (Install the Key module first if needed:
`ddev composer require drupal/key && ddev drush en key -y`.) Use Stripe **test**
keys while building, and switch to live keys only when you're ready.

## Set up the Stripe webhook (optional but recommended)

If you want to react to Stripe events (e.g. `invoice.paid`), point a Stripe
webhook at the base Stripe module's webhook endpoint. That module verifies the
Stripe signature; this module then exposes a matching `stripe_webform.webhook`
event you can use in code or Rules.

## Next: build a payment form

Continue to [Configuration](../configuration/index.md) to add a Stripe element and
the Stripe handler to a webform.
