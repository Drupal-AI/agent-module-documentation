# CKEditor Heading Size — manual setup guide

**CKEditor Heading Size** (`ckeditor_heading_size`) adds a context menu that lets
an editor set a **font size** on a heading in CKEditor. The need behind it is real:
sometimes an `h2` is visually too large for a short section, or a landing‑page
subheading should look prominent without becoming a top‑level heading. This module
gives editors a way to make a heading's *size* differ from its *level* from a
right‑click context menu, and you define the size options it offers on a small
settings page.

It works with CKEditor across Drupal 9, 10, and 11 and has no module dependencies.

> **Read this before you enable it.** Varying heading size is also the exact point
> where sites tend to lose their heading structure — because the tempting shortcut
> is to pick the heading *level* that looks the right size rather than the one that
> is structurally correct. A page whose outline reads `h1, h4, h2, h4` (chosen by
> appearance) is meaningless to screen‑reader heading navigation, table‑of‑contents
> generation, and search. Whether this module helps or harms depends on **how** it
> applies the size: if it keeps the correct heading level and only varies the
> appearance (a size class on a correctly‑nested heading), it removes the incentive
> to misuse levels and is a genuine improvement; if it changes the tag or writes an
> inline `font-size`, it puts presentational styling into your content that a future
> redesign will fight. Check which it does on your content before relying on it, and
> for many sites a text format's **Styles** dropdown offering named classes
> expresses the same intent more safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define the font‑size options the
   context menu offers.

## Where it lives in the admin menu

Its settings form lives at **Administration → Configuration → Content authoring →
CKEditor Heading Size** (`/admin/config/content/ckeditor-heading-size`), where you
configure the available font‑size options.
