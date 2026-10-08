Slick Extras is an add-on for the Slick carousel module that ships a handful of extra, less-common CSS skins plus example and developer sub-modules meant to teach you how to build advanced Slick displays.

---

Slick Extras depends on Slick (`>= 3.x`) and does two things. First, the base module registers a `SlickSkin` plugin (`slick_extras_skin`, class `SlickExtrasSkin`) that adds six extra skins on top of Slick's own: `d3-back` (X 3d back), `boxed` (X Boxed), `boxed-carousel` (X Box carousel), `boxed-split` (X Box split), `rounded` (X Rounded), and `vtabs` (X VTabs) — each backed by CSS under `css/theme/`. Once enabled and cache is cleared, these appear in the **Skin** dropdown of any Slick optionset or field formatter, exactly like the skins Slick provides. Second, the project bundles two learning sub-modules: **Slick Example** (`slick_example`) supplies sample optionsets prefixed `X` (`x_main`, `x_carousel`, `x_grid`, `x_overlay`, `x_slick_nav`, `x_slick_for`, `x_split`, `x_vtabs`, `x_fullscreen`), Slick image styles, a `slick_x` View with demo blocks, and its own `SlickExampleSkin`; it also depends on Slick Views. **Slick Development** (`slick_devel`) adds a settings form and a debug JS loader for library development. The base module has no config UI, permissions, routes, Drush commands, or config schema of its own — its only PHP is a deprecated `slick_extras_get_path()` path helper. The maintainers explicitly frame the whole project as sample/scaffolding code: clone what you need, make it yours, and uninstall it in production rather than relying on it directly.

---

- Add the `X Boxed` skin to a Slick optionset to reveal arrows with side margins.
- Use the `X Box carousel` skin as a margin-based alternative to Slick's centerMode.
- Apply the `X Box split` skin to separate caption and image in a carousel.
- Turn on the `X Rounded` skin for a 3–5 visible-slide carousel with rounded images.
- Use the `X 3d back` skin for a 3D view with the focal slide at the back (3 slidesToShow, caption below).
- Add vertical-tab thumbnail navigation to a slider with the `X VTabs` thumbnail skin.
- Register your own custom Slick skins by copying the `SlickExtrasSkin` plugin pattern.
- Learn how a `SlickSkin` plugin maps skin ids to CSS theme files.
- Study ready-made optionsets (`x_main`, `x_carousel`, `x_grid`, etc.) from Slick Example.
- Clone the `slick_x` View to bootstrap a Slick Views slideshow/grid block.
- Explore an asNavFor (slider + thumbnail nav) setup via `x_slick_for` / `x_slick_nav`.
- Reuse the example Slick image styles (`slick`, `slick_thumbnail`, `slick_square`, etc.).
- Build a CSS-Foundation grid carousel following the Slick Example grid block.
- Inspect a fullscreen slideshow example (`x_fullscreen`) as a starting template.
- See how overlay/split layouts are wired (`x_overlay`, `x_split`).
- Prototype nested Slick or asNavFor using paired `field_image` / `field_images` fields.
- Use Slick Development's settings form and debug JS loader while developing Slick libraries.
- Copy the example CSS skin (`slick.theme--x-testimonial.css`) as a testimonial slider base.
- Reference `slick_example.module` to discover Slick's available alter hooks.
- Understand skin `group` semantics (`main` vs `thumbnail`) from the registered skins.
- Keep the module enabled in production safely, or uninstall once you've copied what you need.
- Clear cache after adding or changing skins so they show up in the optionset UI.
