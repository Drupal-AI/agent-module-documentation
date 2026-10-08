# Configuration

Google AdWords Lite has one job, so its configuration is short: tell it which
Google Ads conversion to track, then handle consent.

## Open the settings form

1. Log in as a user granted the module's administration permission (find it under
   **People → Permissions** and assign it deliberately — it controls the tracking
   code that goes on every page).
2. Open the module's **Google AdWords Lite** settings form.

## Conversion tracking details

Enter your **Google Ads conversion identifier** — the **conversion ID** and, where
your conversion action uses one, the **conversion label**. You get these from your
Google Ads account when you create a conversion action. Once saved, the module
injects the matching Google Ads tracking snippet into your pages so conversions are
reported back to Google Ads.

These values are not secret in the way an API key is — they are meant to be present
in the page for the browser — but they should still be correct, since a wrong ID
means your conversions won't be recorded.

## Save

Click **Save configuration**. The tracking snippet is injected from then on. View a
front-end page and check the page source to confirm the tag is present.

## Privacy and consent

This module loads Google's tracking code and can set cookies in the visitor's
browser. Depending on where your visitors are, that brings legal obligations:

- **Pair it with a cookie-consent solution** so the tracking only fires when the
  visitor has agreed, where consent is required.
- **Disclose the tracking** in your privacy policy / cookie notice.
- Because the snippet sends data to Google, be aware this is **third-party egress**
  of visitor information — factor that into your data-protection assessment.

The module itself has no access-control role; it only adds the tracking snippet.
