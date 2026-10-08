# `views_delimited_list` Views style plugin

The module's entire surface is one Views **style** plugin plus the theme/preprocess plumbing that
renders it. There are no routes, services, permissions, or config UI of its own — you pick this style
on a View's **Format** and tune it in the style **Settings** dialog.

- Plugin: `@ViewsStyle(id = "views_delimited_list")`, title *"Delimited text list"*,
  help *"Display rows as an inline, delimited list of text."*
- Class: `Drupal\views_delimited_list\Plugin\views\style\ViewsDelimitedListStyle`
  (`src/Plugin/views/style/ViewsDelimitedListStyle.php`), extends
  `Drupal\views\Plugin\views\style\StylePluginBase`.
- `theme = "views_view_delimited_list"`, `display_types = { "normal" }`.
- `protected $usesRowPlugin = TRUE;` and `protected $usesFields = TRUE;` — it uses a Views **row**
  plugin and expects **Fields** in the display. (README/UI note: the fields shown must be *inline*
  for the run to read on one line.)
- No new plugin **type** is defined — this is a plugin *instance* of core's `views_style` type.

## Options (config keys)

Defined in `defineOptions()` and built in `buildOptionsForm()`. These are the mapping keys under the
config schema `views.style.views_delimited_list` (`config/schema/views_delimited_list.schema.yml`),
stored on the display as `style_options`:

| Key | Form title | Type | Default | Notes |
|---|---|---|---|---|
| `delimiter` | Delimiter text | textfield (string) | `', '` | Text placed *between* items (leading/trailing spaces are literal). |
| `conjunctive` | Conjunctive text | textfield (string) | `' and&nbsp;'` | The "and"-style word before the final item. See the escaping note below. |
| `long_count` | Long list count | select (int) | `3` | Options `2` or `3`. Threshold for "long list" behavior; picking `2` makes the two-item case use the long-list separator. |
| `separator_two` | Separator between two items | radios (string) | `'conjunctive'` | One of `delimiter` \| `conjunctive` \| `both`. Applies when the list has exactly 2 rows. |
| `separator_long` | Separator before last item in long list | radios (string) | `'both'` | One of `delimiter` \| `conjunctive` \| `both`. Applies to lists at/over `long_count`. Lets you switch between US ("A, B, and C") and UK ("A, B and C") style. |
| `prefix` | Prefix | textfield (string) | `''` | Inline text before the whole list. |
| `suffix` | Suffix | textfield (string) | `''` | Inline text after the whole list. |

The `long_count`, `separator_two`, `separator_long`, `prefix`, `suffix` elements are nested in
`length_behavior` / `additional` fieldsets but flattened back with
`'#parents' => ['style_options', <key>]` so they still save as top-level style options.

## Separator logic (`Drupal\views_delimited_list\ViewsDelimitedList`)

`src/ViewsDelimitedList.php` is a plain helper (constructed with the `ViewExecutable` and the `rows`
array) that decides, per row, whether a delimiter and/or a conjunctive follows it. It returns two
boolean arrays consumed by the template.

- `getSeparator()`: if the row count is exactly `2` **and** `long_count` is not `2`, use
  `separator_two`; otherwise use `separator_long`. (So setting `long_count = 2` routes even the
  two-item list through `separator_long`.)
- `getDelimiters()` → `has_delimiter[i]`: a delimiter follows every item strictly before the
  second-to-last, and follows the second-to-last only when the active separator is `delimiter` or
  `both`. Never follows the last item.
- `getConjunctives()` → `has_conjunctive[i]`: a conjunctive is emitted only before the **last** item
  (i.e. on the second-to-last row) and only when the active separator is `conjunctive` or `both`.

Worked examples (defaults): a 2-row list renders `A and B` (separator `conjunctive`); a 4-row list
renders `A, B, C, and D` (separator `both` → delimiter after C *and* conjunctive before D). These
match the module's own `tests/src/Functional/DelimitedStyleTest.php`.

## Theme layer (`views_delimited_list.module`)

- `views_delimited_list_theme()` registers the `views_delimited_list_fields` theme hook.
- `views_delimited_list_theme_registry_alter()` copies the variable definitions of core
  `views_view_fields` onto `views_delimited_list_fields`, and of core `views_view` onto
  `views_view_delimited_list`.
- `template_preprocess_views_view_delimited_list(&$variables)` instantiates `ViewsDelimitedList` and
  sets `$variables['has_delimiter']`, `$variables['has_conjunctive']`, and
  `$variables['options']` (= `$view->style_plugin->options`).
- `views_delimited_list_preprocess_views_view_fields(&$variables)` — when the active style is
  `ViewsDelimitedListStyle`, unshifts `views_delimited_list_fields` onto `theme_hook_suggestions`
  so the row uses the whitespace-free fields template.

## Templates

- `templates/views-view-delimited-list.html.twig` — the wrapper. Emits (all Twig-autoescaped, no
  `|raw`): optional `{{ title }}` in an `<h3>`, then a `<div class="views-delimited-list">` with an
  optional `.views-delimited-list-prefix` span, then per row a `.views-row` span holding `{{ row }}`
  followed conditionally by a `.views-row-delimiter` span (`options.delimiter`) and a
  `.views-row-conjunctive` span (`options.conjunctive`), gated on `has_delimiter[i]` /
  `has_conjunctive[i]`, and finally an optional `.views-delimited-list-suffix` span.
- `templates/views-delimited-list-fields.html.twig` — a whitespace-trimmed copy of core
  `views-view-fields.html.twig` (loops `fields` printing `field.separator`, `field.wrapper_prefix`,
  `field.label_html`, `field.content`, `field.wrapper_suffix`). It exists to strip the extra
  per-field whitespace core would otherwise emit, so the run stays inline.

No CSS/JS library ships with the module; the `.views-*` classes above are hooks for site theming only.

## Escaping / gotcha

Every printed variable (`options.prefix`, `options.delimiter`, `options.conjunctive`,
`options.suffix`, `title`, and the field parts) goes through Twig's default autoescaping — there is
no `|raw`, `Markup`, or `#markup` anywhere in the module. One consequence: the default `conjunctive`
value `' and&nbsp;'` contains a literal `&nbsp;` entity, which autoescaping renders as the visible
text `and&nbsp;` rather than a non-breaking space. If you want an actual non-breaking space, set the
conjunctive to a plain string with a real space (or a real NBSP character), not an HTML entity.
