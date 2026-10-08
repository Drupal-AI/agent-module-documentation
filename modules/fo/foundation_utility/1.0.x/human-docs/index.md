# Foundation Utility — manual setup guide

**Foundation Utility** (`foundation_utility`) is a small collection of helpers for
sites themed with [ZURB Foundation](https://get.foundation/). Its headline feature
is a **text‑format filter** that cleans up and styles the tables your editors
produce in the WYSIWYG, so they look right in Foundation without anyone touching the
theme.

Editor‑produced tables — especially ones pasted from Word or Excel — tend to arrive
carrying inline `width`, `height`, and `style` attributes and missing Foundation's
own helper classes, which makes them render inconsistently and awkwardly on small
screens. The module's filter parses the saved HTML, walks every `<table>` (and its
cells, recursively), and rewrites the markup according to the options you tick:
adding Foundation table classes and optionally stripping the inline sizing and style
attributes for clean, responsive output.

Because it's a filter, you turn it on per **text format** and choose exactly which
transforms run there — so you can, for example, apply it to your editors' "Full
HTML" format but leave a restricted comment format alone. It only removes attributes
and appends classes; it never introduces new user‑controlled markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core's CKEditor 5 and Editor.
2. [Configuration](configuration/index.md) — enabling the table filter on a text
   format and the per‑format options, one by one.

## Where it lives in the admin menu

Foundation Utility adds no settings page of its own. You configure it entirely on
the standard **Text formats and editors** page at **Administration → Configuration
→ Content authoring → Text formats and editors**
(`/admin/config/content/formats`), by enabling and tuning its filter within each
format — see [Configuration](configuration/index.md).
