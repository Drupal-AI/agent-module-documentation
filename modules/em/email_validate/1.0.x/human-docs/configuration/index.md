# Configuration

Email Validate does its work through a set of **constraints**, each of which you
can enable or disable independently. Nothing is forced on you — you pick the
checks that fit your site and save.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → User Email validation**, or navigate directly
   to `/admin/config/people/email_validate`.

Tick the constraints you want and click save. The rest of this page explains what
each one does.

## The validation constraints

- **Google disposable email** — blocks Gmail/Google address tricks that resolve to
  an account you already have: for example `user+@gmail.com`,
  `user+@googlemail.com`, or dotted variations like `u.ser@googlemail.com` when
  `user@gmail.com` already exists. This stops one person from spinning up many
  "different" addresses that all land in the same inbox.

- **Yandex temporary emails** — blocks the equivalent variations on Yandex
  domains: for example `u-ser@yandex.com` when `u.ser@yandex.com` already exists,
  and cross‑domain equivalents across `ya.ru`, `yandex.ru`, `yandex.by` and the
  other Yandex domains when a matching account already exists.

- **E‑mail domain black list** — an internal list of email domains you want to
  block outright. Add the domains you consider disposable or unwanted and
  registrations using them are rejected.

- **Temporary email checking (block‑temporary‑email.com)** — checks the address
  against the external `block-temporary-email.com` service. This one requires you
  to create an account there and obtain an **API key**, since the check calls
  their service. Enable it only if you're comfortable sending addresses to that
  third‑party service.

- **E‑mail domain DNS check** *(added in 1.0.5)* — verifies that the email
  domain actually has a valid DNS record, catching mistyped or non‑existent
  domains.

## Bulk‑checking existing users (1.0.5+)

Newer releases add a feature to run the enabled checks across **existing site
users** in bulk, so you can find accounts that were created before you tightened
your validation rules.

## Save

Enable the constraints you want and click **Save configuration**. The selected
checks then apply the next time someone registers or updates their email address.

> **Remember:** these checks validate the quality and reputation of an address,
> not whether the visitor controls the inbox. For genuine ownership confirmation,
> combine Email Validate with Drupal core's email verification.
