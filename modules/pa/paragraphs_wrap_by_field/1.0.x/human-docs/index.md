# Paragraphs wrap by field — manual setup guide

**Paragraphs wrap by field** (`paragraphs_wrap_by_field`) adds a Paragraphs field
formatter that **wraps consecutive paragraphs in a single `<div>`** based on a
field value they share. This lets you build grouped or multi‑column layouts by
*tagging* paragraphs with a value, rather than nesting them inside a container
paragraph. Paragraphs that sit next to each other and carry the same value get
grouped into one wrapping element in the rendered output.

For example, if you add a list field to your paragraphs offering options like
`bg-black` and `bg-red`, then set several adjacent paragraphs to `bg-black`, the
formatter wraps them together in a div such as `pw-group pw-group--bg-black` that
your theme can then style as a row or coloured band. It affects only how
paragraphs are wrapped in output — it does not change the paragraphs themselves or
their access. It is inspired by the Paragraphs theme wrapper approach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no global settings page** for this module — everything is set up on the
field's display and on the paragraphs themselves, described in "How to use it"
below.

## How to use it

1. **Create the driver field.** On your paragraph type, add a **List (text)**
   field (for example `field_bg_color`) and give it the options you want to group
   by, in `key|label` form, for example:

   ```
   bg_black|bg-black
   bg_red|bg-red
   ```

2. **Add the formatter.** Go to **Structure → Content types → *(your type)* →
   Manage display**, set your Paragraphs field's **Format** to the one this module
   provides, and in its settings **select the field that drives the wrapping**
   (for example `field_bg_color`).

3. **Tag your paragraphs.** When editing content, set the *same* value (for
   example `bg-black`) on the consecutive paragraphs you want grouped together.
   The paragraphs must be adjacent (in a row) for them to be wrapped as one group.

4. **Check the front end.** The grouped paragraphs are wrapped in a div named like
   `pw-group pw-group--bg-black`, which your theme's CSS can target to lay them out
   as a row, columns, or a styled band.
