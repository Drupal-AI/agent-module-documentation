# No Non-breaking Space Filter — manual setup guide

**No Non-breaking Space Filter** (`no_nbsp`) cleans stray non-breaking spaces out
of your content. WYSIWYG editors like CKEditor, and content pasted from Microsoft
Word, PDFs, or other websites, love to sprinkle `&nbsp;` entities and raw U+00A0
characters through body copy. Those invisible characters cause awkward gaps
between words and stop text wrapping properly on small screens. This module
replaces every non-breaking space with an ordinary space and collapses any runs
of spaces down to a single space.

It gives you **two ways** to apply the cleanup, so you can pick whichever fits.
The first is a **text-format filter**: enable it on a text format (such as Basic
HTML) and everything rendered through that format is automatically cleaned. The
second is a **field formatter**: switch a single text field's display format to
"No Non-breaking Space Filter" and only that field is cleaned at display time,
leaving the stored content and the shared text format untouched. Both do exactly
the same cleaning under the hood.

The filter version has one option, **Preserve placeholders**, for the case where a
non-breaking space is being used deliberately as a spacer inside an otherwise-empty
tag (like `<p>&nbsp;</p>`) — turn it on to keep those. The module adds no settings
page of its own, no permissions, and no dependencies; you configure it entirely
through Drupal's normal text-format and field-display screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the filter/formatter plugin
ids and config paths — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no dedicated settings page for this module — you turn it on per text
format or per field, both described below.

## Where it lives in the admin menu

No Non-breaking Space Filter has no admin page of its own. You enable the **filter**
at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and you enable the **formatter** on a bundle's
**Manage display** screen (for example
`/admin/structure/types/manage/article/display`).

## How to use it

**Option A — clean everything in a text format (the filter).**

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   a format, for example **Basic HTML**.
2. Under **Enabled filters**, tick **No Non-breaking Space Filter**.
3. Optionally, in that filter's settings, tick **Preserve placeholders** if you
   want to keep deliberate spacers like `<p>&nbsp;</p>`. Left off (the default),
   all non-breaking spaces are removed.
4. Check the **Filter processing order** — the cleanup runs in that pipeline like
   any other filter — then **Save configuration**.

Any content rendered through that format is now cleaned automatically.

**Option B — clean a single field's output (the formatter).**

1. Go to the bundle's **Manage display** screen (for example
   `/admin/structure/types/manage/article/display`).
2. For the text field you want to tidy, set its **Format** to **No Non-breaking
   Space Filter**.
3. **Save**.

Only that field's displayed output is cleaned; its stored value and text format
stay exactly as they were. This is the right choice when you must not alter a
shared text format, or you only want the fix on one field. (Note the **Preserve
placeholders** option exists on the filter only, not the formatter.)
