<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Events replaces the site's Twig theme engine with a thin wrapper that dispatches a Symfony event around every template render, giving code a supported place to observe or rewrite rendered markup that Drupal's theme layer otherwise does not offer.

---

Drupal's theme layer provides preprocess functions and template overrides, but no general hook that fires *around* the rendering of a template — anything that wants to observe or wrap rendering has to hand-decorate the `twig.engine`/`TwigEnvironment`, which is fragile across core versions. Twig Events does that decoration once. Its main module (`twig_events.module`) implements `hook_system_info_alter()` and, for every theme whose engine is `twig`, rewrites the engine to `twig_events_engine` — a bundled **theme engine** (shipped in `theme_engine/`, declared with `type: theme_engine`, not a `modules/` submodule) that wraps core's `twig_render_template()`. After core renders a template, the wrapper dispatches `Drupal\twig_events\Event\TwigRenderTemplateEvent` carrying the template file, the render variables, and the rendered output, then returns `$event->getOutput()` — so a subscriber (subscribing to the event **class name**, `TwigRenderTemplateEvent::class`, since dispatch passes only an object) can inspect the template/variables or mutate the output via `setOutput()`. Version **1.0.1**, core `^9 || ^10 || ^11`, no dependencies, permissions, config, Drush commands or config schema — it is pure infrastructure. Two consequences follow. **It does nothing on its own**: enabling it changes no visible behavior, and its entire value is in what subscribes to the event; a site running it with no subscriber carries an engine indirection for nothing. And **the event fires on the hot path**: a single page renders hundreds of templates, so any subscriber that does real work runs hundreds of times per request — fine for a development-time profiler or debug annotator, but measure before relying on it in production, and note a subscriber that rewrites output is trusted to keep it safe.

---

- Dispatch a Symfony event around every Twig template render.
- Observe which templates render on a request without patching core.
- Profile per-template render time by timing the event.
- Annotate rendered markup with the template file that produced it.
- Build a Twig/theme-layer debugging or inspection tool.
- Instrument the render pipeline for cache or performance analysis.
- React in code when a specific template is reached.
- Rewrite or post-process rendered template output centrally.
- Avoid hand-decorating the `twig.engine` / `TwigEnvironment` service.
- Give tooling a stable, core-version-tolerant extension point.
- Trace a rendering problem back to its template.
- Collect a template-usage report across a page load.
- Wrap template rendering with logging.
- Detect which template produced a fragment of markup.
- Provide render-time events to another module you maintain.
- Measure how many times each template renders per request.
- Inject debug HTML comments around template output.
- Support a performance investigation into slow theming.
- Extend the set of hook points available to the theme layer.
- Prototype output transformations without altering templates.
- Feed rendered output into an external monitoring/APM tool.
- Swap the whole site onto the wrapper engine automatically via `hook_system_info_alter()`.
