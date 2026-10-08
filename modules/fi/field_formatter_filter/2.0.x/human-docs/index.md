# Field Formatter Filter — manual setup guide

**Field Formatter Filter** (`field_formatter_filter`) adds an "Additional Text
Filter/Format" option to text-field formatters on the **Manage display** screen.
It lets a particular view mode re-render a text field through a text format you
choose, instead of the format that was saved with the content.

The classic use is a "safe teaser": you want your body field to show its full
rich markup on the article page, but a stripped-down version — no headings, no
images, no block elements — in the Teaser view mode used on listings. Rather than
forcing editors to manage two formats, you keep them on one WYSIWYG format and let
this module apply a lighter format only when the Teaser (or any other) view mode
renders.

It's display-only: the stored field value and its own format never change, and it
does not bypass Drupal's text-format security. It simply swaps which
administrator-defined filter format runs at render time, for the one view mode you
configured. Everything is done through hooks — there are no plugins, no settings
page, and no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. The option appears inside the formatter
settings on the **Manage display** tab of any content type, taxonomy vocabulary,
etc. — for example
**Structure → Content types → (type) → Manage display → (a view mode)**
(`/admin/structure/types/manage/page/display/teaser`). You need core's **Field
UI** module enabled to edit it.

## How to use it

1. Prepare the text format you want to apply — for example a "Safe teaser" format
   at **Configuration → Content authoring → Text formats and editors** that strips
   the markup you don't want in listings.
2. Go to **Manage display** for the bundle and open the view mode you want to
   affect (e.g. Teaser).
3. Click the settings (gear) icon for a **text**, **text (formatted, long)**, or
   **text with summary** field.
4. In the settings you'll find **Additional Text Filter/Format**. Choose your
   format from the list (or leave it on `<none>` to do nothing).
5. Save the settings and the display. The Manage display summary line then shows
   the chosen format (e.g. "Text Format: Safe teaser").

From then on, that field in that view mode is re-processed through the format you
picked, while every other display keeps using the field's own stored format.

### Good to know

- It applies to **text**, **text_long**, and **text_with_summary** fields only.
- The selected format runs *instead of* the field's own format, not in addition.
  Pick a format that is itself safe and keep it simple — running two heavy filter
  chains can have side effects.
- If the format you selected is later deleted, the module logs a warning and falls
  back to default rendering, so nothing breaks.
- Set the option back to `<none>` to turn it off for that field/view mode.
- Note: this 2.0.x release ships only the formatter setting described here. The
  project README also mentions a "Remainder after trimming" formatter, but that
  formatter is **not** present in this version.
