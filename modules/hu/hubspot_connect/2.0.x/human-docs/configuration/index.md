# Configuration

HubSpot connect has one job — inject HubSpot's tracking script — so its
configuration is short.

## Open the settings form

1. Log in as a user with the permission the module provides for administering its
   settings (an administrator by default).
2. Open the HubSpot connect settings form (provided by the
   `hubspot_connect.settings` route, under **Configuration**).

## Enter your HubSpot tracking ID

The key field is your **HubSpot tracking ID** — the portal ID from your HubSpot
account. Enter it and save; the module then attaches HubSpot's tracking
JavaScript to every page as a properly registered Drupal library.

You can find your HubSpot ID in your HubSpot account settings (it is the numeric
portal / hub ID that appears in HubSpot's own tracking‑code snippet).

## Privacy and consent — do not skip this

Because the module loads external JavaScript that tracks visitors and can set
cookies, treat it the way you would any marketing tracker:

- **Disclose it in your privacy policy** — visitors are being tracked by a
  third‑party service (HubSpot).
- **Gate it behind cookie/consent management** where the law requires it (for
  example GDPR in the EU, or CCPA). In practice that means the tracking script
  should only load once a visitor has given the appropriate consent; pair this
  module with your site's consent‑management solution rather than loading the
  tracker unconditionally for everyone.

## Save

Click **Save** to apply. Tracking begins on the next page load for visitors who
are permitted to be tracked.
