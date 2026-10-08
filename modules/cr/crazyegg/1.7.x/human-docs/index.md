# Crazy Egg — manual setup guide

**Crazy Egg** (`crazyegg`) is the official module for adding your Crazy Egg
tracking snippet to a Drupal site. Crazy Egg provides heatmaps, scrollmaps,
session recordings, and A/B tests; this module injects the tracking script into
your pages so all of that works — without you hand‑editing any theme templates.

Setup is genuinely just entering your **account number**. From one settings form
you turn tracking on or off site‑wide, paste in your numeric Crazy Egg account
number, and the module builds and attaches the correct tracking script for you.
The script runs asynchronously in the visitor's browser; nothing is sent to Crazy
Egg from your server.

You also get simple targeting controls so tracking runs exactly where and for
whom you want. **Path targeting** lets you list the paths to track (leave it empty
to track the whole site, or list only your marketing landing pages). **Role
exclusions** let you leave out internal users — for example administrators and
editors — so your own traffic does not skew the data. And you can choose whether
the script loads in the page **header** (earliest load) or **footer** (less
render‑blocking).

Crazy Egg is a lightweight integration with no dependencies beyond Drupal core,
and it supports a very wide range of Drupal versions (8 through 12). It provides
one administrative permission so non‑developers can manage the tracking tag.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   account number, script location, path targeting, and role exclusions.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Crazy Egg**
(`/admin/config/system/crazyegg`), gated by the **Administer Crazy Egg**
permission.

## How to use it

Open the settings form, enter your Crazy Egg account number, make sure tracking is
enabled, and save. Optionally restrict which paths are tracked and exclude
internal roles. The tracking script then loads on the matching pages, and your
heatmaps and recordings begin populating in your Crazy Egg account. See
[Configuration](configuration/index.md) for the details.
