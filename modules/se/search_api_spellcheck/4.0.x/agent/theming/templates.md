<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the spellcheck output

`hook_theme()` (in `search_api_spellcheck.module`) registers two theme hooks; templates ship in
`templates/`. Override them in your theme to change the markup.

## `search_api_spellcheck_did_you_mean`
Template: `search-api-spellcheck-did-you-mean.html.twig`. Variables:
- `label` — prefix text (default `Did you mean:`).
- `link` — a `\Drupal\Core\Link` to the corrected search.

Default markup:
```html
<div class="sapi-did-you-mean">
  <span class="did-you-mean-prefix">{{ label }} </span>
  {{ link }}
  <span class="did-you-mean-suffix">?</span>
</div>
```

## `search_api_spellcheck_suggestions`
Template: `search-api-spellcheck-suggestions.html.twig`. Variables:
- `label` — prefix text (default `Spellcheck keyword variations:`).
- `suggestions` — array of `Link` objects, one per keyword variation.

Default markup wraps `label` in `.suggestions-prefix` and lists each suggestion as `<li>` inside
`<div class="sapi-suggestions"><ul>…</ul></div>`.

To restyle, copy the template into your theme's `templates/` dir and adjust; to change the prefix
text, override the `render()` label (subclass the area plugin) or target the CSS classes above.
