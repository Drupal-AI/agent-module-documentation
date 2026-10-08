# DSFR for Drupal - Picker — manual setup guide

**DSFR for Drupal - Picker** (`dsfr4drupal_picker`) adds two new field types that
let editors **select icons and pictograms** from the DSFR — *Système de Design de
l'État*, the French State Design System. One field type is for **icons**, the
other for **pictograms**, both drawn from the official DSFR iconography.

Each field instance can be configured to limit its selection to one or more
specific **categories** of icon (or pictogram), so you can keep editors on the
right subset for a given field. Editors can also insert icons and pictograms
directly from **CKEditor 5** — the module adds two buttons to the editor toolbar
for that, with matching text-format filters (`<dsfr-icon>`, `<dsfr-pictogram>`).
Icon and pictogram detection is automatic, so there is **nothing extra to do when
you update the DSFR library** — new icons appear as they are added.

The module ships three optional submodules:

- **Examples** (`dsfr4drupal_picker_examples`) — example configuration to see the
  fields in action.
- **Link** (`dsfr4drupal_picker_link`) — a link-icon widget so you can attach a
  DSFR icon to a link field.
- **Media** (`dsfr4drupal_picker_media`) — adds a **Pictogram** media type
  (created automatically on install), with a taxonomy vocabulary for categories,
  so you can contribute your own custom pictograms alongside the DSFR set.

Two dependencies matter. The picker UI is built on the third-party
**FontIconPicker** JavaScript library (jQuery-based), and the icons/pictograms
themselves come from the **DSFR** library (`@gouvfr/dsfr`). Both must be installed
into your site's `libraries/` folder — see [Installation](installation/index.md).
The status report warns you if either is missing. The module also needs PHP's
`iconv` extension.

This module is part of the **DSFR for Drupal** suite, and it is strongly
recommended to use it alongside the base **DSFR for Drupal** theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, the DSFR library
   and the FontIconPicker library, then enable the module and any submodules.
2. [Configuration](configuration/index.md) — the module settings and the
   per-field icon/pictogram category settings.

## Where it lives in the admin menu

The module has a settings form (route `dsfr4drupal_picker.settings`, at
`/admin/config/user-interface/dsfr4drupal-picker`), reachable from the module's
**Configure** link on the **Extend** page (`/admin/modules`). Most day-to-day
configuration, though, is done **per field instance** on your content type's
**Manage fields** — see [Configuration](configuration/index.md).

## What's new in 1.2.x

Version **1.2.0** targets **Drupal 10.3, 11 and 12** (`core_version_requirement:
^10.3 || ^11 || ^12`) and declares an explicit dependency on core **field**. The
release ships the DSFR library itself through `composer.libraries.json`
(`gouv/dsfr`) alongside FontIconPicker, and the status report now checks for
**both** libraries. Rendering is handled by Single-Directory Components (SDC) for
icons and pictograms.
