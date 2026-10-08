<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme: render the subtitle

The module exposes the subtitle to the block template but ships **no template of its own** —
markup and placement are a theme decision.

`block_subtitle_preprocess_block(&$variables)` (`hook_preprocess_HOOK` for `block`):
- Reads `$variables['elements']['#id']`; if empty it does nothing (e.g. blocks rendered by Page
  Manager's block widget have no `#id`, so they get no subtitle variable).
- Otherwise `Block::load($variables['elements']['#id'])`, and if the loaded block has a non-empty
  `block_subtitle:subtitle` third-party setting, sets `$variables['subtitle'] = $subtitle`.

So the template variable is **`subtitle`** (a plain string). Add it to your theme's block template,
`block.html.twig` (or a suggestion like `block--system-powered-by-block.html.twig`):

```twig
{{ title_prefix }}
{% if label %}
  <h2{{ title_attributes }}>{{ label }}</h2>
{% endif %}
{% if subtitle %}
  <p class="block__subtitle">{{ subtitle }}</p>
{% endif %}
{{ title_suffix }}
{% block content %}
  {{ content }}
{% endblock %}
```

`{{ subtitle }}` is auto-escaped by Twig, so the stored text prints as plain text.

Notes:
- The variable is set only when a subtitle exists, so `{% if subtitle %}` is safe.
- The module does not add a template suggestion or CSS library — style `.block__subtitle`
  (or whatever class you use) in your theme.
