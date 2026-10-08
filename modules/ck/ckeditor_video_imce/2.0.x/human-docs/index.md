# CKEditor Video IMCE — manual setup guide

**CKEditor Video IMCE** (`ckeditor_video_imce`) adds a **video button** to
CKEditor 5 that uses the **IMCE file browser** to pick video files from your
server. Editors click the button, browse to a self-hosted video (and optionally a
poster image) with IMCE, and the module inserts an HTML5 `<video>` element into the
content. The insert dialog also supports common video attributes — source, poster,
autoplay, controls, loop, width, and height.

It is aimed at sites that host their own video files rather than embedding from an
external service: it streamlines dropping a local video into rich text. The module
depends on core's **CKEditor 5** and the contrib **IMCE** module. Because file
selection goes through IMCE, **which files an editor can browse and choose is
governed entirely by IMCE's own configuration and permissions** — so make sure
IMCE profiles are set up for the roles that will use the button.

There is no dedicated settings page for this module; setup is enabling the button
per text format (and having IMCE configured). The per-video attributes are chosen
each time in the insert dialog.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and IMCE with
   Composer and enable them.

There is **no configuration page** for this module itself. Setup is a per-format
toolbar step plus IMCE configuration, described below.

## Where it lives in the admin menu

CKEditor Video IMCE adds no settings page. The pieces you touch are:

- **Enable the button** — **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`): configure a CKEditor 5 format and
  drag the video button into the toolbar.
- **File browsing rules** — configured in **IMCE** at **Configuration → Media →
  IMCE File Manager** (`/admin/config/media/imce`), where you set which
  directories and file types each role may browse.

Once both are in place, editors click the video button, pick a file through IMCE,
set any attributes (poster, autoplay, controls, loop, width, height), and insert.
