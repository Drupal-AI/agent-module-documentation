# Hide format info (former Allowed Formats) — manual setup guide

**Hide format info** (`allowed_formats`) tidies up the text-format selector that
Drupal shows beneath rich-text fields. Under a *Body* field (or any `text`,
`text_long`, or `text_with_summary` field) Drupal normally prints an *About text
formats* help link and a block of format guidelines describing what HTML the
chosen format allows. For non-technical editors that explanation is often just
clutter. This module lets you hide the help link, hide the guidelines, or both —
one field widget at a time.

If you used the old 1.x/2.x branch to *restrict* which text formats a field
offered, note that this is no longer the module's job: since Drupal 10.1 that
restriction is a built-in core field setting. The 3.x branch drops the
restriction feature and focuses on cleaning up the UI, while automatically
migrating any legacy allowed-formats settings you had into the core field
setting so nothing breaks on upgrade.

There is **no admin settings page** and no permissions to configure. Everything
lives on the **Manage form display** screen, per field: you enable the module,
then tick a checkbox or two on the fields you want to tidy. The module depends
only on core's **Field** (`field`) and **Filter** (`filter`) modules, which a
standard site already has, and it ships config schema so your choices export
cleanly with your form-display configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per‑field widget checkboxes on
   Manage form display, field by field.

## Where it lives in the admin menu

This module has no configuration page of its own (`configure` is null). Its
settings are **third‑party widget settings** that appear on the form‑display
editor for each content type or entity bundle: **Structure → Content types →
*(your type)* → Manage form display**
(`/admin/structure/types/manage/{bundle}/form-display`). Click the gear/settings
icon on a formatted‑text field's widget and you'll find the two checkboxes. See
[Configuration](configuration/index.md) for the details.
