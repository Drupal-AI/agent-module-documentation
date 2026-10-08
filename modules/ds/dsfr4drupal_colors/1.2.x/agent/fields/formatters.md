<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatters + swatch component (dsfr4drupal_colors)

All formatters live in `src/Plugin/Field/FieldFormatter/` and target `field_types:
[dsfr4drupal_color_field_type]`.

## Base — `ColorFieldFormatterBase` (abstract)

- `create()` injects `dsfr4drupal_colors.helper.colors` as `$this->helper`.
- `viewRawValue($item)` → `$item->color` (the bare DSFR variable name, e.g. `blue-france-main-525`).
- `viewValue($item)` → `$helper->getColorCssVariable($item->color)` = `--<color>` (the CSS custom
  property name).

## `dsfr4drupal_color_field_formatter_text` — "Color as text" (default)

`ColorFieldFormatterText`. `viewElements()` renders each item as `['#markup' => viewRawValue($item)]`
— the plain variable name. No settings.

## `dsfr4drupal_color_field_formatter_swatch` — "Color swatch"

`ColorFieldFormatterSwatch`.

- `defaultSettings()`: `shape: 'square'`, `width: 50`, `height: 50`.
- `settingsForm()`: `shape` select (circle / parallelogram / square / triangle), `width` /
  `height` textfields (numeric → `px`, otherwise any unit string).
- `viewElements()`: renders the SDC component `dsfr4drupal_colors:color-swatch` with props
  `color` = `viewValue($item)` (`--<color>`), `shape`, `width`, `height`.

### Component `dsfr4drupal_colors:color-swatch`

`components/color-swatch/color-swatch.{component.yml,twig,css}`. Required prop `color` (variable
name). The Twig wraps the prop as `var(<color>)` and sets it as the element's inline `style`
(`background-color` / `width` / `height`, or a triangle via borders) through
`attributes.setAttribute('style', …)` — an auto-escaped attribute context.

## `dsfr4drupal_color_field_formatter_css` — "Color CSS declaration"

`ColorFieldFormatterCss` (implements `ContainerFactoryPluginInterface`; also injects
`module_handler`, `token`, and optional `token.entity_mapper`).

- `defaultSettings()`: `selector: 'body'`, `property: 'background-color'`, `important: TRUE`,
  `advanced: FALSE`, `css: ''`.
- `settingsForm()`: **simple mode** = `selector` (textarea, CSS selector, tokens allowed),
  `property` select (`background-color` / `color`), `important` checkbox. **Advanced mode**
  (`advanced` checkbox) = a raw `css` textarea. If the `token` module is enabled, the `css`
  element gets `token_element_validate` and a token tree link for token types
  `<entity token type>` and `dsfr4drupal_color_field`.
- `viewElements()`: for each item, builds an inline CSS string. Simple mode:
  `<token-replaced selector> { <property>: <helper->getColorCssValue(rawValue)>[ !important]; }`,
  where `getColorCssValue` = `var(--<color>)`. Advanced mode: the token-replaced `css` setting
  verbatim. The result is attached as an `html_head` `<style>` element keyed by `sha1()` of the
  CSS, plus a hidden `<div>` (class `hidden`) holding the raw value so `#attached` propagates in
  Views. `getTokenType()` maps the entity type to its token type (via `token.entity_mapper` if
  available). Selector/CSS come from the formatter settings, which are admin-configured on *Manage
  display*.

## Configure

*Manage display* → pick the formatter and open its settings gear. For the CSS formatter, either
set selector + property (+ important), or switch to advanced mode and write the full statement.
