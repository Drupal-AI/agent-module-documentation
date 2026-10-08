# Configuration

Mouseflow Tracking is configured on a single settings form: you paste your
Mouseflow tracking code, switch tracking on, and decide where it should and
shouldn't run.

## Get your tracking code from Mouseflow

Log in to your Mouseflow account and copy the **tracking code** (site ID) for
this website — it's available from the website list/dashboard (by clicking the
icon) or under **Settings → Tracking Code** once you open a specific website.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Mouseflow Tracking**
   (`/admin/config/system/mouseflow-tracking`).

## The settings

- **Tracking code / site ID** — paste the code copied from Mouseflow. This is
  what ties the injected script to your Mouseflow account/website.
- **Enable tracking** — the switch that actually starts adding the script to
  pages. Leave it off until you've reviewed the privacy steps below and set your
  exclusions.
- **Exclude admin pages** — keep tracking off administrative pages so back-end
  activity isn't recorded.
- **Restrict by page** — specify which pages tracking applies to (or which to
  exclude), using Drupal's usual path-matching, so you can limit recording to the
  parts of the site you care about.
- **Exclude IP addresses** — list IPs (for example your office/team) that should
  never be tracked, so internal sessions don't skew the data.

## Save

Save the form. Once tracking is enabled, load a front-end page and confirm the
Mouseflow script is present where expected (and absent on excluded pages/IPs) via
your browser's developer tools.

## Privacy — do this before enabling on a live site

Session recording is powerful and intrusive, so treat it responsibly:

- **Mask sensitive fields.** In Mouseflow, enable field masking/exclusions so
  passwords and personal data typed into forms are not captured.
- **Disclose it.** Mention Mouseflow session recording/heatmaps in your privacy
  policy.
- **Gate it behind consent.** Because this is third-party tracking, load it only
  after the visitor has consented, via your cookie/consent management
  (GDPR/CCPA). Combine that with the page/IP exclusions above.
