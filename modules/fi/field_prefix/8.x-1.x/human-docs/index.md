# Field Prefix — manual setup guide

**Field Prefix** (`field_prefix`) lets an administrator change or remove the
`field_` prefix that Drupal's **Field UI** automatically prepends to the machine
name of every new field. Out of the box, adding a field called "Subtitle" gives you
the machine name `field_subtitle`; with this module you can set a different prefix,
or clear it entirely so the field is simply `subtitle`. That is handy for teams with
their own naming conventions, or when you're re-creating a content model whose
machine names must match an existing schema, migration, or another environment.

The module is intentionally tiny: it adds a single settings form that edits the
`field_prefix` value in Field UI's own configuration (`field_ui.settings`). The
change applies to **fields you create afterwards** — existing fields keep their
current machine names.

The maintainers make an honest point worth repeating: because all this module does
is flip one core setting, you don't strictly need to keep it installed. You can set
your desired prefix, then uninstall the module, and the setting stays put — or make
the same change with Drush/Drupal Console without installing anything. Treat it as a
convenience for making the change through a UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set or clear the field prefix on the
   settings form.

## Where it lives in the admin menu

The settings form is at `admin/config/field_prefix/setting`
(`/admin/config/field_prefix/setting`). It is gated by the **Access administration
pages** permission.
