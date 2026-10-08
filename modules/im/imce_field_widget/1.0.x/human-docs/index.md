# IMCE Field Widget — manual setup guide

**IMCE Field Widget** (`imce_field_widget`) lets editors fill in a media field by
picking a file through the [IMCE](https://www.drupal.org/project/imce) file
browser. It is a **field widget** for single-value media reference fields: instead
of the standard media selection, the field shows a **Select Media** button that
opens IMCE in a modal dialog, where the editor browses to a file and chooses it.
The selection then appears with a preview and a remove option, so the workflow
feels like the familiar IMCE experience many editors already know.

It is deliberately focused. It works **only with single-value media entity
reference fields** (cardinality 1), and it leans on IMCE for everything about file
access — which files an editor can browse and select is governed by IMCE's own
profile and folder permissions, exactly as elsewhere in IMCE. The widget adds
proper required-field validation with visual error indicators, keeps a user's
selection intact when other fields on the form fail validation, and supports both
public and private file schemes (you choose which in the widget settings). It is
translation-ready and does not itself add any access-control role.

There is no global settings page: you turn it on per field, on that field's form
display, exactly like any other widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Media and IMCE are required).

There is **no separate settings form** for this module. You select and configure
the widget on a media field's form display, described in "How to set it up" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types → *(your type)* → Manage form display**, where you set a single-value media
field's widget to **IMCE Field Widget**. It relies on IMCE being configured at
**Configuration → Media → IMCE** (`/admin/config/media/imce`).

## How to set it up

1. Install and enable the module (see [Installation](installation/index.md)).
   Media and IMCE must be installed, and IMCE must be configured for the file
   scheme you intend to use.
2. Make sure the field you want is a **single-value media entity reference field**
   (cardinality 1). Create one under the content type's **Fields** if needed.
3. Go to the content type's **Manage form display** (for example **Structure →
   Content types → Article → Manage form display**).
4. For that media field, change the **Widget** to **IMCE Field Widget**.
5. Open the widget's settings (the gear icon) and choose the **file scheme**
   (public or private) the widget should browse. Save.
6. Add or edit content of that type: the field now shows a **Select Media** button
   that opens IMCE in a modal for choosing a file.

> **IMCE governs access.** Which files an editor can browse and select comes
> entirely from IMCE's profile and folder permissions, so make sure IMCE is set up
> for the scheme you chose above.
