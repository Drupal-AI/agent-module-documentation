# LGMS — manual setup guide

**LGMS** (Library Guide Management System, machine name `lgmsmodule`) is a
web‑based tool for building, organizing, and sharing **research and library
guides** — the kind of subject guides you find on university library sites (often
called "LibGuides"). It lets library staff assemble rich guides without writing
any code, and gives students, faculty, and researchers a tidy way to browse them.

Under the hood, a guide is built from three content types that nest inside one
another: a **guide** contains **guide pages**, and each page holds **guide
boxes** — and boxes hold the actual content items (text, images, videos, links,
embedded media). Staff work from a dedicated **dashboard** where they create
guides, add and reorder boxes and items, reuse an existing guide as a starting
template, and publish browsable listings. Visitors can then browse guides by
**subject**, **type**, and **group**, view a databases listing page, and download
or print a guide.

LGMS is built for Drupal 10 and leans on core's **Media** and **Media Library**
so that adding images and video to a box is the same familiar experience as
anywhere else in Drupal. Note that on drupal.org this project's directory is
`lgms`, but the actual module machine name is **`lgmsmodule`** — that difference
matters when you enable it (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (mind the machine name), and pull in Media/Media Library.
2. [Configuration](configuration/index.md) — the settings form, the permissions
   that control who can build and see guides, and the categorization
   vocabularies.

## Where it lives in the admin menu

The module's settings form lives under **Configuration → System** at
`/admin/config/system/lgmsmodule` (route
`lgmsmodule.admin.config.system.lgmsmodule`), behind the **Administer site
configuration** permission. The day‑to‑day work, though, happens on the LGMS
**dashboard**, which is where staff create and manage guides.

## How to use it

1. Give library staff the right permissions (see
   [Configuration](configuration/index.md)) — chiefly **Access dashboard** and
   **Create guide content**.
2. From the dashboard, create a **guide**, then add **guide pages** to it, and
   **guide boxes** to each page.
3. Fill boxes with content items — text, links, and media added through the Media
   Library.
4. Reorder pages, boxes, and items until the guide reads the way you want, or
   reuse an existing guide as a template to save setup time.
5. Publish, and visitors browse the guides by subject, type, and group, or reach
   the databases listing and printable/downloadable versions.

Because the create/edit/delete forms check standard node update and delete access
on the guide being changed, editors only get to change guides they are actually
allowed to change.
