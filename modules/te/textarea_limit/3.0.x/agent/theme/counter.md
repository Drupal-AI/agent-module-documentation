# Counter markup, theme hook and library

## Theme hook

`textarea_limit_theme()` (`hook_theme`) registers:

| Theme hook | Variables | Template |
|------------|-----------|----------|
| `textarea_limit_remaining` | `limit`, `id` | `templates/textarea-limit-remaining.html.twig` |

Default template output:

```html
<div class="limit-text">
  <div class="limit-count">You have
    <span class="limit-count-number" id="{{ id }}" data-limit="{{ limit }}"></span>
    of {{ limit }} characters remaining.</div>
</div>
```

`{{ limit }}` and `{{ id }}` are Twig-autoescaped. `id` is `<widget-element-id>-counter`;
`limit` is the resolved per-widget or global limit. The jQuery `.limit()` plugin writes the
live remaining count into the `.limit-count-number` span. Override the template in your theme
to change wording/markup.

## CSS

`css/textarea_limit.css` (library component asset) only tightens spacing:

```css
.character-limited .form-item {margin-bottom:0.1em;}
.limit-text {font-size:0.8em; margin-bottom:1em;}
```

## Library

`textarea_limit.libraries.yml` defines:

- `textarea_limit/textarea_limit` — `js/textarea_limit.js` + the CSS; depends on `core/jquery`
  and `textarea_limit/jquery.limit`. Attached automatically by `limitPreRender()`.
- `textarea_limit/jquery.limit` — the counting plugin, declared as an **external remote**
  script loaded from `https://storage.googleapis.com/.../jquery.limit-1.3.js` (Google Code
  Archive), MIT. Because it is remote, editor pages fetch third-party JavaScript from Google's
  host at render time; mirror it locally (change the library `js` entry to a local path) if you
  need self-hosted assets or must avoid the external request.
