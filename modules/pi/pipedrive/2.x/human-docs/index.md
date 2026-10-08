# Pipedrive — manual setup guide

**Pipedrive** (`pipedrive`) integrates your Drupal site with the
[Pipedrive](https://www.pipedrive.com/) CRM. It connects to a Pipedrive account
through the Pipedrive API (using the vendor's PHP SDK) so your site can create and
sync CRM records — people, deals, activities, and more. A common use is turning a
Drupal form submission into a Pipedrive lead or deal, so your sales team sees it in
their pipeline without any manual re-entry.

The module is an **integration layer**: it pushes data from Drupal into Pipedrive.
It has no access-control role of its own. The most important things to get right are
around the API credentials and the data you send:

- The connection uses a **Pipedrive API token**. Treat it as a secret — never paste
  it into a configuration form that gets exported to code or committed to version
  control. Store it in an environment variable and reference it through the Key
  module. See [Configuration](configuration/index.md) for the recommended setup.
- The records you sync (contact and lead details) are **personal data**. They leave
  your site and are processed by Pipedrive, a third party. Make sure you have a
  lawful basis and consent where required, and disclose this data sharing in your
  privacy policy (GDPR and similar).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Pipedrive account and store
   the API token securely.

## How to use it

Once the API token is configured (see [Configuration](configuration/index.md)), the
module gives you access to the Pipedrive PHP SDK from Drupal, which you use to create
people, deals, and activities — typically from within a custom form handler or an
event that fires when content or a submission is created. The `2.x` branch is a
development release, so review its current capabilities against your needs before
relying on it in production.
