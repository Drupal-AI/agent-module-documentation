# Configuration

ConsentX is a connector: the Drupal side is mostly about linking your site to your
ConsentX account, after which the banner and script‑blocking are managed from the
ConsentX platform.

## Connect your ConsentX account

1. Sign in as a user with the **Administer ConsentX** permission (an administrator
   by default; check **People → Permissions** to delegate the
   `administer consentx` permission — it is marked as security‑sensitive).
2. Open the ConsentX module settings at
   **Administration → Configuration → System → ConsentX**
   (`/admin/config/system/consentx`).
3. Link the site in one of two ways:
   - **1‑click Connect (recommended).** Click **Connect to ConsentX**. You are
     redirected to `app.consentx.io` to log in and approve; ConsentX registers your
     domain, mints a site key and token, and redirects back. The banner goes live
     immediately.
   - **Manual site key.** Paste a **Site key** copied from the ConsentX dashboard
     (Websites → your site) into the **Site key** field and save. Make sure your
     domain is on that site's allowlist in the dashboard.

To stop the banner, click **Disconnect** on the settings screen (this clears the
key and token from the site; revoke the token itself from the ConsentX dashboard
under **API Tokens**).

## Where the connection is stored

The site key and token are saved in the module's `consentx.settings`
configuration. If you export configuration, be aware they travel with it; the
banner reads them from config on every front‑end page render.

## Options on the Drupal settings screen

Below the connection, the settings form has a small **Widget behaviour** section:

- **Google Consent Mode v2 defaults** (on by default) — prints a denied‑by‑default
  `gtag('consent','default',…)` state in `<head>` before any analytics tag fires;
  the ConsentX widget sends the update signals once the visitor chooses.
- **Pre‑consent script blocking** — passes a hint so your own tagged scripts are
  held until consent (the widget auto‑blocks common third‑party trackers regardless).
- **Advanced → ConsentX app host** — override `https://app.consentx.io` only for a
  staging or self‑hosted ConsentX instance.

Everything else about the banner is managed in the ConsentX console.

## What you configure in the ConsentX console

Because ConsentX is a cloud platform, most of the actual consent behaviour is
configured in the ConsentX console rather than in Drupal, including:

- **Banner appearance** and text.
- **Automatic cookie scanning** and categorisation.
- **Pre‑consent script blocking** rules.
- **Geo‑aware compliance rules** (which regime applies to which visitors).
- The **consent analytics dashboard** and **consent logging**.
- **Google Consent Mode v2** behaviour.

See the vendor documentation at `https://docs.consentx.io` for the full set of
options.

## Privacy and data‑flow note

Consent data flows through the ConsentX third‑party service, and the site needs an
internet connection to reach it. Record this data flow in your own privacy
documentation and vendor/DPA assessments, and make sure your users' privacy notice
reflects the use of an external CMP.

## Verify

Load the front end as an anonymous visitor: the ConsentX banner should appear, and
third‑party scripts should be held back until consent is given. Use the ConsentX
dashboard to confirm consent events are being logged.
