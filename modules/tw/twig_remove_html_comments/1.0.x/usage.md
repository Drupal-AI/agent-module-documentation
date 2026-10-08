Registers a Twig extension that adds two filters for stripping HTML comments (`<!-- ... -->`) out of rendered markup inside Twig templates.

---

The module is a single Twig extension service (`twig_remove_html_comments.remove_html_comments`, class `RemoveHtmlComments`) tagged `twig.extension`, with no configuration, permissions, routes, plugins or schema. It exposes two filters: `remove_html_comments`, which returns a render array `['#markup' => <cleaned>]`, and `remove_html_comments_as_string`, which returns the cleaned value as a plain string. Both run the input through the regular expression `/<!--(.|\s)*?-->\s*|\r|\n/`, so in addition to removing HTML comments (including multi-line ones) they also strip trailing whitespace after a comment and every carriage-return and newline character from the string. A `NULL` input yields an empty string (or `['#markup' => '']`). Because the filters operate on already-rendered markup, you typically pipe a field or value through `|render` first. The string variant is handy when you need the value inside another expression; the render-array variant is convenient when the result is printed directly in a template.

---

- Strip HTML comments from a rendered field before printing it in a Twig template.
- Remove editor/debug comments (e.g. `<!--Start DEBUG-->…<!--End DEBUG-->`) from output.
- Clean comments injected by WYSIWYG editors or pasted content out of node body markup.
- Reduce page weight slightly by dropping comment noise from rendered regions.
- Remove conditional-comment cruft from imported/legacy HTML before display.
- Hide internal annotations kept in content source but not meant for visitors.
- Print a comment-free version of `content.field_x` with `{{ content.field_x|render|remove_html_comments }}`.
- Get a comment-free string to feed into another Twig function or comparison via `remove_html_comments_as_string`.
- Collapse newlines out of a rendered snippet (side effect of the filter's regex) for inline output.
- Sanitise markup before passing it to a length/trim/truncation filter so comments don't skew counts.
- Clean third-party embed markup that ships with framework comments.
- Remove templating comments left by other render pipelines in a specific template override.
- Produce cleaner HTML in emails or export templates rendered through Twig.
- Strip comments from a block's rendered content in a block template override.
- Avoid leaking developer TODO/notes accidentally left as HTML comments in content.
- Normalise output in a component/SDC template where upstream markup carries comments.
- Clean menu or view row markup in a template before further string processing.
- Present a tidy preview of user-submitted HTML with comments removed.
- Remove comments from a rendered entity in a custom `node--type.html.twig`.
- Use as a lightweight, dependency-free alternative to a custom preprocess function for the same job.
