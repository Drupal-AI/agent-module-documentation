# Configuration

CKEditor 5 Tooltip has no central settings form — the appearance and behaviour of
each tooltip are chosen per instance in the editor dialog. Your one-time setup is
two steps: enable the plugin on a text format and grant the permission.

## 1. Enable the Tooltip plugin per text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. **Configure** a format that uses CKEditor 5.
3. In the toolbar configuration, drag the **Tooltip** button from *Available
   buttons* into the *Active toolbar*.
4. Click **Save configuration**.

## 2. Grant the permission

This module provides its own permission that controls who may add tooltips.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the CKEditor 5 Tooltip permission and grant it to the role(s) that should
   be able to create tooltips.

## The per-tooltip options

Everything else is set **per tooltip** inside the modal dialog that opens from the
toolbar button. There is nothing to pre-configure here — this overview just shows
editors what they can control:

- **Style theme** — ten built-in themes: *Dark* (default), *Light*, *Info*,
  *Success*, *Warning*, *Danger*, *Glass*, *Bordered* (pick a border colour), and
  *Custom* (pick any background; text contrast is adjusted for WCAG), plus *None*
  to inherit the page styles.
- **Content** — plain text or limited HTML (bold, italic, underline, links,
  images, headings, lists, code, blockquotes, and more — 30+ allowed tags), with a
  live character counter up to 2,000 characters and automatic tag fixing. An
  optional heading can appear above the content.
- **Appearance** — font size (XS to 3XL, or inherit), font colour, text alignment,
  padding (compact/normal/spacious), corner radius, shadow, and opacity.
- **Behaviour** — trigger (hover on desktop, or click/tap; mobile always taps),
  position (top/bottom/left/right, auto-flipping near edges), max width, optional
  max height with scroll, one of nine entrance animations, and show/hide delays to
  prevent accidental or flickering popups.

A **live preview** updates in the dialog as options change, so editors see exactly
what visitors will see. Clicking an existing tooltip reopens the dialog with its
values filled in, and a **Remove Tooltip** button strips the widget back to plain
text.

## Save

There is no configuration form to save for this module beyond the text-format and
permissions changes above. Each tooltip is saved with the content it belongs to.
