Canvas Jumbotron adds a reusable "Jumbotron" hero/banner code component to the Canvas (Experience Builder) page builder.

---

Canvas Jumbotron is a config-only module: enabling it registers one Canvas code component (a React `js_component` named `jumbotron`) plus its component-instance definition. The component renders a `<section>` with three editable Canvas slots — Header, Button, and Footer — and an optional Image prop bound to a Media image entity reference. Editors add the Jumbotron from the Canvas component list, place other Canvas components inside its slots, and pick the hero image through the Media Library; the image is delivered responsively through the `canvas_parametrized_width` image style. There is no admin settings form, no route, and no permission introduced by this module — all authoring happens inside the Canvas UI, gated by Canvas's own permissions. It requires the Canvas/Experience Builder module and the Media stack (`file`, `media`, `media_library`).

---

- Add a full-width hero/banner region to a page built with Canvas / Experience Builder.
- Provide editors a pre-built jumbotron so they do not have to hand-author a code component.
- Compose a landing-page hero from a heading, a call-to-action button, and a footer note using the three slots.
- Drop any other Canvas component (heading, rich text, button, link) into the Header slot as the hero title/subtitle.
- Place a call-to-action Canvas component (button/link) into the Button slot.
- Add supporting text, legal copy, or secondary links via the Footer slot.
- Attach a background/hero image to the banner by selecting a Media image entity.
- Reuse the same Jumbotron component across many Canvas pages for consistent hero styling.
- Render hero images responsively using the shipped `canvas_parametrized_width` image style (parametrized widths).
- Let content editors swap the hero image through the standard Media Library widget.
- Build a marketing/landing page top section without writing React or Twig.
- Fall back gracefully to a text-only hero (no `<img>`) when no image is selected.
- Serve as a starter/example of a Canvas `js_component` for teams learning to author code components.
- Keep hero markup consistent site-wide by centralising it in one component definition.
- Give designers a slot-based container to arrange hero content order (header, button, footer).
- Use as the banner at the top of a Canvas-built home page or campaign page.
- Standardise alt-text handling on hero images (falls back to "Jumbotron header visual" when alt is empty).
- Provide a media-backed hero that participates in Drupal's responsive image / image-style pipeline.
- Ship the component via config so it can be deployed and version-controlled with the rest of the site config.
- Enable/uninstall cleanly since the module adds only config entities and no data of its own.
