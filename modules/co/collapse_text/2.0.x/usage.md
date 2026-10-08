Collapse Text is a text-format input filter that turns `[collapse]…[/collapse]` (or `<collapse>…</collapse>`) markers in body text into native HTML5 `<details>`/`<summary>` collapsible sections, with optional titles, initial collapsed state, and CSS classes.

---

The module provides a single filter plugin, `filter_collapse_text` ("Collapsible text blocks",
type `TYPE_TRANSFORM_IRREVERSIBLE`), enabled per text format at `admin/config/content/formats`.
Authors wrap content in `[collapse]…[/collapse]`; `[collapsed]` (alias for `[collapse collapsed]`)
starts a section closed. Tags accept `title="…"` and `class="…"` attributes and may be nested. If no
`title` is given, the filter uses the first `<h1>`–`<h6>` inside the section (removing it to avoid
duplication) and otherwise falls back to a per-format configurable default title. Internally the
filter normalizes the pseudo-tags (`prepare()`), parses them into a nesting tree, and builds Drupal
`#type => details` render elements themed by `collapse_text_details` / `collapse_text_form`; by default
each rendered group is wrapped in an empty `<form>` so the `<details>` markup validates (toggleable via
the "Surround text with an empty form tag" setting or a per-text `[collapse options form="noform"]`
tag). Two Twig templates (`collapse-text-details.html.twig`, `collapse-text-form.html.twig`) and their
`hook_preprocess` functions are overridable for theming. **Filter ordering matters**: it must run
*after* "Limit allowed HTML tags" and after "Convert line breaks into HTML", and after HTML-correcting
filters like `filter_htmlcorrector` — otherwise the generated tags get mangled or the section body
escapes the allowed-HTML restriction. Section titles are escaped (`htmlspecialchars`), but the section
*body* is emitted as marked-safe markup, so the format's other filters remain responsible for
sanitizing author HTML — see `agent/configure/filter.md`.

---

- Build an FAQ page where each answer is hidden until its question is clicked.
- Make long documentation sections collapsible inside node body content.
- Start a section collapsed by default with `[collapsed]…[/collapsed]`.
- Give a section an explicit heading via `[collapse title="Section title"]`.
- Let the filter auto-derive the title from the first `<h2>` in the section.
- Nest collapsible sections inside other collapsible sections.
- Add CSS hooks to a section with `[collapse class="my-class other-class"]`.
- Use angle-bracket form `<collapse>…</collapse>` instead of square brackets.
- Escape a literal `[collapse` in content by prefixing a backslash (`\[collapse`).
- Set a site-wide default title for untitled sections in the filter settings form.
- Suppress the wrapping `<form>` element globally (uncheck the setting) or per field with `[collapse options form="noform"]`.
- Override the default title for one text area with `[collapse options default_title="Click me!"]`.
- Theme the collapsible markup by overriding `collapse-text-details.html.twig`.
- Add preprocessing via `HOOK_preprocess_collapse_text_details()`.
- Provide expandable "read more" style blocks in comments (on a format that allows the filter).
- Create a spoiler/hidden-answer block in quiz or tutorial content.
- Group release notes or changelog entries into collapsible per-version sections.
- Collapse verbose legal/terms text under a summary line.
- Combine `collapsed` + `title` + `class` in one tag: `[collapse collapsed="collapsed" title="Details" class="x"]`.
- Carry inline markup (e.g. `<em>`, `<a>`) from a heading into the generated section title.
- Convert an existing FAQ built with headings into collapsibles without rewriting the titles.
- Provide native, JS-free disclosure widgets (uses the browser's `<details>` element plus `core/drupal.form`).
