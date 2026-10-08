Block Title HTML Element lets an administrator choose, per block, which HTML tag wraps that block's title (from a fixed allowlist such as h2–h6, span, p, em, b, i), defaulting to `strong`.

---

The module adds a "Block Title HTML Element" section to the core block configuration form (visible only to users with the `administer block title element` permission) where an admin picks the wrapper tag for the block's title from a dropdown. The choice is saved as a block third-party setting (`block_title_html_element.title_element`) and exposed to the theme layer as a `title_element` Twig variable via `hook_preprocess_block`. To actually change the rendered markup, the theme's `block.html.twig` must output the title inside `<{{ title_element | default('strong') }}>` (an example template ships in `examples/block.html.twig`). A small service, `ElementValidator`, holds the allowed-tag list and a strict membership check that is applied when the form is submitted, when the block is saved, and again at render time; any tag not on the list falls back to the default `strong`. Other modules can extend the offered tags with `hook_block_title_html_element_allowed_elements_alter()`. The module has no routes, config forms, entities, plugins, or Drush commands, and depends only on core `block`.

---

- Render a specific block's title as an `h2` for correct heading hierarchy on a landing page.
- Demote a sidebar block's title to `h3` or `h4` so it sits below the main page heading.
- Use `span` for a block title that should look like a heading but not appear in the document outline.
- Wrap a promotional block's title in `p` when it is descriptive text rather than a heading.
- Emphasize a call-to-action block title with `em`, `b`, or `i` without adding heading semantics.
- Keep the site-wide default (`strong`) for all blocks except the few that need a specific tag.
- Improve accessibility by giving screen-reader users a meaningful heading level per region.
- Fix an SEO audit finding of skipped or duplicated heading levels caused by themed block titles.
- Standardize heading levels across blocks placed in different regions of the same page.
- Let content editors (granted the permission) adjust a block title tag without touching Twig.
- Differentiate visually-identical block titles by semantic role (heading vs. inline emphasis).
- Avoid multiple `h1`s on a page — the module deliberately omits `h1` from the choices.
- Apply a heading tag to custom/content blocks as well as system blocks, uniformly.
- Provide a per-block override while the theme's global block title tag stays as the fallback.
- Add project-specific tags (e.g. `article`, `header`) to the dropdown via the alter hook.
- Restrict who can change block title tags by granting `administer block title element` narrowly.
- Ensure an invalid or removed tag safely reverts to `strong` instead of breaking the block.
- Migrate a theme away from hard-coded `<h2>` block titles to admin-configurable tags.
- Set `h5`/`h6` on footer or utility blocks that should be low in the heading hierarchy.
- Give marketing blocks inline-emphasis titles (`b`/`i`) that read as body copy, not headings.
- Support multilingual sites where a block's semantic role is consistent regardless of language.
- Audit stored choices in exported block config (`third_party_settings.block_title_html_element`).
- Roll the feature out gradually by copying the example Twig only into the themes that need it.
