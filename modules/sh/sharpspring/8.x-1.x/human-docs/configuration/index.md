# Configuration

SharpSpring is configured on its own settings form, where you connect the module to
your SharpSpring marketing account so the tracking JavaScript knows where to report.

## Open the settings form

1. Log in as a user with the module's configure permission (an administrator by
   default — SharpSpring provides its own permission, so you can review and delegate
   it at **People → Permissions**).
2. Go to the **SharpSpring** settings form (route `sharpspring.settings`), reached
   from the module's link in the site's Configuration area.

## Enter your SharpSpring account

On the settings form, supply your SharpSpring account / tracking details — the
identifiers SharpSpring gives you for embedding its tracking code. Save the form, and
the module begins adding the SharpSpring tracking JavaScript to every page, so
visitor activity is reported to your SharpSpring account for lead generation and
marketing automation.

## Privacy and consent

Because this loads a third-party tracker that follows your visitors, make sure you:

- Disclose the tracking in your site's privacy policy.
- Gate the tracking behind your cookie/consent mechanism where GDPR, CCPA, or similar
  rules apply, so it only runs for visitors who have consented.

The module's permission controls *who can configure* the tracker; it does not, by
itself, manage visitor consent — that is up to your consent tooling and policy.
