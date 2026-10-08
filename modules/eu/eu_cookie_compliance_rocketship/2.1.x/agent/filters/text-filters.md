<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto-wrap text-format filters

Two filter plugins in `src/Plugin/Filter/`, both `TYPE_TRANSFORM_IRREVERSIBLE` and both implementing
`ContainerFactoryPluginInterface` (they inject `renderer`). They exist to feed Cookie Content Blocker
by wrapping embeds in its `<cookiecontentblocker>` element. Both plugin descriptions state they
**require** the "Cookie content blocker filter" and must run **before** it in the text-format pipeline.

Enable them under *Configuration → Content authoring → Text formats and editors* → a format → *Enabled
filters*, then order this filter above the Cookie Content Blocker filter.

## `cookie_content_blocker_filter_auto_iframe` (`CookieContentBlockerAutoIframeFilter`)

- Label: "Cookie content blocker filter - autowrap iframes".
- `process()` → `replaceTags()`: matches every `<iframe>…</iframe>` not already wrapped
  (regex `/(?<!<cookiecontentblocker>)<iframe.*?>.*?<\/iframe>(?!<\/cookiecontentblocker>)/s`) and
  replaces each with `<cookiecontentblocker>…</cookiecontentblocker>` around it (rendered via
  `renderer->renderInIsolation()` on a `Markup::create()` element).
- Use when a rich-text field mixes local content with occasional third-party iframes and you only want
  the iframes gated.

## `cookie_content_blocker_filter_auto_src` (`CookieContentBlockerAutoSrcFilter`)

- Label: "Cookie content blocker filter - autowrap entire field if external src found".
- `process()` → `wrapContent()`: collects all `src="…"` values (regex
  `/src\s*=\s*"(.+?)".*?/s`), computes the site's registered domain from `<front>` (last two labels of
  the host), and if **any** `src` host's last-two-label domain differs, wraps the **entire field** in
  one `<cookiecontentblocker>`. If no external src is found the text is returned unchanged.
- Use when any external embed anywhere in the field should gate the whole field's rendering.

## Notes

- Both build the wrapper with `Markup::create()` and rely, by design, on the other filters in the
  format to have sanitised the markup first — hence the documented ordering requirement (run before the
  Cookie Content Blocker filter, and keep HTML-restricting filters in the pipeline). They add wrapping
  only; they do not introduce or strip content.
- Domain comparison is last-two-labels only, so `sub.example.com` counts as same-site as `example.com`
  but a genuinely different registrable domain is treated as external.
