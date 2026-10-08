# DICOM Visualization — manual setup guide

**DICOM Visualization** (`dicom_visualization`) turns an ordinary Drupal File
field into an interactive, in-browser viewer for **DICOM (.dcm)** medical imaging
files. Instead of asking site builders to create custom entities or install
external software, it renders standard file fields through a field formatter
powered by the industry-standard Cornerstone.js engine — giving researchers,
educators, and healthcare professionals clinical-style tools right inside your
content.

Out of the box it supports precision metadata overlays (over 45 DICOM tags such as
Patient ID, Modality, and Study Date, placed in any of the four viewport corners),
interactive diagnostics (scroll-to-zoom, window leveling for brightness/contrast,
and panning), a choice of 15+ pre-designed medical themes, and flexible display
modes (a vertical stack, a scrollable gallery, or individual standalone viewers).
It works with Drupal's core File field — you simply allow the `.dcm` extension and
switch the field's formatter.

Configuration is split in two: **global settings** (tag mappings, corner
placement, and overlay text colors) live at `/admin/dicom-configuration`, while
**per-field display settings** (theme and stacking) live on each File field's
Manage display tab. The module requires Drupal 9.3+ (10.3+/11 recommended), PHP
8.1+, and the core File module.

> **Handling medical data:** DICOM files are medical data and can embed patient
> identifiers (PHI) in their metadata. Store them under a **private file scheme**
> with proper access control — core public files are world-readable — and handle
> them in line with HIPAA/GDPR and your healthcare data policy. The module has no
> access control of its own; it relies on Drupal's file and entity access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — allow `.dcm` uploads, set the
   formatter, and adjust global and per-field display settings.

## Where it lives in the admin menu

Global settings — tag mappings, quadrant placement, and overlay text colors — are
at `/admin/dicom-configuration`. Per-field display options (theme, stacking) are
set on each File field under **Structure → Content types → [type] → Manage
display**.
