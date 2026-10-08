# Configuration

The essential setting is your **Eulerian website domain**; the rest of the form
controls which pages and events are tracked and how the tracking behaves.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (or the
   module's own administration permission).
2. Open the Eulerian settings page (`eulerian.settings_form`) under
   **Configuration**.

## The essential setting

- **Eulerian website domain** — the domain associated with your Eulerian account.
  Enter it and save; the tracking code is then added to your pages. This domain is
  a public tracking identifier (it appears in the client-side tag), not a password;
  the module stores it as ordinary configuration and needs no API key or secret.

## What and how to track

The form exposes Eulerian's tracking options, including:

- **Single‑domain tracking** for your site.
- **Page inclusion/exclusion** — selectively track or exclude specific pages.
- **Custom variables** supplied with tokens.
- **Site search** tracking.
- **Modal dialog (Colorbox)** tracking.
- **403 (access denied) and 404 (page not found)** tracking.
- **Cross‑device user‑ID** tracking.
- **Asynchronous** tracking and Eulerian's **data‑cleaning** system.
- **Eulerian Tag Manager** support.

## E‑commerce tracking

If you enabled the `eulerian_commerce_*` submodules, cart, checkout and product
events are sent to Eulerian in addition to page tracking — useful for purchase
attribution.

## Privacy and consent

Eulerian sends visitor and (for Commerce) purchase/behaviour data to a third party,
so treat consent as part of setup:

- Obtain appropriate consent and integrate it with your cookie‑consent mechanism —
  the companion **Eulerian Tarte au Citron** or **Eulerian TacJS** modules make the
  tracker load only after consent.
- Disclose the tracking in your privacy policy per GDPR / applicable law.

## Save

Click **Save configuration**. Reload a front‑end page and view its source to confirm
the Eulerian tracking code is present (and, if you use a consent manager, that it
loads only after consent).
