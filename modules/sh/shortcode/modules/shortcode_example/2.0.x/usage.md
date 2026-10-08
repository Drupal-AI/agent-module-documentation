<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shortcode Example is a teaching module: it ships exactly one shortcode plugin, `[col]` (Bootstrap column), as a minimal, complete reference implementation for developers writing their own `@Shortcode` plugins against the parent `shortcode` module.

---

The module contains a single class, `BootstrapColumnShortcode` (plugin id `col`), that wraps its content in a `<div>` carrying Bootstrap column-size classes (`col-xs-N`, `col-sm-N`, `col-md-N`, `col-lg-N`) built from optional `xs`/`sm`/`md`/`lg` size attributes plus a free-form `class` attribute. It has no theming, no config schema, no settings form, and is deliberately the simplest possible non-trivial example: a plain `@Shortcode` annotation, `ShortcodeBase::getAttributes()` to merge user input with defaults, `ShortcodeBase::addClass()` to build the class string, and a `tips()` implementation showing both short and long help text. The Shortcode annotation's own doc comment (`src/Annotation/Shortcode.php`) points directly at this plugin ("For a working example, see `BootstrapColumnShortcode`"), making it the canonical starting point cited by the framework itself.

---

- Learn the minimum code needed to implement a working `@Shortcode` plugin from a real, working example.
- Copy `BootstrapColumnShortcode` as a scaffold for a brand-new custom shortcode plugin.
- See `ShortcodeBase::getAttributes()` used in practice to merge and whitelist tag attributes.
- See `ShortcodeBase::addClass()` used in practice to safely accumulate CSS classes.
- Study a `tips()` implementation that provides both a short and a long (`$long = TRUE`) help variant.
- Reference how a plugin declares its `id`, `title`, and `description` in the `@Shortcode` annotation without needing `token`, `weight`, `status`, or `settings`.
- Enable `[col]` on a text format to lay out multi-column body text using Bootstrap grid classes without hand-written HTML.
- Build a two-column layout in body text: `[col md="6"]left content[/col][col md="6"]right content[/col]`.
- Combine `[col]` with a custom `class` attribute to add extra styling hooks: `[col md="4" class="highlight-box"]...[/col]`.
- Verify a local shortcode-plugin development environment is wired correctly by confirming `[col]` renders as expected.
- Use as a smoke-test fixture: enable the module, enable the `shortcode` filter and the `col` shortcode, and confirm bracket-tag parsing works end-to-end.
- Cross-check a plugin manager/hook understanding against the shortcode framework's own documented example.
- Demonstrate to a team or in a code review how little boilerplate a Shortcode plugin actually requires.
- Explore the `ShortcodeBase` abstract class's default method implementations without needing a more complex real-world plugin as a distraction.
- Prototype a new shortcode idea quickly by editing a copy of this module's single plugin file.
- Onboard a developer new to Drupal plugin systems using a small, self-contained, real plugin type.
- Use as a reference when writing this project's own `agent/plugins/shortcode-plugin.md` "how to implement" documentation.
- Confirm the `plugin.manager.shortcode` service discovers plugins from more than one module (parent + example) at once.
