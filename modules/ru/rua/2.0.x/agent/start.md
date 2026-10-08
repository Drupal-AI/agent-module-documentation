<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RUA — Remove Uppercase Accents (rua) — agent index

Client-side JS module that removes tonos accents from **Greek** text CSS-rendered in uppercase.
Version **2.0.2**. Core `^10 || ^11 || ^12`. Package `Javascript`. No dependencies, no config,
no routes, no permissions, no PHP classes.

## The rule it encodes
In modern Greek a lowercase word carries a tonos on its stressed vowel — Ελλάδα — and the uppercase
form does **not**: ΕΛΛΑΔΑ, not ΕΛΛΆΔΑ. CSS `text-transform: uppercase` (and `font-variant:
small-caps`) does not apply that rule, so uppercased headings, buttons and menu items on a Greek
site come out visibly wrong to a Greek reader. RUA fixes the rendered DOM.

## Entire mechanism
- `rua.module` — `rua_page_attachments()` attaches the `rua/rua` library on **every** page. That is
  the whole PHP surface.
- `rua.libraries.yml` — `rua/rua` = `js/jquery.rua.js`, depends on `core/jquery` +
  `core/drupalSettings`.
- `js/jquery.rua.js` — adds jQuery pseudo-selectors `:uppercase` (computed `text-transform ===
  "uppercase"`) and `:smallcaps` (computed `font-variant === "small-caps"`). On `document.ready`
  and on every `ajaxComplete`, it runs `$(":uppercase").not(".fieldset-legend").removeAcc()` (same
  for `:smallcaps`). `removeAcc` reads `innerHTML` (or `.value` for inputs), applies a fixed chain
  of Greek accent → plain replacements, and writes the string back.

## Notes for agents
- **Presentation-only, in the browser.** It never changes stored content, the search index, or what
  crawlers/copy-paste extract — only the live DOM.
- **Greek-only and hardcoded.** The replacement map lives in the JS; extending to another language
  means editing `js/jquery.rua.js` — there are no settings.
- **`fieldset` legends are deliberately excluded** via `.not(".fieldset-legend")`.
- **Better fix where you control markup:** a correct `lang="el"` lets the browser cased-render Greek
  itself; RUA is the blanket fallback for strings that lack it.
- No `configure` route — nothing to visit in admin after enabling. Just enable the module.

See `../usage.md` for prose + use cases, `../data.json` for metadata.
