<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Onomasticon filter

All configuration is per **text format**. There is no standalone settings route. Edit a format at
`admin/config/content/formats/manage/{format}`, enable **Onomasticon Filter**, then set its options
in the per-filter settings that appear below. In config, the values live on the
`filter.format.{format}` config entity under `filters.filter_onomasticon.settings.*`.

Plugin: `filter_onomasticon` — `src/Plugin/Filter/FilterOnomasticon.php`, extends `FilterBase`,
`type = Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`. **No config schema ships**
for these settings, so validate spelling yourself when writing config directly.

## Settings (key — default — meaning)

| Key | Default | Type / options | Meaning |
|---|---|---|---|
| `onomasticon_vocabulary` | `""` | vocabulary machine id | **Mandatory.** The glossary vocabulary. Empty ⇒ `process()` returns the text unchanged (no-op). |
| `onomasticon_definition_field` | `"description"` | field machine name | Term field holding the definition. If the term lacks that field, falls back to `description` (`FilterOnomasticon.php:344`). |
| `onomasticon_definition_filters` | `false` | bool | If true **and** the field type is `text`/`text_with_summary`/`text_long`, the definition is run through `check_markup()` with the field's own format. UI warns this **can infinite-loop and break the site** if definitions themselves contain glossary terms. |
| `onomasticon_tag` | `"dfn"` | `dfn` \| `abbr` \| `cite` | HTML tag wrapping each match. |
| `onomasticon_disabled` | `"abbr audio button cite code dfn form meta object pre style script video"` | space-separated tag names | Ancestor tags in which matches are **skipped**. Each entry is sanitized to `[a-z1-6]` (`FilterOnomasticon.php:232`). The chosen `onomasticon_tag`, `a`, and `nonomasticon` are always appended to this list. |
| `onomasticon_implement` | `"extra_element"` | `extra_element` \| `attr_title` \| `accessibility_first` | How the definition is attached to the match (see below). |
| `onomasticon_orientation` | `"below"` | `above` \| `below` | Tooltip position. Only used by `extra_element` / `accessibility_first` (form `#states`-hidden otherwise). |
| `onomasticon_cursor` | `"default"` | `default` \| `help` \| `none` | Mouse cursor over a match; anything but `default` adds `onomasticon-cursor-{value}`. |
| `onomasticon_repetition` | `""` | `""` \| `text` \| `page` | `""` = annotate every occurrence; `text` = first occurrence per text block only; `page` = first occurrence per page (uses the request-static caches in the `.module`). |
| `onomasticon_ignorecase` | `false` | bool | If true, matches are case-insensitive (CamelCase too). If false, only the exact case or first-letter-capitalized form matches. |
| `onomasticon_termlink` | `false` | bool | Appends an off-canvas AJAX "read more" link to the term entity inside the tooltip. Only rendered for `extra_element` / `accessibility_first`. |

## Matching mechanism (`process()` → `processChildren()` → `replaceTerms()`)

1. Text is loaded into a `Masterminds\HTML5` DOMDocument (`<html><body>…</body></html>`), normalized,
   and the `<body>` is walked recursively. The current ancestor tag path is tracked in `$htmlTree`.
2. For each non-whitespace `#text` node whose ancestor path contains none of the disabled tags, the
   node value is passed to `replaceTerms()`.
3. Terms come from `getTaxonomyTerms()`:
   `entityTypeManager->getStorage('taxonomy_term')->loadByProperties(['vid' => vocabulary, 'status' => TRUE])`
   — **published terms only** — then `->alter('onomasticon_terms', $terms)` (see
   [../hooks/index.md](../hooks/index.md)). Only terms with a translation in the current **content
   language** are used (`hasTranslation()` / `getTranslation()`).
4. If the **Synonyms** module is installed (`synonyms.provider_service` exists), each term's synonyms
   are added as additional needles.
5. A match uses a word-boundary regex
   `/(?<![a-zA-Z0-9_äöüÄÖÜ])` + `preg_quote($needle)` + `(?![a-zA-Z0-9_äöüÄÖÜ])/`; `preg` limit is 1
   when repetition is on, else unlimited. Each rendered replacement is built via
   `\Drupal::service('renderer')->render()` on a `#theme => 'onomasticon'` element, stashed as a
   placeholder, then substituted. Replacements are applied to the DOM as document fragments
   (`appendXML`), and a fragment that fails to parse is silently dropped (`try/catch`).
6. Result carries cache tag `taxonomy_term_list:{vocabulary}`. Any leftover `<nonomasticon>` editor
   tags are stripped from the final output (`removeCustomTag()`, regex on `nonomasticon`).

## The three implementation modes (rendered markup)

Template `templates/onomasticon.html.twig` (attaches library `onomasticon/default`). Base class
`onomasticon`; `needle` = matched text; `description` = the term definition; `termpath` =
`$term->toUrl()`.

- **`extra_element`** (default): `<{tag} class="onomasticon onomasticon-extra-element
  onomasticon-orientation-{orientation}" tabindex="0" title="{needle}"><button disabled
  class="onomasticon-term-description">{description}</button></{tag}>`. With `termlink`, a
  `<p><a class="use-ajax" data-dialog-type="dialog" data-dialog-renderer="off_canvas">read more</a></p>`
  is appended. Uses a disabled `<button>` deliberately (only phrasing element that may hold block
  content). `description` here is a plain string, so Twig auto-escapes it — HTML in a definition
  shows literally unless `onomasticon_definition_filters` is on (then it is `check_markup()` output).
- **`accessibility_first`**: `<span class="onomasticon onomasticon-accessibility-first
  onomasticon-orientation-{orientation}"><{tag} tabindex="0"
  aria-describedby="{definition|abbreviation|title-of-work}">{needle}</{tag}><span id role="tooltip"
  hidden class="onomasticon-term-description">{description|striptags('<a><b><br><em><img><s><small><span><strong><sub><sup><time>')}</span></span>`.
- **`attr_title`**: `<{tag} class="onomasticon" title="{description}">{needle}</{tag}>`. Before
  rendering, the PHP `strip_tags()`es the description, removes `"`, converts `&nbsp;`, and collapses
  whitespace (`FilterOnomasticon.php:353-363`) — attributes cannot hold markup.

## Example config fragment

```yaml
# filter.format.full_html.yml (excerpt)
filters:
  filter_onomasticon:
    id: filter_onomasticon
    status: true
    weight: 10
    settings:
      onomasticon_vocabulary: glossary
      onomasticon_definition_field: description
      onomasticon_definition_filters: false
      onomasticon_tag: dfn
      onomasticon_implement: extra_element
      onomasticon_orientation: below
      onomasticon_repetition: page
      onomasticon_ignorecase: false
      onomasticon_termlink: true
```

Tip (from the project page): term match order follows vocabulary term order, so put longer terms
("stone wall") above shorter overlapping ones ("stone") for the longer phrase to win.
