# DSFR for Drupal - Picker — manual setup guide

**DSFR for Drupal - Picker** (`dsfr4drupal_picker`) adds two new field types that
let editors **select icons and pictograms** from the DSFR — *Système de Design de
l'État*, the French State Design System. One field type is for **icons**, the
other for **pictograms**, both drawn from the official DSFR iconography.

Each field instance can be configured to limit its selection to one or more
specific **categories** of icon (or pictogram), so you can keep editors on the
right subset for a given field. Editors can also insert icons and pictograms
directly from **CKEditor** — the module adds two buttons to the editor toolbar
for that. Icon and pictogram detection is automatic, so there is **nothing extra
to do when you update the DSFR library** — new icons appear as they are added.

The module ships three optional submodules:

- **Examples** (`dsfr4drupal_picker_examples`) — example configuration to see the
  fields in action.
- **Link** (`dsfr4drupal_picker_link`) — integration for using the picker with
  links.
- **Media** (`dsfr4drupal_picker_media`) — adds a **Pictogram** media type
  (created automatically on install) so you can contribute your own custom
  pictograms.

One important dependency: the picker UI is built on the third‑party
**FontIconPicker** JavaScript library (jQuery‑based), which you must install into
your site's `libraries/` folder — see [Installation](installation/index.md). The
status report will warn you if the library is missing.

This module is part of the **DSFR for Drupal** suite, and it is strongly
recommended to use it alongside the base **DSFR for Drupal** theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   FontIconPicker library, then enable the module and any submodules.
2. [Configuration](configuration/index.md) — the module settings and the
   per‑field icon/pictogram category settings.

## Where it lives in the admin menu

The module has a settings form (route `dsfr4drupal_picker.settings`), reachable
from the module's **Configure** link on the **Extend** page (`/admin/modules`).
Most day‑to‑day configuration, though, is done **per field instance** on your
content type's **Manage fields** — see [Configuration](configuration/index.md).
