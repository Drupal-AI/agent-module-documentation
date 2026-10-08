<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cp2clip — applying the marker class and operating the button

Shorter than reading `cp2clip.module`, `cp2clip.libraries.yml`, `js/cp2clip.js` and
`css/cp2clip.css`. Cites those files.

## Install / enable
`composer require drupal/cp2clip`, then enable (Extend or `drush en cp2clip`). Nothing else to
set up: there is no install/update hook logic (`cp2clip.install` is an empty file header), no
config, no permissions, no routes, no services, no plugins. Uninstall just detaches the library.

## What enabling does
`cp2clip_preprocess_page(array &$variables)` in `cp2clip.module` unconditionally appends
`$variables['#attached']['library'][] = 'cp2clip/cp2clip.global'` — so the library loads on
**every page for every user** (no permission gate, no route restriction). The library
`cp2clip.global` (in `cp2clip.libraries.yml`) pulls `css/cp2clip.css` (component weight) and
`js/cp2clip.js` and declares **no dependencies** (not core/jquery, despite the `(function($){…})`
IIFE wrapper — `$` is never actually used).

`cp2clip_help()` provides help text at `help.page.cp2clip` only.

## Applying the class
There is no field, formatter, filter or CKEditor plugin. The trigger is entirely the CSS class
`cp-to-clip` present in rendered markup. Two ways to get it there:

1. Author raw HTML in body/text: `<div class="cp-to-clip">TEXT</div>`, `<pre class="cp-to-clip">…</pre>`,
   `<span class="cp-to-clip">…</span>` — any block or inline element. The text format must allow the
   tag and the `class` attribute (e.g. Full HTML, or an allowed-tags list that permits `class`).
2. From a WYSIWYG without hand-editing HTML: edit a text format
   (`/admin/config/content/formats/manage/<format>`), add the **Styles** dropdown to the CKEditor 5
   toolbar, and register style entries, one per line, e.g.:
   ```
   p.cp-to-clip   |p copy to clipboard
   span.cp-to-clip|span copy to clipboard
   div.cp-to-clip |div copy to clipboard
   ```
   Editors then pick the style to tag a selection. Which tags/classes survive output, and which
   roles may use the format, are governed by core's filter/text-format system — not by this module.

## Runtime behaviour (`js/cp2clip.js`)
The script is a plain **IIFE that runs once at initial load** (it is *not* registered as a
`Drupal.behaviors` callback). It `document.querySelectorAll('.cp-to-clip')` and for each element:
- sets `title="Click to copy to Clipboard."`,
- creates and appends `<div class="copy_to_clipboard">` (the SVG icon, styled by CSS),
- adds a `click` listener on the **whole element**.

On click it runs `await navigator.clipboard.writeText(parentElem.textContent.trim())` — so what is
copied is the element's own **trimmed `textContent` (plain text)**, never HTML or attributes. On
success it adds the `copied` class (icon/text turn green, `title` → "Copied!") and calls
`resetButtons()` to clear the `copied` state on all other `.cp-to-clip` instances. On failure it
only `console.error`s.

## Operational caveats
- **Runs once.** Elements injected after load (AJAX, Views infinite scroll, modals) get no button.
- **Secure context required.** `navigator.clipboard` is undefined over plain HTTP; copy fails
  silently (console error). Serve over HTTPS.
- **Accessibility.** The control is a `<div>`, not a `<button>`: not keyboard-focusable, no ARIA,
  confirmation is visual (colour + `title`) only.
- The handler uses the implicit global `event` and assigns `element_class`/`btn_class` without
  declaration — cosmetic code smells, not behavioural blockers.

## Verifying
The shipped FunctionalJavascript tests (`tests/src/FunctionalJavascript/Cp2clipTest.php`) create an
article whose body contains `<div class="cp-to-clip">…</div>` in Full HTML, wait for
`.copy_to_clipboard`, click it, and assert the `title` becomes "Copied!" and that
`navigator.clipboard.readText()` returns the same text. Run with PHPUnit against
`tests/src/FunctionalJavascript/`.
