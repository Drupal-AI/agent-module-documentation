# Theming Collapse Text

`collapse_text_theme()` (in `collapse_text.module`) registers two theme hooks, both taking a
`render element` named `element`:

| Hook | Template | Renders |
|---|---|---|
| `collapse_text_details` | `templates/collapse-text-details.html.twig` | one collapsible section (a core `#type => details`) |
| `collapse_text_form` | `templates/collapse-text-form.html.twig` | the outer `<form>` wrapper that holds the sections |

Both stock templates simply print `{{ element }}`; override them in your theme to customize markup.
Standard preprocess hooks apply, e.g. `mytheme_preprocess_collapse_text_details(&$variables)`.

## How the render tree is built (for context)

`CollapseText::process()`:
1. `checkOptions()` extracts a leading `[collapse options …]` tag (sets `form`/`default_title`).
2. `findTags()` + `findLevels()` locate every `[collapse]`/`[/collapse]` and compute nesting depth.
3. `processRecurseLevels()` turns the flat tag list into a tree; `processRecurseTree()` maps it to
   render elements — text runs become `#markup` (`Markup::create`), each section becomes
   `#type => details` (`#theme => collapse_text_details`) with `#title`, `#open`, and CSS `#attributes`.
4. If the `form` option is on, the whole thing is nested under `#type => form`
   (`#theme => collapse_text_form`) with a unique generated id; otherwise a plain `<div>` wrapper.
5. The tree is rendered back to an HTML string returned in a `FilterProcessResult`.

CSS classes added to each section: `collapse-text-details`, `collapsible`, plus `collapsed` when
closed, `collapse-text-default-title` when the fallback title was used, and any author `class="…"`
values (each run through `Html::cleanCssIdentifier`). The frontend uses core's `core/drupal.form`
library (attached in `collapse_text_preprocess_page()`) — no jQuery, just the browser `<details>`.
