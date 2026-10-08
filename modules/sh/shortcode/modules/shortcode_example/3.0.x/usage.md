Shortcode Example is a teaching submodule that ships one reference shortcode plugin so developers can see how to implement their own.

---

This submodule of `shortcode` exists purely as a copy-from example. It provides a single plugin, `BootstrapColumnShortcode` (id/token `col`), in `src/Plugin/Shortcode/`, showing the standard shape of a shortcode tag under the 3.0.x API: a `#[Shortcode]` attribute, a `ShortcodeBase` subclass, `getAttributes()` for attribute defaults, the `addClass()` helper, and the `process()`/`tips()` methods. The `[col]` tag wraps its content in a `<div>` carrying Bootstrap column-size classes derived from `xs`/`sm`/`md`/`lg` attributes (e.g. `md="4"` → `col-md-4`) plus any `class` you pass. Enable it beside the base `shortcode` module when you want a working, minimal reference in your own codebase; most sites use it only during development.

---

- Study a minimal, working shortcode plugin before writing your own.
- See how `#[Shortcode(id: 'col', title: …, description: …)]` registers a tag.
- Learn the `process(array $attributes, string $text, string $langcode)` signature in practice.
- See `getAttributes()` used to declare default attribute values.
- See the `addClass()` helper used to compose a CSS class string.
- Observe how a plugin returns replacement markup from `process()`.
- Learn how `tips()` supplies short and long help text for the filter tips page.
- Use `[col md="4"]content[/col]` to wrap content in a `col-md-4` div.
- Combine responsive sizes: `[col xs="12" md="6" lg="4"]content[/col]`.
- Copy the class into a custom module's `src/Plugin/Shortcode/` as a starting point.
- Demonstrate the Shortcode plugin API to a team learning the framework.
- Confirm the shortcode filter pipeline works end-to-end on a text format.
