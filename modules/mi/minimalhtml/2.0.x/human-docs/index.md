# Minimal HTML — manual setup guide

**Minimal HTML** (`minimalhtml`) provides a ready-made, deliberately restricted
WYSIWYG text format — one that allows only a handful of HTML tags (bold, links,
lists and similar basic formatting). It's designed for the many small places where
a full rich-text editor is overkill: short text fields, admin-configurable text
areas, settings blurbs, and similar. Because it permits so few tags, it is the
safer choice for those spots — a smaller allowed-tag list means a smaller
cross-site-scripting surface.

The real point of the module is to be a shared, reusable format. Instead of every
module (or every site build) defining its own near-identical "basic HTML" format
and ending up with duplicates, they can all depend on Minimal HTML and be sure an
appropriate format exists. It relies on WYSIWYG Linebreaks so the field stays easy
to edit even with CKEditor's rich-text editing switched off.

A submodule, **Minimal HTML Title** (`minimalhtmltitle`), provides an even more
restricted format intended for title-like text. It can be enabled and used
independently of the main module, so you can turn on either one or both.

Minimal HTML has no configuration screen of its own — it simply installs the text
format(s). Individual sites can always adjust the format afterwards through the
standard **Text formats and editors** admin, exactly like any other format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the Minimal HTML Title submodule.

There is **no dedicated configuration page** for this module. Enabling it creates
the text format; to tweak the allowed tags or the editor toolbar afterwards, use
the standard **Configuration → Content authoring → Text formats and editors**
screen.

## How to use it

Once enabled, the **Minimal HTML** format appears in the format selector beneath
any text area that offers it (and in the text-format list at
`/admin/config/content/formats`). Select it on the fields where you want limited,
safe formatting. If you are building a module or install profile that needs a
minimal format, declare a dependency on `minimalhtml` (and/or `minimalhtmltitle`)
rather than defining your own.
