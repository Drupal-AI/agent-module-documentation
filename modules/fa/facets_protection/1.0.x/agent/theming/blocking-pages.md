<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocking-page templates

The subscriber renders one of two standalone HTML pages (full `<html>` documents, not page-region
render arrays) when it blocks a request; both carry `<meta name="robots" content="noindex, nofollow">`
and a minimalist inline style/script to keep resource use low. They are declared in
`facets_protection_theme()` (`hook_theme`) each with a single variable `url` — the corrected facet link
that already includes the current `_fp` token. The active template is chosen by the
`facets_protection.settings:template` config key (see [../config/settings.md](../config/settings.md)).

## `facets_protection_blocking_site` — "Link changed" (default)

File: `templates/facets-protection-blocking-site.html.twig`. Shows a heading "URL changed" and a
"Please wait a moment..." message; after 2.5 seconds a small inline script reveals the corrected link
("Please use this link.") that the visitor can click to reach the intended, tokened results. This is the
`config/install` default (`facets_protection_blocking_site`).

## `facets_protection_blocking_human_site` — "Approve Human"

File: `templates/facets-protection-blocking-human-site.html.twig`. Shows an "Are you human?" prompt with
a click-to-confirm control styled like a lightweight CAPTCHA; after a short delay the control becomes
active and clicking it forwards the visitor to the corrected `url`. Selected via the settings-form
template option value `facets_protection_blocking_human_site`.

## Overriding in a theme

Both templates can be overridden from a custom theme (copy the `.html.twig` into the theme, adjust
markup, clear caches). When customizing, keep the `noindex, nofollow` meta so blocking pages are not
indexed. The templates present only the corrected facet link and static, translatable strings.
