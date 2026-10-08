# Field Formatter Theme — manual setup guide

**Field Formatter Theme** (`field_formatter_theme`) lets site builders add custom
**theme (template) suggestions** to a field's formatter, straight from the Field
UI. Drupal already generates a set of template suggestions for every field, but
sometimes you want a *dedicated* template for one field's output. This module adds
a small text box to each field's formatter settings where you type one or more
suggestion terms; those terms become additional field theme suggestions, so your
theme can supply a matching template and style that field's markup on its own.

It is a theming convenience for front‑end developers and site builders. It only
adds template suggestions — it changes no content, adds no permissions, and needs
no site‑wide configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site‑wide configuration page** for this module. You add theme
suggestions per field, on the entity display form, described below.

## Where it lives in the admin menu

Field Formatter Theme adds no admin page of its own. You configure it from the
Field UI: **Structure → Content types → *(type)* → Manage display**
(`/admin/structure/types/manage/{type}/display`), and likewise on the Manage
display form of users and other entities.

## How to use it

1. Go to the **Manage display** tab for your entity.
2. For the field you want to theme, click the formatter settings edit button (the
   gear‑wheel icon).
3. In the text box the module adds, enter a **space‑separated list of terms**.
   Each term is added as a field theme suggestion.
4. Click **Update**, then **Save**.
5. In your theme, add a template file matching one of the new suggestions to give
   that field its own markup.
