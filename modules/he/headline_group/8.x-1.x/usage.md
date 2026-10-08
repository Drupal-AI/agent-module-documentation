<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Headline Group is a core-only field type that stores three related text values — a superhead (kicker above), a headline, and a subhead (below) — in one field and renders them as a single semantic heading with styled inner spans, instead of stacking multiple heading tags.

---

The field type `headline_group` has three text columns — `superhead`, `headline`, `subhead` — each a `medium` text column with a `string` property. Two widgets are provided: `headline_complete` (the default; renders a fieldset with a textfield for each enabled part) and `headline_headline_only` (just the headline textfield). Which of superhead/subhead appear in the widget is controlled by two field-instance settings (`include_superhead`, `include_subhead`), and a third setting `title_behavior` governs the headline vs. the parent entity title: `headline_is_blank` (independent headline), `headline_is_flexible` (fall back to the entity title when the headline is left empty — the default), or `headline_is_title` (always copy the entity title, and disable the headline input). The title fallback is resolved in the widget's `massageFormValues()`, which reads the parent entity's label field; it understands normal entity forms, Inline Entity Form subforms (`$form['#entity']`), and Layout Builder block forms (`AddBlockForm` / `UpdateBlockForm`) via the section-storage entity context. The one formatter, `headline_default`, wraps the parts in an outer tag chosen from an admin allowlist (`div`, `h1`–`h6`; default `div`) with a configurable CSS class (default `headline-group`), optional BEM inner classes (`class__super` / `class__head` / `class__sub`, else `super` / `head` / `sub`), and an optional `id` anchor derived from the headline via `Html::cleanCssIdentifier()`. Each part renders through core's `html_tag` render element, so its text is passed through `Xss::filterAdmin()` — inline admin-safe HTML is allowed, scripts and event handlers are not. Note two quirks: `isEmpty()` always returns FALSE (the field is never treated as empty, so a value row is always written), and the FieldType annotation carries a stray `module = "field_monolith"` (cosmetic; provider is still `headline_group`). The module also declares a `hook_help` page (renders README, optionally via the Markdown module) and a non-standard token type `headline_group` with `headline` / `superhead` / `subhead` tokens that a caller must supply data for. No dependencies beyond core; Layout Builder support is soft (used only when present). No permissions, no Drush, no shipped config schema.

---

- Add a kicker / eyebrow label above an article headline.
- Store a headline and a subhead (standfirst) together as one field.
- Model an editorial or news headline with its parts kept related.
- Render a superhead + headline + subhead as a single `<h1>`/`<h2>` with inner spans.
- Avoid the invalid pattern of stacking `<h1>` then `<h2>` for a subtitle.
- Fall back to the node title automatically when the headline is left blank.
- Force the headline to always mirror the entity title (locked field).
- Keep a headline field independent of the page title.
- Add a headline group inside a Layout Builder custom block.
- Add a headline group via Inline Entity Form on a referenced entity.
- Choose the outer heading level (h1–h6 or div) per display.
- Emit BEM-style classes for a design system's headline component.
- Add a stable `id` anchor derived from the headline text for deep-linking.
- Use the headline-only widget where superhead/subhead are not needed.
- Toggle whether editors can enter a superhead or a subhead per field.
- Support a magazine or campaign layout's headline block.
- Allow limited inline markup (em, strong, a) inside a headline safely.
- Provide consistent headline markup across many themes.
- Improve screen-reader heading navigation on article pages.
- Expose headline / superhead / subhead as tokens to a consuming integration.
- Render nothing when all three parts are empty (formatter skips the item).
- Configure headline display (tag, class, BEM, anchor) once in the display settings.
