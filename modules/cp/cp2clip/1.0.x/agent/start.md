<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copy to Clipboard (cp2clip) — agent index

Adds a copy-to-clipboard button to any HTML element carrying the class `cp-to-clip`. Pure
front-end: no dependencies, no configuration, no permissions, no routes, no config schema.
Version **1.0.1-rc2**, core requirement `^10 || ^11`, package UI, not security-advisory covered.

## Mechanism (from source)
- `cp2clip.module` — `cp2clip_preprocess_page()` attaches the `cp2clip/cp2clip.global` library to
  **every page** via `#attached`; `hook_help()` provides the help text. Nothing else.
- `cp2clip.libraries.yml` — one library: `css/cp2clip.css` (component) + `js/cp2clip.js`, **no
  dependencies** (not even core/jquery, despite the `(function($){…})` wrapper).
- `js/cp2clip.js` — a plain **IIFE** (not a `Drupal.behaviors` callback). On load it
  `querySelectorAll('.cp-to-clip')`, and for each element: sets a `title`, appends a
  `<div class="copy_to_clipboard">` icon, and adds a **click listener on the whole element**. The
  handler runs `navigator.clipboard.writeText(parentElem.textContent.trim())`, adds the `copied`
  class (turns green, title "Copied!"), then `resetButtons()` clears the `copied` state on the other
  instances. What is copied is the element's trimmed `textContent` (plain text only).
- `css/cp2clip.css` — styles the marked block (pre-wrap, grey background, pointer cursor) and the
  icon (an inline base64 SVG). Runs once at load.

## How the class gets applied
No field/formatter/filter/CKEditor plugin is provided. An editor adds `cp-to-clip` manually in
HTML, or registers WYSIWYG styles (`p.cp-to-clip`, `span.cp-to-clip`, `div.cp-to-clip`) on a text
format's styles dropdown. Whichever tags a format allows and which roles may use that format is
governed entirely by core's text-format / filter system, not by this module.

## Caveats an agent should flag
1. **Accessibility.** The control is a `<div>`, not a `<button>`: not keyboard-focusable, no ARIA,
   no announced confirmation (only a colour/`title` change). Not usable by keyboard or AT.
2. **No `Drupal.behaviors`.** The IIFE runs a single time at initial load; elements added later by
   AJAX, Views infinite scroll, or a modal get **no** button.
3. **Secure context required.** `navigator.clipboard` is undefined over plain HTTP; copy fails
   silently (console error only).
4. Minor code smells: relies on the implicit global `event` inside an arrow handler; `element_class`
   / `btn_class` are implicit globals. Cosmetic, not security-relevant.

## Security
No server-side rendering of user/config input, no admin form, no stored settings; copied content is
client-side `textContent`. No XSS/CSRF surface introduced by the module. Clean.

## Docs in this set
- `usage/markup.md` — install/enable, applying the `cp-to-clip` class (raw HTML or WYSIWYG styles), runtime behaviour, operational caveats, tests.
- `../data.json` — metadata.
- `../usage.md` — short / dense / use-case bullets.
