# USWDS Ckeditor Integration — manual setup guide

**USWDS Ckeditor Integration** (`uswds_ckeditor_integration`) brings components from
the [U.S. Web Design System](https://designsystem.digital.gov/) (USWDS) into
CKEditor 5, so editors can build compliant, government-standard layouts and callouts
right inside the rich-text editor — without hand-writing USWDS classes and markup.

It adds a responsive column **grid** builder (a modal dialog for choosing columns and
per-breakpoint layouts), a USWDS **accordion** widget, USWDS **table** styling (mark a
table as sortable or as a stacked responsive table), and four **embedded-content**
components — **Accordion**, **Alerts**, **Process List**, and **Summary Box** — that
insert through the Embedded Content button. Two text-format **filters** finish the job
on save, adding the ARIA, scope, and `data-*` attributes that USWDS sortable and
stacked tables require (they also log accessibility warnings, for example when a
sortable table has no caption).

Component output is rendered through fixed Twig templates, so markup stays consistent
across authors, and USWDS's own front-end JavaScript is attached for the accordion
behavior. You enable the plugins and filters per text format and choose which columns
and breakpoints each format offers. A site-wide grid settings form defines the
available breakpoints, column counts, and layout presets. A submodule ships a
ready-made `uswds_paragraphs` text format that wires everything together with
paragraph embeds.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, note the
   dependencies, and enable the module (and optional submodule).
2. [Configuration](configuration/index.md) — enable the plugins/filters on a text
   format, and set up the grid layout matrix.

## Where it lives in the admin menu

- **Enable plugins & filters:** on a CKEditor 5 format at **Configuration → Content
  authoring → Text formats and editors** (`/admin/config/content/formats`).
- **Grid settings:** **Configuration → Content authoring → *(CKEditor USWDS grid)***
  (`/admin/config/content/ckeditor_uswds_ck_grid`).

## How to use it

The setup has two halves: on a **text format**, drag the USWDS buttons into the
CKEditor toolbar and enable the responsive-table filters; and on the **grid settings
form**, tune which breakpoints, column counts, and layout presets editors can pick.
Editors then use the toolbar buttons — the grid builder, accordion, table marker, and
embedded Alerts/Process List/Summary Box — to compose USWDS content. See
[Configuration](configuration/index.md) for the details.
