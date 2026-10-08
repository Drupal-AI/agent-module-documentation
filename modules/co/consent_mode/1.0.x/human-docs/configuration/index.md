# Configuration

The module works the moment it is enabled — every consent signal defaults to
denied. The settings form lets you turn the whole script on or off and, if you have
a reason to, change which signals start out granted.

## Open the settings form

1. Log in as a user with the **access consent mode config** permission. Because
   this permission is not marked restricted, you can grant it to a marketing role
   at **People → Permissions** without also giving "administer site
   configuration".
2. Navigate to `/admin/config/consent_mode`.

## The master switch

- **Enable Consent Mode** *(on by default)* — controls whether the
  `gtag('consent', 'default', …)` script is emitted at all. Turn it off to stop the
  module from writing anything to the page (for example on a property where you do
  not want any default declared).

## The six consent signals

Each signal is a checkbox, and **each defaults to denied**. Ticking a box sets that
signal's default to *granted*; leaving it unticked keeps it *denied*. The signals
are:

- **`ad_storage`** — storage related to advertising (e.g. ad cookies).
- **`analytics_storage`** — storage for analytics (e.g. visit measurement).
- **`ad_user_data`** — sending user data to Google for advertising.
- **`ad_personalization`** — personalised advertising / remarketing.
- **`functionality_storage`** — storage supporting site functionality.
- **`personalization_storage`** — storage supporting personalisation.

For EEA traffic the correct default is **denied for all of them**, which is the
shipped state — leave them unticked unless you have a specific, lawful reason to
default one to granted (for example on a non‑EEA‑only property).

## The essential pairing

This form sets **defaults only**. It never sends `gtag('consent', 'update')`. For
consent to actually be granted when a visitor agrees, you must run a consent banner
or CMP (Usercentrics, Cookiebot, or similar) that sends the update call. Without
one, the site denies by default and never grants — technically compliant, but your
analytics and ads reporting will read near zero. If you notice analytics suddenly
dropping to almost nothing after enabling this module, a missing or misconfigured
consent‑update from your CMP is the first thing to check.

## Save

Click **Save configuration**. The defaults are stored as configuration
(`consent_mode.settings`), so they deploy cleanly between environments. Reload a
page and inspect the source to confirm the emitted defaults match your choices.
