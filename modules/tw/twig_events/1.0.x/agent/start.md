<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Events (twig_events) — agent index

Replaces the site's **Twig theme engine** with a wrapper that dispatches a Symfony **event around every
template render**. Version **1.0.1**, core `^9 || ^10 || ^11`. No dependencies, permissions, config,
config schema or Drush commands — infrastructure another module builds on.

## Mechanism (read the source, this is the whole module)
- **`twig_events.module`** — `hook_system_info_alter()`: for every theme whose `engine` is `twig`, it
  rewrites `$info['engine']` to `twig_events_engine`. That silently swaps the render engine site-wide.
- **`theme_engine/twig_events_engine.engine`** — a bundled **theme engine** (`type: theme_engine`, NOT
  a `modules/` submodule; the `data.json` lists it under `submodules` only as the shipped component).
  Its `*_theme`, `*_extension`, `*_init` functions delegate straight to core's `twig_*` equivalents.
  Its `render_template()` calls core `twig_render_template($template_file, $variables)`, then dispatches
  `new TwigRenderTemplateEvent($template_file, $variables, $output)` and **returns `$event->getOutput()`**.
- **`src/Event/TwigRenderTemplateEvent.php`** — the event. Mutable getters/setters:
  `getTemplateFile()/setTemplateFile()`, `getVariables()/setVariables()`, `getOutput()/setOutput()`.
  Dispatch passes only the object, so subscribers key on the **class name** `TwigRenderTemplateEvent::class`.

## Two things that follow
1. **Useless alone.** Enabling changes nothing visible; all value is in the subscriber you write.
2. **Hot path.** A page renders **hundreds** of templates → a subscriber runs hundreds of times/request.
   Fine for dev-time profiling/debug; measure before production. A subscriber that rewrites output is
   trusted to keep the result safe markup.

## How to use it
- Subscribe to `TwigRenderTemplateEvent` — see `agent/api/subscribe.md`.

## Facts
- No config route (`configure: null`), no `config/`, no `composer.json`, no `README` in the package.
- License GPL-2.0-or-later. `package: Core` (cosmetic; it is a contrib project).
