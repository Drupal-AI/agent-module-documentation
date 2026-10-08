# Sidenotes — manual setup guide

**Sidenotes** (`sidenotes`) lets editors add **Tufte-style sidenotes** — those little
notes that sit out in the margin next to the text they annotate, in the style Edward
Tufte made famous — directly in body text using simple markup. Instead of footnotes at
the bottom of a long article, a reader sees the note right beside the sentence it
belongs to, and on a narrow screen the notes gracefully fall back to something readable.

Authors write sidenotes with a small shortcode: wrap the note in `[sn]…[/sn]` or in
double parentheses `((…))`, and the module renders it in the margin. Notes can be
numbered or unnumbered, placed in the left or right margin, and shown either inline
after the reference or collected into an endnotes list — with the desktop layout done
purely in CSS and just a little JavaScript to handle mobile and reflow on resize.
Labels are flexible: you can use numbers, a set of classic symbols (`*`, `†`, `‡`, `§`,
`¶`, and so on), your own custom labels, or none at all, and you can override the label
on any individual note.

Getting it working takes two small setup steps beyond enabling it: you set your
site-wide defaults on the Sidenotes settings page, and you turn the **Sidenotes text
filter** on for the text formats where you want to use it (placing it after "Limit
allowed HTML" and "Convert line breaks"). It is purely a content-display and theming
feature — the sidenote text is just authored content rendered alongside the main text —
so it has no access-control role or security implications.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the defaults and enable the text
   filter.

## Where it lives in the admin menu

The defaults live at **Configuration → Content authoring → Sidenotes**
(`/admin/config/content/sidenotes`), and the filter is switched on per text format at
**Configuration → Content authoring → Text formats and editors**. See
[Configuration](configuration/index.md).
