Responsive Wrappers is a text-format filter that scans rendered content and adds Bootstrap responsive wrappers and CSS classes to tables, images and video iframes, so WYSIWYG editors get responsive output without writing div wrappers or remembering Bootstrap class names.

---

The module ships a single text-format filter plugin, `filter_bootstrap_responsive_wrapper` (title "Responsive wrappers filter"), which you enable per text format at `/admin/config/content/formats`. When it runs it parses the text as a DOM and, for each of three independently toggled behaviors, injects the markup a Bootstrap layout expects: `table` elements get a `table-responsive` wrapper div and a `table` class; `img` elements get an `img-fluid` (Bootstrap 4/5) or `img-responsive` (Bootstrap 3) class; and `iframe` elements whose `src` matches a configurable regex (default matches YouTube and Vimeo) get an `embed-responsive embed-responsive-16by9` wrapper div and an `embed-responsive-item` class. It recognizes and reuses an existing wrapper (including Video Embed Field's `video-embed-field-responsive-video`) rather than double-wrapping. A global settings form at `/admin/config/content/responsivewrappers` (route `responsivewrappers.settings`, permission "administer filters") picks the Bootstrap output version (3, 4, 5, or Custom), optionally attaches the module's minimal CSS library so the classes work without a full Bootstrap theme, and — in Custom mode — lets you set every wrapper/element class by hand. Because it is an irreversible transform filter, order it after other markup filters (e.g. after the Video Embed WYSIWYG filter). It has no dependencies beyond core Filter, no Drush commands, and no permissions of its own.

---

- Make WYSIWYG-authored tables responsive (horizontal scroll on small screens) by wrapping them in `table-responsive` without teaching editors to add divs.
- Add the Bootstrap `table` class to editor tables automatically for consistent table styling.
- Make embedded images fluid/responsive by adding `img-fluid` so they never overflow their column.
- Support Bootstrap 3 sites by emitting `img-responsive` instead of `img-fluid`.
- Wrap YouTube/Vimeo embed iframes in a `embed-responsive embed-responsive-16by9` container for fixed-ratio responsive video.
- Add `embed-responsive-item` to video iframes so they fill the responsive wrapper.
- Restrict responsive video wrapping to specific providers by editing the iframe source regex pattern.
- Extend responsive video to additional providers (e.g. add another host to the pattern).
- Cooperate with Video Embed Field by converting its `video-embed-field-responsive-video` wrapper into the Bootstrap wrapper instead of nesting a second one.
- Give editors responsive output without granting them permission to write raw `<div>` markup.
- Run responsiveness only for chosen content types by enabling the filter on some text formats and not others.
- Turn any one behavior on or off independently (tables only, images only, video only) per text format.
- Serve the module's minimal responsive CSS on themes that are not Bootstrap-based, so the classes still work.
- Use it on a Bootstrap theme with no extra CSS, since the theme already defines the classes.
- Define fully custom wrapper and element classes (e.g. for a non-Bootstrap CSS framework) via Custom output mode.
- Standardize responsive markup across many editors and content types from one central filter configuration.
- Keep source markup clean: authors write plain `<table>`, `<img>`, `<iframe>` and the responsive scaffolding is added only at render time.
- Migrate a site from Bootstrap 3 to Bootstrap 4/5 output by switching one setting instead of re-editing content.
- Avoid layout breakage from wide tables on mobile in editorial content.
- Apply consistent 16:9 video framing across all embedded videos site-wide.
- Deploy the same responsive behavior across environments through exported configuration (`responsivewrappers.settings` plus the per-format filter settings).
