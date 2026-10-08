# SMSOL (Searchable Multi‑Select Option List) — manual setup guide

**SMSOL** (`smsol`) — short for *Searchable Multi‑Select Option List* — provides a
form widget that turns an ordinary select/option list into a **searchable
multi‑select**. Backed by a jQuery plugin, it enhances the HTML select element so
that when a field has many possible options, an editor can type to filter and
pick several values without holding down Ctrl. The result is fully stylable with
CSS.

It's a content‑editing / form‑widget module: you choose the SMSOL widget on a
field's form display, and selection then follows Drupal's normal field handling.
The module plays no role in access control. It has no dependencies beyond Drupal
core (10 or 11) and no submodules. The benefits it advertises are fully
searchable options, various ways of loading the option data, easy multi‑select
with no Ctrl key needed, and full CSS styling.

This guide is written for a **human** configuring the widget through the admin
UI. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module exposes a settings page at
**`/admin/config/system/sol-settings`**. Its main use, though, is as a **widget**
you assign to a field.

## How to use it

Add or edit a multi‑value option field (for example a list or entity‑reference
field) on a content type, then go to that content type's **Manage form display**
and select the SMSOL searchable multi‑select widget for the field. Editors will
then get a type‑to‑filter, click‑to‑select control when editing content.
