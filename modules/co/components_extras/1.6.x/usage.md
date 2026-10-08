Components Extras adds a `component` render element and a YAML-based plugin type on top of the Components (Component Libraries) module, so developers can drop a registered Twig component straight into a render array.

---

Components Extras extends the Components module by letting modules and themes register named Twig components in a `{name}.components.yml` file. Each registered component declares a `path` (a Twig template, typically addressed through a Components Twig namespace such as `@customer/header/header.twig`) and a list of allowed `variables`. The module defines a plugin manager (`plugin.manager.component_theme`) that discovers those YAML definitions from every enabled module and theme directory and caches them. It also provides a `#type => 'component'` render element: you set `#component` to a registered component id and pass each declared variable as `#var1`, `#var2`, and so on. A pre-render callback looks up the component definition, copies only the whitelisted variables that were supplied, and the module's template `include`s the component's `path`, passing those variables into it. Because Twig disallows dynamic block names, registered components are expected to read their inputs as variables rather than blocks. The module ships two example definitions (`first`, `second`) and requires the Components module; it has no admin UI, permissions, config, or Drush commands.

---

- Render a registered Twig component from a Drupal render array using `#type => 'component'`.
- Reuse design-system / component-library Twig partials (buttons, cards, headers) across modules and themes.
- Register a named component in a module via `mymodule.components.yml` with a `path` and `variables`.
- Register a named component in a theme via `mytheme.components.yml`.
- Pass structured data into a Twig component through per-variable render-array keys (`#title`, `#items`, ...).
- Address component templates through Components' Twig namespaces (e.g. `@customer/...`).
- Build render arrays that emit reusable components instead of hand-written `#markup`.
- Return a component render element from a controller, block plugin, or field formatter.
- Nest a component element inside another render array as a child element.
- Standardise the props a component accepts by declaring its `variables` list once.
- Look up available registered components programmatically via the `component_theme` plugin manager.
- Get the definition (path + variables) of a specific component id for tooling or debugging.
- Provide a component library shared between several sites or install profiles.
- Give front-end developers a component contract (name + variables) that back-end code targets.
- Migrate ad-hoc `{% include %}` calls in templates into centrally-registered components.
- Compose page building blocks from a curated set of Twig components.
- Alter or extend registered component definitions from another module via the `component_theme` alter hook.
- Ship example/reference component definitions developers can copy (`first`, `second`).
- Bridge the Components module's template-directory namespaces with a render-array API.
- Keep component markup in Twig while keeping the data-passing logic in PHP.
