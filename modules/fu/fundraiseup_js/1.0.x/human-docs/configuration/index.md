# Configuration

Fundraise Up JS has a single, short settings form. Until you complete it, the
widget does not load.

## Open the settings form

1. Log in as a user with the **Administer Fundraise Up JS configuration**
   (`administer fundraise up js configuration`) permission.
2. Go to **Configuration → Web services → Fundraise Up JS**, or navigate directly
   to `/admin/config/services/fundraiseup-js`.

## Site ID

Enter the **Site ID** from your Fundraise Up dashboard. This is the identifier
that tells Fundraise Up which account and campaigns to serve, and it becomes part
of the CDN script URL (`https://cdn.fundraiseup.com/widget/<site_id>`).

The Site ID is a **public identifier, not a secret** — it appears in the page
source by design, so it does not need Key/secret storage. The module validates it
to contain only letters, numbers, and underscores (`^[a-zA-Z_0-9]+$`) and escapes
it before output, so an invalid value is rejected on save.

## Live Mode

A toggle that controls whether donations run against Fundraise Up's **live** or
**test** environment. When set to live mode the module emits an inline flag
(`window.fundraiseup_livemode`) that Fundraise Up reads.

- Leave **Live Mode off** on staging and development sites so you can exercise
  donation flows without processing real payments.
- Turn **Live Mode on** in production once you are ready to accept real
  donations.

## Save and privacy note

Click **Save configuration**. From then on the Fundraise Up script loads on all
non‑admin pages.

Because that script is a **third‑party asset that sees every page a visitor
views**, treat it as a consent and data‑protection consideration: make sure
loading it fits your privacy policy, and if you enforce a Content‑Security‑Policy,
allow `cdn.fundraiseup.com` so the widget is not blocked.
