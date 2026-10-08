# Alertbox — manual setup guide

**Alertbox** (`alertbox`) creates alert boxes for displaying information banners
across your site. It is built on Drupal's core **custom block content**, so
editors manage alerts as block content and place them in theme regions using the
normal block system — a familiar workflow rather than a new one.

Because alerts are block content, you target where they appear using standard
block placement and visibility, and you can reuse block features you already
know. A central settings form controls the alertbox appearance and behavior, and
an optional submodule adds a modal display.

The optional **`alertbox_modal`** submodule shows an alert in a modal dialog
instead of an inline banner. Enable it when you want an alert to interrupt rather
than sit in a region.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (and its dependencies) and enable it, plus the optional modal submodule.
2. [Configuration](configuration/index.md) — the settings form, creating
   alertbox block content, and placing it.

## Where it lives in the admin menu

The settings form is at **Structure → Alertbox** (`/admin/structure/alertbox`)
and requires the **Administer alertbox** permission. See
[Configuration](configuration/index.md) for the workflow.
