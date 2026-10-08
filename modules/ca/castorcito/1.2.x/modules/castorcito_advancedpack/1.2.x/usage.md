Castorcito Advanced Pack installs advanced ready-to-use Castorcito components — a Swiper.js slider and a timeline — bundling the Swiper library.

---

Castorcito Advanced Pack is a sub-module of Castorcito. Like the base pack it is mostly configuration: it ships `castorcito_component` and `castorcito_category` config entities under `config/install/` and their Single Directory Components under `components/`, plus a bundled Swiper.js library (`assets/lib/swiperjs/`) exposed as the `swiperjs` library. Enabling it adds an "advancedpack" category with a Swiper-based slider (with a slide item child component) and a timeline (with a timeline item child component). Its only PHP is help and uninstall hooks; on uninstall it deletes the advancedpack category and its components. Markup is overridable from a theme via `replaces: 'castorcito_advancedpack:<name>'`.

---

- Add a touch-enabled **Swiper slider/carousel** to a page without integrating Swiper yourself.
- Build a **timeline** of events or milestones as reusable content.
- Populate slider/timeline items per node through the Castorcito widget.
- Use the bundled Swiper library instead of adding a CDN or custom build.
- Clone the slider/timeline component to customise slides-per-view, autoplay, or styling via the theme SDC.
- Nest advanced components inside Castorcito containers to compose richer layouts.
- Uninstall cleanly — the module removes its `advancedpack` category and components on uninstall.
- Combine with castorcito_basepack for a fuller component library.
