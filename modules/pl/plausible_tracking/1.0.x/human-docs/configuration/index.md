# Configuration

Plausible tracking is configured from a single settings form. At minimum you tell it
which domain to report under; the rest of the options turn on extra tracking features.

## Open the settings form

1. Log in as a user with the permission to administer Plausible tracking (the module
   provides its own permission).
2. Go to the **Plausible tracking** settings page under **Configuration**
   (`plausible_tracking.settings`).

## Domain and tracking host

- **Domain** — the site/domain name exactly as it is registered in Plausible. This is
  what your traffic is grouped under in the Plausible dashboard, so it must match.
- **Host / tracking endpoint** — the Plausible instance the script talks to. Leave it
  at the default for **Plausible Cloud**, or point it at your own server if you run
  **self-hosted** Plausible. (If your setup includes a script/endpoint field, this is
  where the tracker's source and event URL are set.)

## Optional tracking features

Enable only what you need:

- **Track outbound link clicks** — record when visitors click links leading to other
  sites.
- **Enable file download tracking** — record downloads of files linked from your
  pages.
- **Track custom query params as pageview events** — treat particular URL query
  parameters as pageview events, useful for campaign or variant tracking.
- **Track custom events** — support Plausible custom events for goals and conversions
  you define.
- **Block IPs from tracking** — list IP addresses whose visits should be excluded
  (for example your own office or team), so internal traffic does not skew the numbers.

## Privacy note

Plausible is cookieless and does not collect personal data, which generally lowers the
consent burden — but still **disclose your use of analytics in your privacy policy**
and confirm your own compliance position. Remember the module loads Plausible's
third-party script.

## Save

Click **Save configuration**. Reload a front-end page and confirm tracking behaves as
configured, and that data appears in your Plausible dashboard.
