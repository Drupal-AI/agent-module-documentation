# Configuration

Setting up Give has two parts: configuring how you **take payment** (especially
Stripe), and creating the **donation forms** donors will use. Because real money
and personal data are involved, read the security notes as you go — they aren't
optional extras.

## Open the settings

1. Log in as a user with permission to administer Give.
2. Open Give's settings — the `give.settings` form, reached from the module's
   *Configure* link on **Extend** (**Administration → Extend**) or under
   **Configuration**.

## Payment methods

Give supports three ways to donate. Enable the ones you want to offer:

- **Credit card via Stripe** — the main online method. Requires your Stripe API
  keys (below).
- **Cheque pledge** — the donor pledges to send a cheque; the module records the
  intent.
- **Bank transfer** — a low‑fee option where the donor transfers funds directly.

## Stripe keys — store them as secrets

Stripe gives you a **publishable key** and a **secret key** (and separate test
and live pairs). The publishable key is safe in the browser, but the **secret key
must be protected**: never commit it, and don't paste it into configuration that
gets exported to your repository. Keep it in an environment variable and reference
it — through a **Key** entity where supported.

With DDEV, store the secret out of version control:

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=<your-secret-key> --stripe-webhook-secret=<your-webhook-secret>
ddev restart
```

That exposes `STRIPE_SECRET_KEY` and `STRIPE_WEBHOOK_SECRET` in the container for
you to reference (via a Key entity or settings). Keep `.ddev/.env` out of version
control. Always serve donation pages over **HTTPS**.

## Webhooks — verify the signature

If you configure Stripe **webhooks** so Stripe can tell your site when a payment
succeeds, make sure the **webhook signature is verified**. Stripe signs each event
with the `Stripe-Signature` header and your webhook signing secret; verifying it
ensures the event genuinely came from Stripe and isn't a forged "payment
succeeded" request. Confirm the module is verifying the signature (and that the
webhook signing secret above is set) before you rely on webhooks to fulfil
anything.

## Donor data and access

Every donation record holds **personal data** — the donor's name, email, and the
amount they gave. Treat it accordingly:

- Restrict who can view donation records and reports using Give's **permissions**
  (**People → Permissions**), granting them only to trusted staff.
- Handle and retain the data in line with your privacy obligations.

## Thank‑you emails and recurring donations

Give can automatically send a **thank‑you email** after a donation — configure the
message text in the settings. It also supports **recurring donation** options; if
you offer them, test the recurring flow end to end (including the Stripe side)
before going live.

## Create donation forms

With payment configured, build your **donation forms**. You can embed a form in a
page through the **Paragraphs** integration, or place it as its own page. Preview
the form, make a small **test‑mode** donation (using Stripe test keys/cards), and
confirm the donation is recorded and the thank‑you email is sent before switching
to your live Stripe keys.
