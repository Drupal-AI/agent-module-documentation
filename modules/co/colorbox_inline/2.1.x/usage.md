Colorbox Inline extends the Drupal Colorbox module so a link can open content that already exists elsewhere on the same page inside a Colorbox lightbox, driven entirely by HTML `data-` attributes — no PHP or configuration required.

---

The module ships one Drupal behavior (`Drupal.behaviors.colorboxInline`) that scans every element carrying a `data-colorbox-inline` attribute and wires it up as a Colorbox trigger. The attribute's value is a CSS selector pointing at another element on the page; clicking the trigger opens that element's markup inline in a Colorbox modal. It reuses the parent Colorbox module's global `drupalSettings.colorbox` options, then overrides them per-link with optional `data-width`, `data-height`, `data-class`, and `data-rel` attributes. Hidden source elements (`display:none`) are temporarily shown while the modal is open and re-hidden on cleanup, so you can keep the source markup out of the normal page flow. There is no admin UI, no permissions, no config schema, and no Drush commands — enabling the module is the entire setup. It works by implementing `hook_page_attachments()` to attach the parent Colorbox library (via the `colorbox.attachment` service) plus its own `colorbox_inline/colorbox_inline` JS library on every page. Because the content is already in the DOM, it does not fetch anything over AJAX — for AJAX-loaded modal content use the separate `colorbox_load` module instead. Values containing `<` are ignored as a guard against passing raw HTML instead of a selector.

---

- Open a hidden login form in a lightbox when a "Log in" link is clicked
- Show a Terms & Conditions block inline in a modal from a checkout page
- Pop up a newsletter signup form that lives hidden at the bottom of the page
- Display extended product details from an off-screen `<div>` without a page reload
- Reveal a large map or embed that is hidden until the user asks for it
- Show a cookie/privacy policy excerpt in a modal without an extra HTTP request
- Open a hidden video or media embed in a lightbox on click
- Present a "Read more" biography stored in a collapsed page region
- Trigger a help/instructions panel that is otherwise `display:none`
- Show a gallery caption or metadata block inline in Colorbox
- Build a lightweight FAQ where each answer opens in a modal from in-page markup
- Pop a contact form that is rendered hidden in the footer
- Display a promotional banner's fine print in a modal
- Set a custom modal width/height per link with `data-width` / `data-height`
- Apply a custom CSS class to a specific modal via `data-class`
- Group related inline modals with `data-rel` for Colorbox navigation
- Reuse Views output or a Block's rendered HTML as modal content by targeting its selector
- Provide an accessible "quick view" of content already loaded on a listing page
- Show a warning/confirmation snippet inline before a user proceeds
- Turn any WYSIWYG-authored link into a modal trigger using Full HTML and a `data-colorbox-inline` attribute
- Avoid an AJAX round-trip when the modal content is small and already server-rendered
- Add modal behavior in a custom Twig template without writing JavaScript
- Reuse the parent Colorbox module's global styling and transitions for inline popups
- Progressive enhancement: the source element degrades to plain in-page content if JS is off
