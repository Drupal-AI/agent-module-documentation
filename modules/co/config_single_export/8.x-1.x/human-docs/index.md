# Configuration Single Export — manual setup guide

**Configuration Single Export** (`config_single_export`) adds a **Download** button
to Drupal core's *single item* configuration export page. Out of the box, core
renders one configuration object's YAML into a textarea, which you then have to
select, copy, and paste into a correctly named file — and the right filename is the
part people most often get wrong, because it is not obvious from the contents. This
module lets you click once and receive the file, named correctly, instead.

It is a small quality-of-life tool for developers who move configuration between
sites, save config for a patch or a bug report, or keep individual config objects in
version control. It depends only on core's Configuration Manager module and adds no
settings of its own. This is the 8.x‑1.4 release, and the button appears on the
existing core export page rather than anywhere new in the admin menu.

The export page — and the download the button triggers — is reachable only by users
who hold core's **`export configuration`** permission, the same permission that
already governs the single-export screen. That permission is marked *restricted* in
core and should be granted only to trusted administrators; if you prefer the command
line, `drush config:export` covers the same ground.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has **no settings form** — it only adds a button to an existing core
page, so there is no configuration page.

## Where it lives in the admin menu

Once enabled, the Download button appears at the bottom of core's single-export
page at **Configuration → Development → Configuration synchronization → Export →
Single item**
(`/admin/config/development/configuration/single/export`).

## How to use it

1. Go to `/admin/config/development/configuration/single/export`.
2. Choose the configuration type and the specific configuration item you want to
   export.
3. Click the **Export** (download) button the module adds at the bottom of the page.
   Your browser downloads the selected configuration as a correctly named YAML file.

Access to that page requires the `export configuration` permission, a core
permission marked *restricted* — grant it only to trusted administrators.
