# Temporary Admin Login — manual setup guide

**Temporary Admin Login** (`temp_admin_login`) lets an administrator generate a
self‑expiring, token‑based login link. You pick a role and an expiry time, click
**Generate link**, and hand the resulting URL to someone — a developer who needs to
look at the site, or an editor reviewing work — who can then log in just by clicking
it, with no password. It depends only on Drupal core's **User** module and ships no
submodules.

Generating a link requires the **Administer site configuration** permission.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — generate a temporary login link.

## Where it lives in the admin menu

Once enabled, the link generator is at **Configuration → System → Generate
Temporary Admin Login Link**. You reach it from the admin menu under Configuration;
the module does not expose a separate settings page beyond this generator.
