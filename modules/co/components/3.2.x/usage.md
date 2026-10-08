Components lets themes and modules register arbitrary folders of Twig templates as named Twig namespaces (e.g. `@mynamespace/box.twig`), plus adds handy Twig functions and filters for working with render arrays inside templates.

---

Out of the box Drupal only exposes each module/theme's own Twig namespace pointing at its `templates/` folder. Components removes that restriction: in any theme's or module's `.info.yml` you declare a `components: namespaces:` map that points namespaces at whatever directories you like, so you can organize a component library however you want and reference templates as `@namespace/name.twig`. It registers a high-priority Twig filesystem loader that resolves those namespaces and a Twig extension that adds a `template()` function (render a theme hook or template as a render array, with full preprocess/theme-suggestion support) and `set`, `add`, and `recursive_merge` filters for manipulating deeply-nested render arrays from within Twig. Namespaces can be altered at runtime with `hook_components_namespaces_alter()`, and the module also exposes `hook_protected_twig_namespaces_alter()` to control which core/module namespaces are allowed to be redefined. It has no admin UI, no permissions, and no config — everything is declared in code. It is a foundational building block for component-driven development, design systems, and pattern libraries, and complements (rather than replaces) core Single-Directory Components.

---

- Register a `@fusion` namespace pointing at a theme's `components/fusion` folder.
- Organize a design system's Twig files outside the default `templates/` directory.
- Reference reusable component templates as `@components/card.twig` from any template.
- Share a component library across multiple themes on one site.
- Give a module its own extra Twig namespaces for shipped components.
- Point a namespace at a path in `libraries/` for a third-party pattern library.
- Render a theme hook inline from Twig with the `template()` function.
- Build a render array from Twig using named arguments passed to `template()`.
- Merge overrides into a form/render array with the `recursive_merge` filter.
- Set a deeply-nested render-array property (e.g. `element.#attributes.placeholder`) with the `set` filter.
- Append a CSS class to a render element with the `add` filter.
- Add multiple values to a nested array key at once with `add(..., values=[...])`.
- Keep component markup DRY by including sub-components via namespaces.
- Alter another module's registered namespaces with `hook_components_namespaces_alter()`.
- Add theme-specific component paths conditionally based on the active theme.
- Unprotect a core Twig namespace so it can be overridden, via the protected-namespaces hook.
- Integrate an Atomic Design / pattern-library folder structure into a Drupal theme.
- Co-locate Twig, CSS, and JS for a component and expose it by namespace.
- Migrate a component library between themes without moving files into `templates/`.
- Reduce template duplication in decoupled/component-driven builds.
- Pass render arrays through Twig filters while preserving Drupal's preprocessing.
- Standardize component naming conventions with predictable `@namespace/name.twig` paths.
