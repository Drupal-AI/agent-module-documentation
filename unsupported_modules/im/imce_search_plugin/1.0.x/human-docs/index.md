# IMCE Search Plugin — manual setup guide

**IMCE Search Plugin** (`imce_search_plugin`) adds a search box to the
[IMCE](https://www.drupal.org/project/imce) file browser. IMCE is a folder
browser: it shows you the directory you happen to be in. That is fine for a few
dozen files, but once a media library grows into the hundreds — spread across
date‑based folders — finding an image means remembering which folder it landed in.
Editors respond by re‑uploading files they already have, and the library grows
faster than anyone can curate it.

This plugin adds the missing verb: **search**. You type a filename (or part of
one) and get results with visual **previews**, so the right file is identifiable at
a glance rather than by name alone, plus instant jump‑to‑file navigation and
highlighting of matches. Because it registers as a proper IMCE plugin, it appears
*inside* the browser your editors already use rather than as a separate screen.

Two things to know before you install. First, IMCE's own profile system still
governs scope — search only looks within the folders the user's IMCE profile
grants, never across the whole filesystem. Second, this is an early release
(**1.0.0‑beta2**), so it is worth testing against your real file volume before you
lean on it in a live editorial workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the
   project/module name difference) and enable it alongside IMCE.

There is **no configuration page** for this module — it has no settings form. Once
enabled, the search box simply appears in the IMCE browser.

## Where it lives in the admin menu

The plugin adds no admin page. It surfaces directly in the IMCE file browser
wherever that browser opens (file/image fields, the CKEditor image dialog, and so
on). IMCE itself is configured at **Configuration → Media → IMCE File Manager**
(`/admin/config/media/imce`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open any IMCE file browser as a user whose IMCE profile grants some folders.
3. Use the search box to find a file by name; matching results appear with
   previews, and you can jump straight to the file's location.

Remember that search respects IMCE profile restrictions — a user only finds files
in folders their profile already lets them browse.
