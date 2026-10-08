# Configuration

Advanced Text Formatter has no global settings screen. You configure it **per
field, per view mode**, on an entity's Manage display page. This page walks
through selecting the formatter and every option it offers.

## Select the formatter

1. Go to the Manage display page for the entity and view mode you want, for
   example **Structure → Content types → Article → Manage display**
   (`/admin/structure/types/manage/article/display`). Different view modes
   (Default, Teaser, etc.) each have their own display settings.
2. Find the text or string field's row.
3. In the **Format** column, choose **Advanced Text**.
4. Click the **gear/cog** icon at the end of the row to open the settings.
5. Set the options (below), click **Update**, then **Save**.

## The settings, field by field

### Trimming

- **Trim length** *(default 600)* — the maximum number of characters to display.
  Set it to `0` to disable trimming entirely (you can still use the filter, token,
  and link options).
- **Ellipsis** *(on by default)* — append `…` when the text was actually trimmed.
  Only relevant when trim length is above 0.
- **Word boundary** *(on by default)* — trim only at a word boundary so a word is
  never cut in half. Only relevant when trim length is above 0.

### Summary and tokens

- **Use summary** *(off by default)* — when the field item has a non-empty summary
  (as `text_with_summary` fields can), display the summary instead of the full
  value. Handy for listings.
- **Token replace** *(off by default)* — run the value through Drupal's token
  system before it is displayed, so placeholders like `[node:title]` or
  `[node:author:name]` are replaced with live values.

### Markup handling (the Filter option)

The **Filter** select decides how HTML in the value is treated. Choose one:

- **None** — output the raw value, with no filtering.
- **Selected text format** (the item's own format) *(default)* — run the text
  through whatever text format was chosen when the content was entered (core's
  normal behavior).
- **Limit allowed HTML tags** — strip the markup down to a specific list of
  allowed tags. This reveals two extra options:
  - **Allowed HTML tags** — the whitelist of tags to keep (default includes
    common inline and list tags such as `<a> <b> <em> <strong> <p> <ul> <li>`).
    Empty the list to remove all HTML.
  - **Convert line breaks into HTML** (auto-paragraph) — turn newlines into
    `<br>` / `<p>` tags.
- **A specific text format** — run the value through a named text format you pick
  (for example *Full HTML*), regardless of the format stored with the value. When
  you choose this, a **Text format** select appears for you to name the format.
- **PHP** — **deprecated**; it behaves like *Limit allowed HTML* and shows a
  warning. Do not use it.

### Linking

- **Link to the entity** *(off by default)* — wrap the rendered value in a link to
  its host entity (useful in listings where the whole snippet should be
  clickable).

## How the options combine

When the field renders, the formatter processes each value in this order: pick the
summary or the value → run token replacement → apply the chosen filter → trim to
length → optionally wrap in a link. Keeping that order in mind helps predict the
result — for example, trimming happens *after* filtering, so the character count
applies to the filtered output.

## Reuse across view modes and content types

Because these settings live on each field's display, you can give the same field
different treatment in different view modes — a short, trimmed teaser and the full
body on the default display — and apply the same settings pattern across many
content types for a consistent look.
