Shortcode adds a text-format filter and plugin API for WordPress-style `[tag attr="value"]...[/tag]` macros, expanded and themed through Drupal's render layer when content is displayed.

---

The base `shortcode` module is a framework, not a set of tags: it registers a `Shortcodes` text-format filter, a companion `Shortcodes - HTML corrector` filter for WYSIWYG formats, a `shortcode` plugin type, and a `ShortcodeService` that parses filtered text into tag/plain chunks and hands each recognised tag to the plugin that registered its token. Tags nest arbitrarily (including a tag inside another instance of itself) with no special recursion handling in plugins. Plugins are discovered via the `#[Shortcode]` PHP attribute or the legacy `@Shortcode` annotation, both supported at once in 3.0.x. Any module can add tags by dropping a plugin class in `src/Plugin/Shortcode/`. The project bundles two optional submodules: `shortcode_basic_tags` (a starter set of ready-to-use tags) and `shortcode_example` (a reference plugin to copy). Version 3.0.0 is a Drupal 12 standards refactor that keeps runtime behaviour but changes the plugin base-class constructor and relocates media-URL helpers into a new `MediaUrlResolver` service/trait; existing custom plugins may need conversion (see the module's `UPGRADING.md`).

---

- Let content editors embed reusable, themeable markup in body text without writing raw HTML.
- Enable the `Shortcodes` filter on a text format so `[tag]...[/tag]` macros expand on display.
- Add the `Shortcodes - HTML corrector` filter to a CKEditor/WYSIWYG format to strip stray `<p>`/`<br>` the editor wraps around shortcode brackets.
- Provide your own custom tag by writing a `ShortcodeBase` subclass attributed with `#[Shortcode]`.
- Define a tag whose parsing token differs from its plugin id via the `token` attribute property.
- Ship module-specific tags (e.g. a `[map]`, `[cta]`, or `[embed]`) that editors can drop into content.
- Wrap a block of text in a themed container using the bundled `[quote]`, `[item]`, or `[clear]` tags.
- Insert a `[button]` or `[link]` to an aliased Drupal path or an explicit URL inside body copy.
- Render an image from a direct URL or a media entity id (with optional image style) via `[img]`.
- Embed a custom block content entity inline with `[block id="1" view="full" /]`.
- Highlight or dropcap a run of text with `[highlight]` / `[dropcap]`.
- Generate placeholder text of a chosen length with `[random length="8" /]`.
- Enable, disable and reorder individual tags per text format on the filter's settings form.
- Weight tags so that when two plugins register the same token the intended one wins.
- Escape a shortcode so it renders literally by doubling the brackets: `[[tag]]`.
- Nest tags inside each other (columns inside quotes, links inside buttons) with no extra code.
- Resolve a media entity id, file URL, or image-style derivative from a plugin by injecting `MediaUrlResolverInterface`.
- Migrate a Drupal 7 `shortcode_text_corrector` filter to `shortcode_corrector` automatically during `d7_filter_format` migration.
- Show per-tag help under the text format's "About text formats" tips via each plugin's `tips()`.
- Convert existing `@Shortcode` annotation plugins to the forward-looking `#[Shortcode]` attribute at your own pace.
- Build a lightweight token/placeholder-replacement system for editorial content without Views or Layout Builder.
- Give non-developers a small, curated vocabulary of safe embeds instead of full HTML access.
