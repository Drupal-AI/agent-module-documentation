# Configuration

Setting up mobile-number login is mostly about two things: switching the feature on,
and making sure the OTP path behind it is safe. Because the actual code delivery and
verification lean on your site's mobile-number / SMS layer, treat "configuration"
here as a checklist that spans both the module and that layer.

## Enable phone login

As an administrator, enable mobile-number login for your site so the login form
accepts a phone number and triggers an SMS one-time code. Users' accounts must have
a valid mobile number recorded for this to work — on many sites the mobile number is
already the mandatory account identifier, which is exactly the case this module is
built for.

## Store the SMS-gateway credentials as secrets

The credentials for your SMS gateway are secrets — never hard-code or commit them.
With DDEV, save them as environment variables and consume them from the SMS layer's
settings (or via a Key entity where supported):

```bash
ddev dotenv set .ddev/.env --sms-gateway-key=<value>
ddev restart
```

## Confirm the OTP is safe

Before relying on phone login in production, verify — in the underlying
mobile-number/SMS layer — that the one-time code is:

- **Cryptographically random**, **single-use**, and **expiring** after a short
  window.
- Protected by **flood/rate-limiting on sending** — so an attacker can't trigger a
  flood of SMS messages to a number (SMS-bombing) or run up your gateway costs.
- Protected by **flood/rate-limiting on verification** — so the code itself can't be
  brute-forced by repeated guesses.

These protections typically come from the SMS/mobile-number layer rather than from
this module directly, so it's worth confirming they are actually in place for your
setup.

## Test the flow

Attempt a login with a real mobile number: you should receive the OTP by SMS,
succeed with the correct code, and be refused (and rate-limited) after repeated bad
attempts. Confirm expired codes are rejected.
