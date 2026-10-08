# Configuration

There are two parts to setting up CKEditor Tooltips: (1) add the tooltip button to
the text formats that should offer it, and (2) optionally tune how tooltips look
and behave using the global settings form. The global settings apply to **every**
tooltip on the front end — they are not per‑format.

## Step 1 — Add the button to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 5**.
2. In the toolbar configuration, drag the **CKEditor Tooltips** icon from
   *Available buttons* into the **Active toolbar**.
3. Save. The module automatically extends that format's allowed HTML so the
   tooltip `<span>` markup is permitted.

Editors using that format can now select text and click the tooltip icon to enter
tooltip content, or click with nothing selected to insert a default "i" info icon.

## Step 2 — Global tooltip settings

Go to **Configuration → Content authoring → CKEditor Tooltips**
(`/admin/config/content/ckeditor-tooltips`). You need the *Administer CKEditor
tooltips* permission (`administer ckeditor tooltips`). Each option maps to a
Tippy.js setting:

- **Follow cursor** *(default: Default/off)* — whether the tooltip follows the
  mouse. Options are Default (off), Initial (positions at the initial cursor
  point), both axes, horizontal only, or vertical only.
- **Prevent overflow** *(default: off)* — keeps the tooltip from spilling past the
  edge of the viewport (adds Popper's `preventOverflow` behaviour).
- **Allow HTML** *(default: on)* — renders tooltip content as HTML rather than
  plain text.
- **Interactive** *(default: on)* — lets users move the mouse into the tooltip and
  interact with it (e.g. click a link inside) without it disappearing.
- **Max width** *(default: 500)* — the maximum width of the tooltip, in pixels.
- **Skidding** *(default: 0)* — shifts the tooltip along the reference element
  (the first offset value).
- **Distance** *(default: 15)* — the gap between the tooltip and the text it's
  attached to (the second offset value).
- **Trigger** *(default: Click)* — the event that shows the tooltip: **Click**,
  **Mouseenter** (hover), **Manual**, **Focus**, or **Focusin**. Choosing
  `focus`/`focusin` makes tooltips reachable by keyboard, which is more
  accessible.
- **Animations** *(default: Scale)* — the show/hide animation: **None**, **Fade**,
  or **Scale**.
- **Custom styling** *(default: off)* — when turned on, the module's bundled
  tooltip CSS is **not** loaded, so your theme can style the tooltips from
  scratch. If you toggle this, clear caches so the change to loaded assets takes
  effect.

Click **Save configuration** when done. The settings are written into
`drupalSettings` and picked up by the front‑end script on the next page load.

## Things to be aware of

- **Settings are global, not per‑format.** You can't have different tooltip
  behaviour for two different text formats — the last saved settings apply
  everywhere.
- **No config schema ships with this version.** This is a known TODO in the
  module. In practice it means some values are stored as untyped strings and you
  may see schema‑checker warnings in automated tests — harmless for normal site
  use, but worth knowing.
- If tooltips don't appear after changing **Custom styling** or the animation,
  clear the Drupal cache so the attached libraries refresh.
