# Strip Filter — manual setup guide

**Strip Filter** (`strippfilter`) is a text-format filter that strips the opening
and closing paragraph tags (`<p>` and `</p>`) from filtered output, so you can
create a text format that produces genuinely *inline* WYSIWYG output. Editors
still get the comfort of CKEditor 5, but the wrapping paragraph tags that CKEditor
insists on adding are removed on output — which is exactly what you want for
short, inline pieces of text like a caption, a title line, or a credit.

The problem it solves is a specific CKEditor 5 annoyance: the editor forces
paragraph tags around content, and core's own "Strip HTML tags" filter is no help
here, because it removes the text *between* the tags too, leaving you with empty
strings. Strip Filter removes only the paragraph tags themselves and keeps the
content, so you can build, for example, a three-part caption — a bold title, then
a caption that allows inline bold or italic but no paragraph breaks, then an
always-italic credit — each part editable in CKEditor without being stuck with
block-level paragraph wrapping.

Because it only *removes* markup rather than adding any, it introduces no
cross-site-scripting surface — stripping tags is safe. The one thing to confirm is
that it strips only what you intend: it is designed to remove paragraph tags, and
you should check the result on your content, since over-stripping can break the
structure you meant to keep.

Strip Filter depends on core's **Filter** module and works with Drupal 8, 9, 10,
and 11. It pairs naturally with core CKEditor 5, which is its main use case, and
with the Textarea widget for text fields. It works entirely as a filter you enable
on a text format — there is no separate settings form of its own.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Strip Filter has no configuration page of its own; you switch it on within a text
format:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Create or edit the text format you want to make always-inline.
3. Enable the **Strip paragraph tags** filter, and make sure it is ordered to run
   **last** among the format's filters.
4. For the fields that should use this inline behavior, set their **allowed
   formats** to only this format, and in the form display set the textarea to just
   one or two lines.

From then on, any content rendered through that format has its paragraph tags
stripped on output, giving you clean inline text.
