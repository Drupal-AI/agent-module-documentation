<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `date_format_help` render element & form alter

## Install / enable

`composer require drupal/date_format_help` then `drush en date_format_help`. No configuration,
no permission grant, nothing to set up. Visit `/admin/config/regional/date-time/formats/add`
(requires the core **administer site configuration** permission for that form) and the help tables
appear below the pattern field.

## Where it hooks in — `date_format_help.module`

`date_format_help_form_date_format_add_form_alter(&$form, &$form_state)` (target form id
`date_format_add_form`) does exactly two things:

1. `$form['date_format_help'] = ['#type' => 'date_format_help', '#weight' => 101];` — injects the
   custom render element near the bottom of the form.
2. Replaces `$form['date_format_pattern']['#description']` with text linking to
   `https://www.php.net/manual/en/datetime.format.php`.

`date_format_help_theme()` registers a `date_format_help` theme hook with no variables. (Note: the
rendered output is actually assembled by the element's pre-render as nested `#theme => 'table'`
arrays; the registered theme hook has no template of its own in this release.)

## The render element — `src/Element/DateFormatHelp.php`

- Declared with the attribute `#[RenderElement('date_format_help')]`; class
  `DateFormatHelp extends \Drupal\Core\Render\Element\RenderElementBase`.
- `getInfo()` returns `['#pre_render' => [[static::class, 'preRenderDateFormHelp']]]`.
- Two `protected static` data methods return the reference content as arrays keyed
  `section => [char => t('description')]`:
  - `dateFormats()` — sections **Day** (`d D j l N S w z`), **Week** (`W`), **Month**
    (`F m M n t`), **Year** (`L o Y y`).
  - `timeFormats()` — sections **Time** (`a A B g G h H i s u`), **Timezone**
    (`e I O P T Z`), **Full Date/Time** (`c r U`).
- `preRenderDateFormHelp(array $element): array`:
  - Iterates the two format sets. For each section it builds a `#theme => 'table'` array whose
    `#rows` are `[$key, $value, date($key)]` — i.e. the format character, its description, and a
    live example produced by PHP's `date($key)` against the **current server time**.
  - Wraps each section in `<div class="date-time-formatter-help-block"><h3>…</h3>` (via `#prefix`
    /`#suffix`) and the whole set in `<div class="time-formats-help">`.
  - Appends `date_format_help/date_format_add` to `$element['#attached']['library']`.

## Library / CSS — `date_format_help.libraries.yml`, `css/date_format_help.css`

Library `date_format_add` attaches `css/date_format_help.css` (theme group). The CSS floats
`.time-formats-help div.date-time-formatter-help-block` at `width:49%` so the help renders as two
columns. No JavaScript.

## Operating notes

- Output is static, translatable manual text plus `date($char)` examples; there is no user- or
  request-supplied data in the rendered tables.
- To reuse the element elsewhere, add `['#type' => 'date_format_help']` to any render array — it
  self-contains its data and library.
- The `&mdash;` sequences in the descriptions are HTML entities inside `t()` strings, rendered as
  em dashes in the table cells.
