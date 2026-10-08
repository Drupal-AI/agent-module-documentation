# H5P — manual setup guide

**H5P** (`h5p`) brings rich, interactive HTML5 content — quizzes, interactive
video, course presentations, drag‑and‑drop games, and dozens more types — into
Drupal. It integrates the open‑source [H5P](https://h5p.org) framework and gives
you an **H5P field** you can add to any content type; each field holds one piece of
interactive content that renders right in the page.

There are two ways to get content into an H5P field. You can **upload** a `.h5p`
package exported from another site or from H5P.org, or — with the companion **H5P
Editor** submodule enabled — **author** content directly in the browser and pull
new content types from the **H5P Hub**. Either way, the interactive types
("libraries") you install are managed centrally, so once a type is installed any
author can create content with it.

H5P is a natural fit for e‑learning: build a lesson node with an interactive video,
track learner results over xAPI to a Learning Record Store, and let learners resume
where they left off. A set of permissions controls who can manage libraries, who
can see results, and who can copy, download, or embed content, and a global
settings form controls display options, storage, and Hub behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHP
   libraries with Composer, enable it, and add the H5P Editor submodule for
   in‑browser authoring.
2. [Configuration](configuration/index.md) — installing interactive content types
   (libraries), the global settings form field by field, and the permissions.

## Where it lives in the admin menu

- **Interactive content types (libraries)** are managed at **Content → H5P Content**
  (`/admin/content/h5p`) — upload `.h5p` packages, install from the Hub, and upgrade
  or remove types.
- **Global settings** live at **Configuration → System → H5P**
  (`/admin/config/system/h5p`).

## How to use it

### 1. Install some content types

Before authors can create interactive content, at least one content‑type library
must be installed. Go to **Content → H5P Content** (`/admin/content/h5p`) and either
upload a `.h5p` package or — with the H5P Editor submodule enabled — install a type
from the H5P Hub.

### 2. Add an H5P field

1. Edit a content type under **Structure → Content types → Manage fields**.
2. Add a field of type **Interactive Content – H5P**.
3. On **Manage form display**, choose the widget:
   - **Upload** — authors upload a `.h5p` package.
   - **Editor** — authors build content in the browser (needs the H5P Editor
     submodule).

### 3. Create content

Edit a node of that type, upload or author your interactive content, and save. The
H5P formatter renders it on the page. You can also embed a piece of content on an
external site via its embed URL, when the Embed button is enabled.
