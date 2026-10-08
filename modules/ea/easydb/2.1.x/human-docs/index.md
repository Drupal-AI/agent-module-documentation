# fylr File Picker — manual setup guide

**fylr File Picker** (`easydb`) connects Drupal to a **fylr** (formerly easydb)
digital asset management (DAM) system, so editors can browse assets in fylr, pick
the ones they need, and copy them — files *and* metadata — straight into Drupal
as media entities. It saves your team from downloading assets from the DAM and
re-uploading them into Drupal by hand.

Under the hood it ships an **Entity Browser widget** that opens the fylr picker
from a content edit form. When the editor confirms a selection, fylr sends the
files (or their download URLs) plus multilingual metadata to Drupal, and the
module creates or updates `easydb_image` media entities — installing fields for
title, caption, description, keywords, copyright, and the fylr asset UID, and
mapping fylr languages to Drupal languages so translations are created on
multilingual sites. Re-importing the same fylr asset updates the existing media
rather than duplicating it.

This is an integration module, so it does **not** work on enable alone: it needs
a bit of `services.yml` configuration, your fylr **server URL and credentials**
entered on its settings form, and the fylr Entity Browser added to a media or
entity-reference field. It requires the **Entity Browser** contrib module and
core **Media**, and works on Drupal 10.3+ or 11 (use the 2.0 branch for Drupal
9). Two permissions gate it: `administer easydb` for configuration and `access
easydb` for using the picker.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   `services.yml` lines, and enable the module.
2. [Configuration](configuration/index.md) — connect to your fylr server, store
   credentials safely, map languages, and add the picker to a field.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → fylr File Picker**
(`/admin/config/media/easydb`) and requires the **Administer easydb**
(`administer easydb`) permission. The picker itself is used from content edit
forms once you attach the fylr Entity Browser to a field.
