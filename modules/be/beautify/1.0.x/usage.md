<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Beautify pretty-prints the HTML markup Drupal outputs, using a selectable beautifier plugin (a pure-PHP HTMLBeautify or PHP Tidy).
---
The module defines a `Beautifier` annotation plugin type with a manager (`src/BeautifierManager.php`) and two bundled plugins under `src/Plugin/Beautifier/`: `HtmlBeautify` and `Tidy`. A `KernelEvents::RESPONSE` subscriber (`src/EventSubscriber/BeautifyResponseFilter.php`) takes the rendered HTML response and runs it through the configured beautifier so the delivered source is consistently indented/formatted.

An admin form at `/admin/config/development/beautifier` (permission string `admninister beautifiers`, a typo preserved from the module) selects the active beautifier and its per-plugin options via `BeautifierPluginForm`. The Tidy plugin requires the PHP Tidy extension. This is primarily a developer/output-quality aid; it changes only whitespace/formatting of the markup, not its semantics. Typical setup is enabling the module, granting the permission, and choosing a beautifier on the settings form.

There are no anonymous or mutating endpoints beyond the permission-gated settings form. Because beautification runs on every matched response, weigh the small per-response processing cost on production.
---
- Pretty-print Drupal's HTML output for readability.
- Choose between HTMLBeautify (PHP) and PHP Tidy backends.
- Configure the active beautifier at the settings form.
- Set per-plugin formatting options.
- Produce consistently indented page source.
- Aid front-end debugging with clean markup.
- Add a custom beautifier via the Beautifier plugin type.
- Require the Tidy PHP extension for the Tidy plugin.
- Gate configuration behind the beautifier permission.
- Format markup site-wide through a response subscriber.
- Improve diffability of rendered HTML.
- Toggle beautification by enabling/disabling the module.
- Standardize whitespace across themes.
- Inspect generated markup more easily in dev.
- Use as a build/QA aid for template output.
- Swap beautifier backends without code changes.
- Keep semantics unchanged while reformatting.
- Provide a plugin manager for markup formatters.
