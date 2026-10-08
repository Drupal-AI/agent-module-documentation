# Configuration

Concord Cookie Consent needs to know which Concord account/property to load, so
there is a short settings form to fill in before the banner will appear.

## Open the settings form

1. Log in as a user with the **Configure Concord Cookie Consent settings**
   permission (`concord_cookie_consent_settings`) — grant it under **People →
   Permissions** to trusted administrators only.
2. Open the module's settings form from the site's **Configuration** area.

## Connect your Concord account

Enter the connection details from your Concord account (the property/account
identifier Concord gives you for embedding its consent banner). This is what tells
the module which banner and consent configuration to load. Save the form.

Because these settings control an external script that runs on every page, keep
the configuration permission limited to administrators you trust.

## Confirm it gates your trackers

A consent banner is only compliant if the trackers it governs actually wait for
consent. After saving:

1. Load a page as an anonymous visitor and confirm the Concord banner appears.
2. Check that cookies/scripts you intend to gate (analytics, marketing tags, and
   so on) do **not** run until the visitor accepts them.
3. Review what data the Concord script sends to Concord's platform against your
   own privacy policy — this is a third-party integration, so consent choices and
   related data flow to Concord.

Adjust your tag/tracker setup as needed so the banner genuinely blocks trackers
prior to consent.
