<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime behavior of the Emoji button

This is a client-side CKEditor 5 plugin (`js/build/emojiPlugin.js`, pre-built and minified). There
is no server-side API to call — the notes below describe what the button does so an agent can
reason about it without reading the JS bundle.

## What happens when you click Emoji

1. The plugin registers a toolbar button (`Emoji`) that opens a **dropdown** panel.
2. The panel contains: a **search** input, a **category navigation** strip, and a scrollable
   **grid** of emoji with an info line showing the hovered/selected emoji's name.
3. Selecting an emoji executes CKEditor's built-in **`input`** command, inserting the emoji as a
   normal Unicode character at the cursor. It requires the core `Typing` plugin.

## Categories

Emoji are grouped (each is a source file under `js/ckeditor5_plugins/emojiPlugin/src/`):

- Smileys & People (`emoji-people.js`)
- Animals & Nature (`emoji-nature.js`)
- Food & Drink (`emoji-food.js`)
- Activity (`emoji-activity.js`)
- Travel & Places (`emoji-places.js`)
- Objects (`emoji-objects.js`)
- Symbols (`emoji-symbols.js`)
- Flags (`emoji-flags.js`)

An "All" group aggregates every category; the search box filters by emoji **title** (e.g. typing
"heart" surfaces heart-related emoji).

## Consequences for content and formats

- **No new markup.** The CKEditor5 plugin definition sets `elements: false`, so nothing is added to
  the format's allowed HTML — the emoji is saved as its Unicode character inside existing markup.
- **No data model / no upcast-downcast converters** beyond plain text insertion; there is no custom
  element, attribute, or widget.
- **No preprocessing on output.** Rendering the emoji depends only on the browser/OS font.
- The admin-only library `ckeditor_emoji/emoji.admin` just styles the button icon shown in the
  toolbar-configuration UI; it has no runtime effect on content.

## Libraries

- `ckeditor_emoji/emoji` — the plugin JS + theme CSS, depends on `core/ckeditor5`.
- `ckeditor_emoji/emoji.admin` — CSS for the button in the text-format config form only.
