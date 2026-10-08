# Configuration

Adobe Analytics has a settings form where you connect Drupal to your Adobe
Analytics report suite. Once configured, the module emits the Adobe tracking
snippet on your pages automatically.

## Open the settings form

Open the module's Adobe Analytics settings as a user who holds the module's
configuration permission (see below). This is where you provide your tracking
details.

## Enter your tracking details

Supply the Adobe Analytics tracking configuration for your site — your report
suite / account details as provided by Adobe. This tells the module which report
suite to send page views and events to. Save the form, and the module injects the
Adobe Analytics / AppMeasurement snippet into your pages so tracking begins.

## Permissions

The module provides its own permission for managing the Adobe Analytics
configuration. On **People → Permissions** (`/admin/people/permissions`), grant it
only to the roles that should be able to change the tracking setup.

## Privacy and consent — handle before going live

This module loads a **third-party tracking script** that collects visitor
analytics and sends the data to **Adobe**. Before you publish it:

- **Disclose** the Adobe Analytics tracking in your site's privacy policy.
- **Gate it with consent** where required — analytics tracking is commonly
  consent-gated under regulations such as GDPR, so wire it to your consent /
  cookie-management tooling so it only runs when the visitor has agreed.

Verify on a non-production environment that data reaches your report suite and that
tracking respects your consent settings before enabling it on the live site.
