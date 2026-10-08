# Matomo Analytics — manual setup guide

**Matomo Analytics** (`matomo`) adds the Matomo (formerly Piwik) JavaScript
tracking snippet to your Drupal pages, with fine-grained control over which pages,
roles, and users are tracked and what extra data is sent.

You enter your Matomo **site ID** and **server URL** on the settings form, and the
module injects the correct tracking code into every page. From there, a generous
set of visibility rules decides where the snippet appears — by request path (allow
or deny lists), by user role, and by individual user account — plus a permission
that lets users opt in or out of being tracked themselves. Beyond plain page
views, Matomo can track outbound links, mailto links, downloads by file extension,
site-search queries, and Colorbox interactions, and set a hashed user ID so a
logged-in visitor's sessions are unified.

Privacy features include honoring the browser's Do Not Track signal and cookie-less
tracking for stricter compliance. Advanced options let you add custom
variables/dimensions, inject arbitrary JavaScript before or after the tracker, use
a page-title hierarchy so Matomo groups pages by structure, and cache the
`matomo.js` file locally (refreshed on cron) to avoid an external request. The
module integrates with core tokens, works under a Content-Security-Policy, and can
push a Matomo event from a View. A bundled **Matomo Tag Manager** submodule manages
MTM container snippets instead of the classic tracker.

Because all of this is stored as configuration (`matomo.settings`), your tracking
setup is exportable and deployable across dev, stage, and production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick up the Tag Manager submodule if you need it.
2. [Configuration](configuration/index.md) — the settings form, section by
   section, from server details to visibility, tracking, privacy, and advanced
   options.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Matomo**
(`/admin/config/system/matomo`) and is gated by the **Administer Matomo**
permission. Per-user opt-in/out and the JavaScript-snippet options are controlled
by their own permissions on the People → Permissions page.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form and enter your Matomo **site ID** and **server URL** —
   this is the minimum needed to start tracking.
3. Use the visibility, tracking, and privacy sections to decide exactly who and
   what is measured (see [Configuration](configuration/index.md)).
4. Save. The tracking snippet is added to matching pages immediately.
