# Configuration

Before Piano Analytics records anything, you need to tell it which Piano account
to send data to. You do this on the module's settings form, reached from its
**Configure** link on the **Extend** page (or under **Configuration**). You'll
need the **Administer site configuration** permission (an administrator by
default) — the module also defines its own permission for its features.

## Core tracking settings

- **Site ID** — the numeric identifier of your Piano Analytics / AT Internet
  site. This is the single most important field: without it, the tracker has
  nowhere to send data. Copy it from your Piano account.
- **Collection domain** — the Piano collection endpoint (the hostname events are
  sent to) for your account/region. Piano provides this value; enter it exactly as
  given so hits reach the right collector.

Save the form, and the client‑side tracker begins loading on your pages using
those values.

## Server‑side tracking credentials (Piano Analytics Server submodule)

If you enabled the **Piano Analytics Server** submodule, server‑side event
sending needs **Piano API credentials**. Treat these as secrets — never hard‑code
them in code or commit them to version control.

The recommended pattern on this project is to store the value in an environment
variable and reference it through a Key entity:

1. Save the secret into DDEV's dotenv file (the flag name becomes the variable
   name):

   ```bash
   ddev dotenv set .ddev/.env --piano-api-key=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$PIANO_API_KEY"'   # exit status 0 means it is set
   ```

3. If the Key module isn't already enabled, add it
   (`ddev composer require drupal/key && ddev drush en key -y`), then create an
   env‑backed Key and select that Key on the Piano Analytics settings form
   wherever it asks for the API credential.

## Opt‑out block (visitor consent)

Piano Analytics enables **visitor tracking**, which is a GDPR / privacy
consideration. From version 2.2 the module provides an **opt‑out block** with a
checkbox that lets visitors decline tracking. Place it from **Structure → Block
layout** somewhere visible (for example a footer or a privacy page), and pair the
whole integration with your consent‑management tooling so the tracker only fires
when the visitor has consented. Review exactly what data you send to Piano before
going live.

## Save

Click **Save configuration**. Once the site ID (and, for server‑side tracking, the
credentials) are in place, tracking is active — verify a hit reaches your Piano
dashboard as described in [Installation](../installation/index.md).
