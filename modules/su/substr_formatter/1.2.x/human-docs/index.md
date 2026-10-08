# Substr Formatter — manual setup guide

**Substr Formatter** (`substr_formatter`) is a field formatter that trims a string
field for display — cutting characters from the left or the right — using PHP's
`substr` function. It changes only how the value is shown; the value stored in the
database is left untouched.

The itch it scratches is that Drupal's built-in text formatters make it awkward to
trim from the *left*. Substr Formatter borrows PHP's `substr` directly, which turns
out to be a flexible way to do it: an **offset** decides where the visible portion
starts (and from which end), and an optional **length** caps how many characters
are shown. So for the string `abcdef`, an offset of `2` shows `cdef`, while an
offset of `-2` shows `ef`; add a length and you can narrow it further.

There is nothing to enable a settings page for — this is a display formatter you
choose on a field, so all of its configuration is the two small settings that
appear on the field's display. It depends on core's **Text** module and lives in
the Fields package. It is presentation-only and plays no content or access role.

This guide is written for a **human** setting the formatter up on a field. If you
are an AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Substr Formatter has no admin page of its own. You apply it to a string field's
display:

1. Go to **Structure → Content types → *(your type)* → Manage display** (or the
   *Manage display* tab of any entity type with a string field).
2. For the field you want trimmed, choose the **Substr** formatter from the format
   drop-down.
3. Open the formatter's settings (the gear icon) and set its two options:
   - **Offset** — where the visible text begins. A **positive** value trims from the
     *right* (keeps the start); a **negative** value trims from the *left* (keeps
     that many characters from the end). For `abcdef`: `2` gives `cdef`, `-2` gives
     `ef`.
   - **Length** — an optional fixed number of characters to keep from the offset
     point. For `abcdef` starting at offset `2`, a length of `1` gives `c`, while a
     length of `-1` gives `cde` (a negative length stops that many characters short
     of the end).
4. Save the display.

Because it only affects presentation, the underlying stored value is never
modified. If you are working in Views you could instead use Twig's slice filter in a
rewrite, but a field formatter like this is often smoother when you need to pass the
trimmed value on to other field-based tools (charts, calculations, and so on).
