Conzent CMP embeds the Conzent consent-management platform — a GDPR/CCPA/ePrivacy cookie banner with IAB TCF v2.2 support — into a Drupal site, in either Conzent Cloud or self-hosted (OCI) mode.

---

A single settings form at `/admin/config/system/conzent` (route `conzent.settings`, permission "administer site configuration") collects a **Website Key** from the Conzent dashboard, an optional **Server URL** (blank = Conzent Cloud; set for self-hosted OCI), and optional **Google Tag Manager** container id and data-layer name. On save the module calls the Conzent verify API; once the key is verified it injects the Conzent banner script (`/c/consent.js`) into every page's `<head>`, and when a GTM id is present it also injects the Google Tag Manager loader and its noscript iframe so consent can be wired into the data layer. The module ships no content entities, plugins, services, or public endpoints — just the config object `conzent_drupal.settings`, the admin form, and a page-attachments hook. A dedicated "administer conzent" permission is declared as well.

Set it up by pasting your Conzent website key, choosing cloud vs self-hosted, and optionally adding your GTM id. Use it to satisfy cookie-consent/consent-signalling requirements and to gate tag firing on user consent via TCF.

---

- Add a GDPR/CCPA/ePrivacy-compliant cookie banner to a Drupal site.
- Paste a Conzent website key to activate the CMP.
- Run against Conzent Cloud without self-hosting anything.
- Point the CMP at a self-hosted (OCI) server URL instead of the cloud.
- Have the module verify the website key against the Conzent API on save.
- Load the banner script site-wide only after the key is verified.
- Signal consent via IAB TCF v2.2 for programmatic advertising partners.
- Integrate consent with Google Tag Manager via built-in container injection.
- Set the GTM container id (GTM-XXXXXXX) from the settings form.
- Customize the GTM data-layer variable name (defaults to `dataLayer`).
- Gate marketing/analytics tags on user consent through the data layer.
- Emit the GTM noscript iframe fallback automatically alongside the loader.
- Show a "website key verified" status message once configuration succeeds.
- Link straight to the Conzent dashboard from the settings page.
- Restrict CMP administration via the site-configuration permission.
- Switch a site between cloud and self-hosted CMP by changing one URL.
- Comply with ePrivacy cookie requirements across jurisdictions.
- Configure the entire integration from one admin settings form.
- Remove all module configuration cleanly on uninstall.
