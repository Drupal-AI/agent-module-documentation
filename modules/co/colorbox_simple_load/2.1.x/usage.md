<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Colorbox Simple Load makes any link marked with the `colorbox-load` CSS class open its `href` inside a Colorbox lightbox, with the lightbox options read straight from the link's URL query string.

---

The module is a tiny front-end glue layer on top of the Colorbox module. On every page it runs `hook_page_attachments()`, which calls Colorbox's `colorbox.attachment` service (so Colorbox's own settings and library load) and attaches its own `colorbox_simple_load/load` library (`js/colorbox-simple-load.js`, depending on `core/jquery` and `core/drupal`). The behaviour finds every `.colorbox-load` element, parses its `href` query string into a params object, and calls `$(element).colorbox($.extend({}, settings.colorbox, params))` — so each link inherits the global Colorbox settings and then overrides them per-link from the URL. Query keys map to Colorbox options directly, with two conveniences: `width` becomes `innerWidth`, `height` becomes `innerHeight`, and the strings `true`/`yes` and `false`/`no` are coerced to booleans. It honours Colorbox's mobile-detect settings (`mobiledetect` / `mobiledevicewidth`), bailing out on small screens. It has no admin UI, no configuration, no permissions, no schema, and no PHP API of its own — you use it purely by adding the class and query params to markup. All lightbox styling and global defaults come from the Colorbox module itself.

---

- Open an arbitrary URL (e.g. a node view, a form, an external page) in a Colorbox lightbox from a plain link.
- Turn a "View" or "Quick look" link into a modal without writing any JavaScript.
- Set a specific lightbox width per link via `?width=800` (mapped to Colorbox `innerWidth`).
- Set a specific lightbox height per link via `?height=600` (mapped to `innerHeight`).
- Load remote content in an iframe by passing `?iframe=true` in the link's href.
- Force AJAX-loaded HTML into the lightbox with `?ajax=true`.
- Toggle Colorbox behaviours per link by passing boolean-style params (`true`/`yes`/`false`/`no`).
- Add a modal "Terms & conditions" popup that loads a node into a lightbox.
- Provide an image gallery-style popup for links that point at large images.
- Open an embedded video page inside a modal overlay.
- Add a "Preview" link on a listing that opens the full item in a lightbox.
- Present a contact or signup form in a modal by linking to the form route with `colorbox-load`.
- Reuse the site's global Colorbox theme/settings while overriding size for one specific link.
- Respect mobile users by inheriting Colorbox's mobile-detect opt-out automatically.
- Add lightbox links inside a custom block's body HTML.
- Add lightbox links from a View's rewritten output or a text-format field.
- Provide a "Read more in a popup" affordance for teaser cards.
- Open a printable/summary version of a page in an overlay.
- Link help or documentation snippets that appear in a modal instead of navigating away.
- Combine several per-link options in one href, e.g. `?width=900&height=700&iframe=true`.
- Give editors a documented class (`colorbox-load`) they can add in the WYSIWYG source view.
- Standardise "open in lightbox" behaviour across a theme without per-template JS.
- Wrap call-to-action links so campaign landing pages open in a focused modal.
- Show an enlarged map or diagram in a lightbox from a thumbnail link.
