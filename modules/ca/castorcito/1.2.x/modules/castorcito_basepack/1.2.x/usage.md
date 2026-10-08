Castorcito Base Pack installs a library of ready-to-use Castorcito components (banner, card, tabs, accordion, carousel, gallery, quote, video, and more) so you can build pages without defining components from scratch.

---

Castorcito Base Pack is a sub-module of Castorcito. It has no code beyond two help/uninstall hooks; its value is the configuration it ships — a set of `castorcito_component` and `castorcito_category` config entities under `config/install/`, each paired with a Single Directory Component (SDC) under `components/`. Enabling it adds the "basepack" category and its components to the component library at `/admin/castorcito/component`, ready to attach to any JSON field via the Castorcito widget/formatter. Each component carries default look-and-feel and, where relevant, JS behaviour; the README recommends cloning a component before using it so the original stays as a backup. Markup is overridable from a theme by copying the SDC and adding `replaces: 'castorcito_basepack:<name>'`.

---

- Install a starter component library instead of building components by hand.
- Add a hero **banner** with image, heading and CTA to a landing page.
- Build **card** grids for features, services or teasers.
- Add **tabs** or an **accordion** for FAQ / structured sections.
- Add a **carousel** or **slideshow** of images/slides.
- Present an **image gallery** curated per node.
- Lay out **content in columns** or **icons in columns**.
- Highlight metrics with a **data number card**.
- Add a **quote / testimonial** block.
- Embed a **video** or **image** component.
- Show a site-wide **announcement bar**.
- Place an existing Drupal block through the **placed block** component.
- Add rich **text** sections with a controlled WYSIWYG.
- Clone any shipped component and restyle it via the theme SDC without touching the module.
- Use basepack components as children inside Castorcito containers to compose larger layouts.
- Uninstall cleanly — the module removes its `basepack` category and components on uninstall.
