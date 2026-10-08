jQuery UI Effects re-provides the jQuery UI Effects asset library as a contrib module after jQuery UI was deprecated and removed from Drupal core, so themes, modules and custom code that use jQuery UI animations keep working.

---

Drupal core historically bundled the jQuery UI effects assets, but jQuery UI is no longer actively maintained (marked End of Life by the OpenJS Foundation) and core deprecated it, so this project ships the effects library outside of core. It depends on the base `jquery_ui` module (`>=8.x-1.7`) and adds nothing but assets: there is no configuration UI, no permissions, no services and no `.module` file. The library definitions are not declared in a `jquery_ui_effects.libraries.yml`; instead the base `jquery_ui` module's `hook_library_info_alter()` reads `jquery_ui.libraries.data.json` and registers the effects libraries under the `jquery_ui_effects` namespace when this module is enabled. The core entry `jquery_ui_effects/core` provides jQuery UI's effects engine (the `.effect()`, `.show()`, `.hide()`, `.toggle()` extensions, color animation and easings), and each individual effect (blind, bounce, clip, drop, explode, fade, fold, highlight, puff, pulsate, scale, shake, size, slide, transfer) is its own sub-library that depends on `jquery_ui_effects/core`. You consume them by attaching the relevant library id via a render array `#attached` or a `dependencies:` list in your own `*.libraries.yml`. The maintainers recommend migrating off jQuery UI to a maintained animation approach rather than adding new dependencies. In practice this module exists purely to keep legacy jQuery UI effect code working during that transition.

---

- Restore jQuery UI effect animations after upgrading to a Drupal core version where jQuery UI was removed.
- Attach the effects engine `jquery_ui_effects/core` so `$(el).effect(...)` works in custom JS.
- Add a fade effect to a custom element by attaching `jquery_ui_effects/fade`.
- Add a slide-in/slide-out animation with `jquery_ui_effects/slide`.
- Add a bounce animation to a call-to-action using `jquery_ui_effects/bounce`.
- Add a shake effect to signal a form validation error with `jquery_ui_effects/shake`.
- Highlight a just-updated table row using `jquery_ui_effects/highlight`.
- Use `jquery_ui_effects/blind` to reveal a panel with a blind-style animation.
- Use `jquery_ui_effects/clip` to clip an element open or closed.
- Use `jquery_ui_effects/drop` to drop an element in or out of view.
- Use `jquery_ui_effects/explode` to break an element into pieces on removal.
- Use `jquery_ui_effects/fold` to fold an element away.
- Use `jquery_ui_effects/puff` or `jquery_ui_effects/scale` to grow/shrink an element (puff pulls in scale).
- Use `jquery_ui_effects/pulsate` to flash an element's opacity for attention.
- Use `jquery_ui_effects/size` to resize an element to a target dimension.
- Use `jquery_ui_effects/transfer` to animate an outline transferring from one element to another.
- Declare `jquery_ui_effects/core` under `dependencies:` in your own `*.libraries.yml`.
- Keep a legacy contrib or custom module that calls jQuery UI effects working without patching it.
- Access jQuery UI easing functions (via the effects core) for eased jQuery `.animate()` calls.
- Enable color animation on properties like `backgroundColor` that the effects core adds.
- Pair effects with base jQuery UI widgets from the companion `jquery_ui` module on the same page.
- Avoid loading the entire jQuery UI effect set by attaching only the specific effect sub-libraries you need.
- Serve the vendored jQuery UI 1.13.x effect scripts consistently across a multisite platform.
- Provide the effects assets that other jQuery UI widget companion modules may build on.
- Bridge a site during migration away from jQuery UI animations to a modern library.
