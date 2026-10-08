Registers Paragraphs library items with Rabbit Hole so you can control what happens when a library item is viewed at its canonical page — display, access denied, page not found, or redirect.

---

`rh_paragraphs_library` is the Rabbit Hole submodule for the Paragraphs Library (part of the contributed Paragraphs module). Enabling it registers a Rabbit Hole entity plugin for the `paragraphs_library_item` entity type, adding the "Rabbit Hole settings" to that entity's forms (and per-item overrides where allowed). Library items exist to be reused across content, not to be viewed as standalone pages, so their canonical URLs are almost always unwanted — this submodule lets you 404, deny access to, or redirect them. All behavior logic, redirect codes, tokens, and fallbacks come from the base `rabbit_hole` module; this submodule only wires up library-item support. It depends on `rabbit_hole` and `paragraphs_library`.

---

- Return 404 for paragraphs library item canonical pages.
- Deny access to library items so reusable content isn't browsable standalone.
- Redirect a library item's page to a piece of content that uses it.
- Set a default behavior for all library items, overridable per item.
- Return "page not found" instead of "access denied" to hide existence.
- Redirect using a token where applicable.
- Override the default on a specific library item.
- Configure a fallback action for empty/invalid redirect targets.
- Hide library item pages from crawlers for SEO cleanup.
- Redirect legacy library item URLs with a 301.
- Let editors bypass the action to preview the real item page.
- Grant a role permission to administer Rabbit Hole on library items only.
- Redirect a library item page to `<front>`.
- Prevent reusable component pages from resolving publicly.
- Keep library items out of search indexes.
- Route a library item page to its editorial context.
- Use a temporary 302 redirect during content restructuring.
- Prevent library item pages from resolving on a headless site.
