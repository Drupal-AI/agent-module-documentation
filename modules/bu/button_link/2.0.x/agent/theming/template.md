<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: template & emitted markup

## Theme hook

`button_link_theme()` registers **`link_formatter_button_link`** with variables: `title`,
`url_title`, `url` (a `Url` object), `type`, `size`, `block`, `additional_class`, `icon_class`.
Each formatted delta is rendered as `#theme => 'link_formatter_button_link'`.

## Preprocess (`template_preprocess_link_formatter_button_link`)

Builds the anchor's attributes:

- adds `role="button"` unless `disable_btn_role` is set;
- class list = `btn` + `<type>` + `<size>` + `<block>` + `<additional_class>`;
- sets `href` from the `Url`, builds `link` via `Link::fromTextAndUrl($title, $url)`;
- exposes `attributes` (the `<a>`) and `icon_attributes` (the `<i>`, carrying `icon_class`).

## Template — `templates/link-formatter-button-link.html.twig`

```twig
<a{{ attributes }}>
  <i{{ icon_attributes }}></i>
  {{ title }}
</a>
```

So a `btn-primary`, large button with a Font Awesome icon renders as:

```html
<a role="button" class="btn btn-primary btn-lg" href="/target"><i class="fa fa-anchor"></i> Label</a>
```

## Overriding

Override the template by copying `link-formatter-button-link.html.twig` into your theme, or
implement `hook_theme_suggestions_link_formatter_button_link_alter()` / a preprocess in your
theme to add variables. The empty `<i>` element is always emitted (icon class may be blank);
remove it in a theme override if you never use icons. Bootstrap `.btn` CSS must come from your
theme — the module ships none.
