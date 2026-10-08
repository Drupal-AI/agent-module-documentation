<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Accessible external link filter" text-format filter

`src/Plugin/Filter/ExternalLinkA11yFilter.php` — plugin id **`external_link_a11y`**, title
*"Accessible external link filter"*, `type = TYPE_TRANSFORM_REVERSIBLE`, `weight = 0`. Extends
`FilterBase`. It parses the rendered text with `Html::load()`, walks every `<a>` element, and applies
the accessible external-link treatment to in-scope anchors, then re-serialises with `Html::serialize()`
only if something changed.

## Enable it on a text format

UI: *Configuration → Content authoring → Text formats and editors*
(`/admin/config/content/formats`) → edit a format → tick **"Accessible external link filter"** →
set its options → save. Enabling requires the core **`administer filters`** permission (this filter
adds no permission of its own).

## Settings (annotation `settings` + `settingsForm()`)

| Setting key | Default | Meaning |
|---|---|---|
| `external_url` | `true` | In scope when the anchor's `href` is external (`UrlHelper::isExternal()`). |
| `target_blank` | `true` | Also in scope when the anchor already has `target="_blank"`. |
| `add_target_blank` | `true` | Add `target="_blank"` to in-scope links that have no `target` yet. |
| `a11y_new_window` | `true` | Append a visually-hidden "Open in new window" span (and a `title`) to links that open in a new window. Form element is `#states`-hidden unless `add_target_blank` or `target_blank` is on. |
| `rel_noopener` | `false` | Add the `noopener` value to the anchor's `rel` attribute. |
| `rel_noreferrer` | `false` | Add the `noreferrer` value to the anchor's `rel` attribute. |
| `css_classes` | `""` | Space-separated CSS classes added to every processed link's `class` attribute (de-duplicated with existing classes). |
| `html_suffix` | `""` | HTML appended inside the link element via `createDocumentFragment()->appendXML()`. |

Config schema: `filter_settings.external_link_a11y` in `config/schema/external_link_a11y.schema.yml`
(booleans plus two `string` keys `css_classes` and `html_suffix`). Filter settings live inside the text
format config object (e.g. `filter.format.<id>:filters.external_link_a11y.settings`).

## Processing (`process($text, $langcode)`)

1. `Html::load($text)`, `getElementsByTagName('a')`.
2. For each anchor, compute `$in_scope`: `external_url` → `UrlHelper::isExternal($anchor->getAttribute('href'))`;
   if still false and `target_blank` on → `$anchor->getAttribute('target') === '_blank'`.
3. If in scope:
   - `add_target_blank` and no existing `target` → `setAttribute('target', '_blank')`.
   - `rel_noopener` / `rel_noreferrer` → merge those values into the existing `rel` (split on space,
     strict `in_array` de-dupe, re-implode).
   - `css_classes` non-empty → merge into the anchor's `class` (`array_unique`).
   - `a11y_new_window` and `target === '_blank'` → if the anchor has no `title` but has text content,
     set `title` to `t('@title (Open in new window)', ['@title' => textContent])` (then
     `html_entity_decode(..., ENT_QUOTES, 'UTF-8')`; the attribute is re-escaped by DOM serialisation),
     and append `<span class="visually-hidden sr-only"> (Open in new window)</span>`.
   - `html_suffix` non-empty → append it as a parsed document fragment inside the anchor.
4. Only if any anchor changed, `$result->setProcessedText(Html::serialize($dom))`; returns a
   `FilterProcessResult`.

`settingsForm()` renders one checkbox/textfield per setting. `a11y_new_window`, `rel_noopener` and
`rel_noreferrer` are conditionally shown with `#states` tied to `add_target_blank` / `target_blank`.

## Notes

- `css_classes` and `html_suffix` are **administrator-supplied** filter configuration (set by users with
  `administer filters`); they are applied to matched anchors as configured.
- The filter never overwrites an existing `target` or an existing non-empty `title`.
- No routes, permissions, services or hooks of its own; `create()` just instantiates the plugin.
