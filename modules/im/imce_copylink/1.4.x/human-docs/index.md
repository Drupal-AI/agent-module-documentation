# IMCE Copy Link — manual setup guide

**IMCE Copy Link** (`imce_copylink`) adds a **Copy Link** button to the
[IMCE](https://www.drupal.org/project/imce) file manager. IMCE is the
long-standing file browser Drupal uses for picking files in editors and file
fields, and it does that job well — but it has never offered the adjacent task:
"I have this file, now I need its URL to paste somewhere else." Without a copy
control, editors either hunt through a preview's right-click menu or reconstruct
the files path by hand, both of which are fiddly and error-prone. This module puts
the URL one click away.

Select a file in IMCE and click **Copy Link**, and the file's URL is placed on
your clipboard, ready to paste into a Drupal text field, an email, a spreadsheet,
or another system. If no file is selected, it copies the URL of the current
directory instead. Whether the copied link is absolute or relative follows IMCE's
own **Enable absolute URLs** setting in its common settings.

Because it extends IMCE, its access follows IMCE's model: the button is turned on
per directory inside an **IMCE profile**, so which users see it is governed by the
IMCE profiles you assign to roles. Two things are worth knowing. Browsers only
allow clipboard access in a **secure context**, so on a site served over plain
HTTP the copy can fail silently — which on a local environment without TLS can
look like the module being broken when it is really browser policy. And on a
**private** file scheme, the copied URL is still access-controlled when someone
follows it, so copying a link does not hand out access to the file.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (IMCE is required).

There is **no separate settings form** for this module. You switch the button on
per directory inside an IMCE profile, described in "How to set it up" below.

## Where it lives in the admin menu

The button is enabled inside IMCE's own configuration at **Configuration → Media →
IMCE** (`/admin/config/media/imce`), on the profile you edit. The button itself
appears in the IMCE file browser's toolbar.

## How to set it up

1. Install and enable the module (see [Installation](installation/index.md)). IMCE
   must be installed and you should already have an IMCE profile.
2. Go to **Configuration → Media → IMCE** (`/admin/config/media/imce`).
3. Under **Configuration profiles**, click **Edit** on the appropriate profile.
4. Find the **Directories** section and tick the **Copy link** permission
   checkbox for the directories that should offer it.
5. Click **Save configuration**.
6. Open IMCE to test — a **Copy link** tab button now appears. Select a file,
   click it, then paste somewhere to confirm the file link is on your clipboard.

> **Absolute vs relative links.** Whether the copied URL is absolute or relative
> is controlled by the **Enable absolute URLs** flag in IMCE's **Common settings**
> at `/admin/config/media/imce`.
