# Multiselect — manual setup guide

**Multiselect** (`multiselect`) gives editors a friendlier way to pick several
values at once. Instead of a native multi‑select (the awkward ctrl‑click list) or a
tall column of checkboxes, it shows **two boxes side by side** — *Available
options* on the left, *Selected options* on the right — with **Add** and **Remove**
buttons to move choices between them. It's especially nice on fields with many
allowed values.

Under the hood it ships a field widget (id `multiselect`) that you can use on List
(text), List (integer), List (float), and Entity reference fields, plus a matching
`#type => 'multiselect'` Form API element so developers can reuse the same UI in
their own custom forms. A small JavaScript library moves options between the two
boxes and keeps a hidden real `<select>` in sync when the form is submitted, and the
widget preserves the order in which values were selected.

There is just **one global setting** — the pixel width of the select boxes
(default 250) — on a small admin form. Beyond that there are no per‑field settings
of its own (aside from core's size hint), no permissions, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the render element
and theming — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — attach the widget to a field and set
   the global box width.

## Where it lives in the admin menu

Two places: you attach the widget per field from a bundle's **Manage form display**
page (e.g. `/admin/structure/types/manage/article/form-display`), and you set the
one global width option at **Configuration → Content authoring → Multiselect**
(`/admin/config/content/multiselect`).
