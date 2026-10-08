# IMCE Private Public Buttons — manual setup guide

**IMCE Private Public Buttons** (`imce_private`) adds CKEditor 5 toolbar buttons —
and matching admin tabs — that open the IMCE file manager against the **private**
and **public** file schemes, so editors can insert links and images from a file
system other than the default one. Core IMCE and its CKEditor integration browse a
single (usually public) scheme; this small add‑on exposes both, which is exactly
what you need on a site that stores uploads privately or keeps embargoed/draft
assets in the private filesystem.

It provides four CKEditor 5 plugins — Imce Private Image, Imce Private Link, Imce
Public Image, and Imce Public Link — that you drag into a text format's toolbar.
Each makes the editor's image or link picker open IMCE at `private://` or
`public://`. It also adds two local‑task tabs ("IMCE public" and "IMCE private")
under *Content* for opening the file manager directly, and wires private‑file
browsing into the core editor image and link dialogs.

One important point about security: **this module does not enforce any access
control itself.** Whether a user may actually browse or read a scheme is decided by
IMCE core, based on whether that user's role has an IMCE profile assigned for that
scheme (configured under IMCE's own settings). So the private buttons only work for
users whose roles have been granted a private‑scheme IMCE profile, and private file
downloads still go through Drupal's private‑file access pipeline. The project
recommends the *Private files download permission* module for defining
private‑filesystem download rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the buttons to a text format and
   make sure IMCE grants the right scheme access.

## Where it lives in the admin menu

There is no dedicated settings page. You add the buttons at **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and the underlying scheme access is governed by
**Configuration → Media → IMCE** (`/admin/config/media/imce`). The module also adds
**IMCE public** / **IMCE private** tabs under **Content** (`/admin/content`).
