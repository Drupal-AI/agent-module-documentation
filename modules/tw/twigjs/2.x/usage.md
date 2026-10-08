Twig.js packages the client-side Twig.js JavaScript library as Drupal asset libraries so other code can render Twig-style templates in the browser.

---

Twig.js is a developer/dependency module: it vendors the Twig.js JavaScript implementation of Twig (plus a tiny Underscore-based "light" alternative) and declares them as three attachable Drupal libraries — `twigjs/twigjs` (the full Twig.js, exposing the `Twig` global), `twigjs/light` (an Underscore `_.template()` wrapper exposing `TwigLight`, supporting only `{{ var }}` interpolation and no Twig tags), and `twigjs/drupal.twigjs` (the full library plus a `trans`/`endtrans` tag extension). The module has no routes, controllers, services, config, permissions, or plugins — enabling it simply makes the libraries available. The typical pattern is that server-side code stores a template string in `drupalSettings`, attaches one of the libraries, and a `Drupal.behaviors` callback then calls `Twig.twig({...}).render(...)` and writes the HTML into the page. Note that twig.js variables must resolve to strings (nested render arrays are not supported) and the "light" version supports interpolation only.

---

- Provide the full Twig.js library to the browser via `twigjs/twigjs`.
- Render a Twig template string client-side with `Twig.twig({id, data}).render(vars)`.
- Reuse the same Twig template on both server and client to avoid duplicating markup.
- Attach `twigjs/drupal.twigjs` when a client-side template uses the `{% trans %}` tag.
- Use the lightweight `twigjs/light` variant when you only need `{{ var }}` substitution and want minimal JS weight.
- Depend on this module from a custom or contrib module that needs client-side templating.
- Stash a template string into `drupalSettings` and re-render it in a `Drupal.behaviors` attach callback.
- Render lists/loops client-side (full Twig.js supports `{% for %}`, `{% if %}`, filters).
- Cache compiled templates client-side by passing a stable `id` to `Twig.twig()` / `TwigLight.twig()`.
- Build decoupled or JS-heavy front ends that want to keep Twig-like templates in the browser.
- Progressively enhance a server-rendered block by re-rendering it client-side with new data.
- Feed an already-rendered string (not a nested render array) as a twig.js variable.
- Swap between the full and light libraries depending on template complexity.
- Enable only when a project or dependent module actually needs client-side Twig rendering.
- Keep the module disabled when no code depends on it (it adds nothing on its own).
- Read the Twig.js upstream docs (github.com/twigjs/twig.js) for supported tags and filters.
- Compare server (`inline_template`) and client (`Twig.twig`) output of the same template in tests.
- Render simple data-driven widgets (names, numbers, labels) with the light variant.
- Avoid nested render-array variables in client-side templates (they must be strings).
- Use `TwigLight` with the same API shape as `Twig` for an easy drop-in when tags are not needed.
- Ship Twig-style client templates without pulling in a separate front-end framework.
