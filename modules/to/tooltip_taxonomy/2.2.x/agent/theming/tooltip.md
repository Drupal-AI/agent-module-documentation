# Theming Tooltip Taxonomy

## Theme hook + template

`hook_theme()` in `tooltip_taxonomy.module` registers `tooltip_taxonomy` with variables `tooltip_id`,
`term_name`, `description`. Template `templates/tooltip-taxonomy.html.twig`:

```twig
<span class="tx-tooltip" tabindex="0">
  {{ term_name }}
  <span class="tx-tooltip-text">
     {{ description }}
  </span>
</span>
```

Both `term_name` and `description` are printed through Twig (autoescaped). `description` is already
`Xss::filter()`-sanitized (display-alter path) or `strip_tags`-sanitized (field formatter) before it reaches the
template. `tabindex="0"` makes the tooltip keyboard-focusable. Override the template in your theme to change
markup.

## CSS library

Library `tooltip_taxonomy/simple_tooltip` (`tooltip_taxonomy.libraries.yml`) loads `css/tooltip.css`, styling
`.tx-tooltip` (the inline trigger, dashed underline, `cursor: help`) and `.tx-tooltip-text` (the hidden bubble,
shown on `:hover`/`:focus`). It is attached automatically by the display-alter when tooltips are injected. There
is no JavaScript — visibility is pure CSS hover/focus.

Note: an older release used classes `tooltip` / `tooltiptext`; update hook `tooltip_taxonomy_update_8101`
rewrites allowed-HTML config to the current `tx-tooltip` / `tx-tooltip-text` names.
