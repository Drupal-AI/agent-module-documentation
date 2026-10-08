# File Widget Show Uploaded Time — manual setup guide

**File Widget Show Uploaded Time** (`file_widget_show_uploaded_time`) is a small
editorial-experience enhancement: it shows the **latest uploaded date** for each file
right in the file field widget, so content editors can see at a glance when a file was
last uploaded and judge whether it might be due for an update.

It's worth being precise about *where* the date appears. This affects the file field
**widget** — the control editors see on **content edit forms** (on media and other
entities) — **not** the file field **formatter** that displays files to site visitors.
In other words, it's a help for the people maintaining content, not something your
public audience sees.

Once installed, a site administrator switches a file field's widget to **"File showing
latest uploaded date"** on the entity's *Manage form display*, and picks the date/time
**format** used to show that timestamp to editors. The module depends on core **Field**
and **File**, and supports **Drupal 8 through 11**. It carries no content or
access-control role of its own. This release is a **beta** (`1.0.0-beta1`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** for this module. The one choice (the
date/time format) is a widget setting on *Manage form display*, described in "How to
use it" below.

## Where it lives in the admin menu

File Widget Show Uploaded Time adds no settings page of its own. You use it from
**Structure → *(entity type)* → *(bundle)* → Manage form display**, where you switch
a file field to its widget.

## How to use it

1. Go to the **Manage form display** for any entity type that has a file field — for
   example a **Media** type.
2. In the **Widget** dropdown for the file field, choose **File showing latest
   uploaded date**.
3. Click the field's **gear icon** and set the **date/time format** you want used to
   display the file's upload time to editors.
4. Click **Update**, then **Save** the form display.

From then on, when editors work with that field on a content edit form, they'll see
each file's latest uploaded date alongside it.
