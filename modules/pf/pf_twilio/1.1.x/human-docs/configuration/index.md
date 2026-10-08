# Configuration

Push Framework Twilio needs your Twilio account credentials so it can send SMS on
your behalf. You supply them through the module's Twilio channel settings, which
live alongside the other Push Framework channel configuration.

> **This is an early beta.** The exact wording and location of the settings may
> change between releases. Look for the **Twilio** channel settings under the
> Push Framework configuration once the module is enabled.

## What you need from Twilio

Sign in to the [Twilio Console](https://www.twilio.com/console) and collect:

- **Account SID** — your Twilio account's public identifier.
- **Auth Token** — the secret token that authenticates API requests. Treat this as
  a **secret**.
- **A sending phone number** — an SMS‑capable Twilio number (or messaging service)
  that messages are sent *from*.

## Enter the credentials

Enter the Account SID, Auth Token and sending number in the module's Twilio
settings and save. Once saved, enable the **Twilio** channel in Push Framework's
own settings so notifications are routed through it.

## Keep the Auth Token out of version control

The Auth Token is a credential and must not be committed to your repository. Store
it in an environment variable rather than hard‑coding it.

With DDEV, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --twilio-auth-token=<your-token>
ddev restart
```

Then reference the variable from your settings — for example as a configuration
override in `settings.php` using `getenv('TWILIO_AUTH_TOKEN')` — so the live token
stays in the environment. Never commit `.ddev/.env` or the raw token.

## A note on cost

Every SMS Twilio sends is billed to your Twilio account. Before wiring this up to a
high‑traffic notification, make sure you understand the per‑message pricing and
have any spending limits you want in place on the Twilio side.
