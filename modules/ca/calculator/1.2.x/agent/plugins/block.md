<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CalculatorBlock — the calculator block plugin

Everything the module does. Source: `src/Plugin/Block/CalculatorBlock.php`,
`calculator.module`, `templates/calculator-block.html.twig`, `js/script.js`,
`calculator.libraries.yml`, `css/style.css`.

## Install & enable

- `drush en calculator` (or Extend UI). Only dependency is core **`block`**.
- No install hooks, no config to import, no permissions, no settings route.

## The plugin

- Class `Drupal\calculator\Plugin\Block\CalculatorBlock` extends `Drupal\Core\Block\BlockBase`.
- Annotation: `@Block(id = "calculator_block", admin_label = @Translation("Calculator Block"))`.
- `defaultConfiguration()` — sets `$this->configuration['layout'] = 1` and returns
  `['label_display' => FALSE]` (block title hidden by default).
- `build()` — `$layout = $this->configuration['layout'] ?: 1;` → `$content['layout'] = $layout;`
  returns:
  ```php
  ['calculator' => ['#theme' => 'calculator_block', '#content' => $content]]
  ```
  and `$build['#attached']['library'][] = 'calculator/calculator.frontend';`.
- `getCacheMaxAge()` returns **0** — the block is rendered on every request (comment in source
  says "Disable block cache"). There is no dynamic per-request data, so this is effectively a
  no-cache choice rather than a correctness requirement.

## The one setting: layout

- `buildConfigurationForm()` adds a `#type => 'select'` element `layout`, title
  *"Calculator Layout"*, `#default_value => $config['layout'] ?? '1'`, options `'1'`…`'10'`
  labeled *"Layout 1"*…*"Layout 10"*, with wrapper class `calculator-layout`.
- `submitConfigurationForm()` stores `$form_state->getValue('layout')` into
  `$this->configuration['layout']`.
- The value is admin-supplied through the standard block config form (requires
  **administer blocks**) and is only ever emitted as the numeric suffix of a CSS class.

## Theme hook & template

- `calculator_theme()` in `calculator.module` registers hook `calculator_block` with variable
  `content` (default NULL).
- `templates/calculator-block.html.twig` renders a static keypad wrapped in
  `<div class="calculator-theme-{{ content.layout }}">`:
  - Screen: `.display-1` (id `calc-operation`), `.display-2` (id `calc-typed`), `.temp-result`.
  - Buttons: `.all-clear` (AC), `.last-entity-clear` (CE), `.operation` (`%`, `/`, `x`, `-`, `+`),
    `.number` (0–9 and `.`), `.equal` (`=`).
- `content.layout` is a Twig print of an integer config value; Twig auto-escaping applies. There
  is no user/remote data rendered into this template.

## Client-side behavior (js/script.js)

- Library `calculator/calculator.frontend` attaches `css/style.css` + `js/script.js` and depends
  on `core/jquery`, `core/drupal.ajax`, `core/drupal`, `core/drupalSettings`, `core/once`.
- `Drupal.behaviors.calculator_behavior.attach()` scopes to each `.block-calculator-block` element
  by its DOM id, then wires listeners:
  - `.number` clicks append the digit/`.` to `dis2Num` (single decimal point enforced via
    `haveDot`); `.operation` clicks flush the current operand and record `lastOperation`.
  - `mathOperation()` computes with `parseFloat()` and native JS operators: `x`→`*`, `+`, `-`,
    `/`, `%`. `.equal` finalizes; `.all-clear` resets everything; `.last-entity-clear` clears the
    current entry.
  - A `window keydown` handler maps `0-9 .` to number buttons, `+ - / %` and `*`→`x` to operators,
    and `Enter`/`=` to equals.
- **No `eval`, `Function()`, or expression parsing** — arithmetic is done with `parseFloat` and
  fixed operator branches. Nothing is sent to the server.

## Theming / overrides

- Override styling by copying `css/style.css` into a custom theme, or scope rules to a specific
  layout via the `.calculator-theme-N` wrapper class (N = the selected layout number).
- Override markup by copying `templates/calculator-block.html.twig` into the theme's templates
  directory. Keep the JS-relevant classes (`.number`, `.operation`, `.equal`, `.all-clear`,
  `.last-entity-clear`, `.display-1`, `.display-2`, `.temp-result`) so `js/script.js` still binds.

## Placement

- Structure → Block layout (`/admin/structure/block`): place *Calculator Block* into a region,
  choose the layout, set title/visibility. Multiple placements can each use a different layout.
