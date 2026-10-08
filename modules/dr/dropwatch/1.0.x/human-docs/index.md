# DropWatch — manual setup guide

**DropWatch** (`dropwatch`) is the client module that connects your Drupal site to
the [DropWatch](https://www.drupal.org/project/dropwatch) service. DropWatch is an
app that synchronises all of your Drupal sites' information into one place, so that
when security updates are released you can look in a single dashboard to see which
of your sites are affected — instead of checking each site's module list by hand.

In practice, this module sends site data (a telemetry/monitoring report of what's
installed and its update status) to the DropWatch service, where it's aggregated
for centralized oversight. The stated benefits are real‑time awareness of new
security patches, time saved by automating the manual "which sites need updating?"
check, and reduced risk from closing vulnerabilities sooner. A Slack integration
is listed as coming soon.

Using it **requires a DropWatch account** — the module is only the reporting
client; the dashboard and full setup instructions come with that account. Because
the module connects out to the service with a credential and reports information
about your site, keep that credential a secret, run the connection over HTTPS, and
be mindful of what data is sent (avoid pushing anything sensitive beyond what the
service needs).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Setup is completed by connecting the site to your DropWatch account using the
credentials and instructions DropWatch provides once you have access to the app;
the essentials, including handling the credential securely, are in "How to use it"
below.

## Where it lives in the admin menu

DropWatch is a reporting client rather than a feature with a rich admin UI. It
provides its own permission (on **People → Permissions**) for administering the
connection. The authoritative, step‑by‑step configuration is documented within the
DropWatch app itself once your account is set up.

## How to use it

1. Sign up for a **DropWatch account** and get access to the app.
2. Install and enable this module (see [Installation](installation/index.md)).
3. Connect the site to DropWatch using the credential/token from your account,
   following the setup instructions the app provides.
4. **Add the DropWatch token to `settings.php`.** The module reads the token from
   Drupal's `$settings` array — the key is `dropwatch_api_token` — not from the
   database, so the value never enters exported configuration:

   ```php
   $settings['dropwatch_api_token'] = '<your-token>';
   ```

   The module's settings form displays this exact snippet for you to copy. Keep
   `settings.php` (and any secret it holds) out of version control.
5. Confirm the site appears in your DropWatch dashboard and is reporting its
   status. Keep the connection on HTTPS and avoid sending sensitive data.
