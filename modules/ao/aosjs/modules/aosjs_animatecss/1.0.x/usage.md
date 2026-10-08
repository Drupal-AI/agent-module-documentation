AOS JS + AnimateCSS is a glue submodule that lets the AOS JS UI drive [Animate.css](https://animate.style/) animations instead of AOS's built-in effects, by swapping the animation option set on the AOS admin forms.

---

This submodule depends on both `aosjs_ui` and the separate `animatecss` contrib module. It ships no config, no routes, and no permissions of its own; instead a `RouteSubscriber` event subscriber (`aosjs.route_subscriber`) rewrites the `_form` handler of the existing `aosjs.settings`, `aosjs.add`, and `aosjs.edit` routes to Animate.css-aware subclasses (`AosJsAnimateCssSettings extends AosJsSettings`, `AosJsAnimateCssForm extends AosJsForm`). When `aosjs.settings`'s `options.library` is set to `animate`, those forms replace AOS's animation dropdown with `animatecss_animation_options()`, force AOS v3's `useClassNames` behavior on, and set the animated class name to Animate.css's `animated` / `animate__animated` (depending on the `animatecss.settings` `compat` flag). The install hook reminds you to switch AOS to v3 and pick Animate.css as the default library; the uninstall hook restores the AOS defaults (`options.library` back to `aos`, offset 120, duration 400, easing `ease`, class name `aos-animate`) if the site was still using `animate`. All actual settings continue to live in the base `aosjs.settings` config and the `aos` selector table owned by `aosjs_ui` — this module only alters how those forms present animation choices.

---

- Use Animate.css effects (bounce, flash, pulse, etc.) as scroll-triggered animations via AOS.
- Swap the AOS animation dropdown for the full Animate.css catalog on the settings form.
- Swap the animation options on the add/edit selector forms to Animate.css names.
- Keep AOS's scroll-trigger engine while sourcing animation classes from Animate.css.
- Automatically enable AOS v3 `useClassNames` mode required for external class-based libraries.
- Match the correct animated class prefix (`animated` vs `animate__animated`) from Animate.css `compat` mode.
- Restore AOS's native animation defaults automatically on uninstall.
- Combine a single scroll library with the Animate.css design system already used on a site.
- Give editors Animate.css choices without exposing raw class names.
- Bridge two popular animation libraries without writing custom code.
- Reuse the AOS JS UI selector list with Animate.css animations.
- Drive Animate.css entrance animations on scroll for landing-page sections.
- Provide a consistent effect set when a theme standardizes on Animate.css.
- Preview Animate.css animations on the AOS admin sample area.
- Switch the whole site between AOS-native and Animate.css effects by toggling `options.library`.
