# Themable Forms — manual setup guide

**Themable Forms** (`themable_forms`) makes it far easier to theme Drupal forms. It
adds fine-grained Twig **theme suggestions** for form elements and their labels, and
stamps every form element with the `#form_id` of the form it belongs to — so you can
give a form element custom markup per element type, per form, or per
element-type-within-a-form, all in your theme's templates and without any custom PHP.

Out of the box Drupal themes all `<input>` wrappers through a single
`form-element.html.twig` template, which makes it awkward to style, say, just the
text fields on the article node form. This module offers extra, more specific
template names you can create instead — for example
`form-element--form-id--node-article-form.html.twig` for every element on the
article form, `form-element--type--checkbox.html.twig` for every checkbox site-wide,
or `form-element--node-article-form--textfield.html.twig` for just the text fields on
that one form. It provides matching suggestions for form **labels** too. Because
these are standard Drupal theme-hook suggestions, the more specific the template, the
higher its priority.

The module works the moment you enable it — there is no settings form, no configure
route, no permissions, no config, and no services. It has no module dependencies and
no submodules. Enabling it simply makes the extra suggestions available; you then act
on them by adding Twig templates to your theme.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — the full list of suggestions and file
names — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no admin page or settings form. The module works entirely in the
theme layer.

## How to use it

Once enabled, you consume the module purely by dropping Twig templates into your
theme. Two theme hooks gain extra suggestions.

**Form element wrappers** (`form_element`):

| Template file | Themes… |
|---|---|
| `form-element--type--<type>.html.twig` | all elements of one `#type` (e.g. `checkbox`, `radios`, `select`, `textfield`) |
| `form-element--form-id--<form-id>.html.twig` | all elements on one form |
| `form-element--<form-id>--<type>.html.twig` | one element type on one form (most specific) |

**Form element labels** (`form_element_label`):

| Template file |
|---|
| `form-element-label--type--<type>.html.twig` |
| `form-element-label--form-id--<form-id>.html.twig` |
| `form-element-label--<form-id>--<type>.html.twig` |

A typical workflow:

1. Enable the module (no configuration needed).
2. Copy core's `form-element.html.twig` (or `form-element-label.html.twig`) into your
   theme, renamed after the suggestion you want — e.g.
   `themes/custom/mytheme/templates/form-element--form-id--node-article-form.html.twig`.
3. Run `drush cr` so Drupal discovers the new suggestion template.
4. Edit that template's markup; only the elements matching the suggestion use it.

A couple of naming notes: in file names, underscores in the form id become hyphens
and the `__` separators become `--`, so the suggestion
`form_element__form_id__node_article_form` becomes the file
`form-element--form-id--node-article-form.html.twig`. Drupal always tries the most
specific registered template first, so a `--<form-id>--<type>` template beats a
`--form-id--<form-id>` one, which beats a `--type--<type>` one, which beats the base
`form-element.html.twig`. You can also read `{{ element['#form_id'] }}` inside any
form-element template to branch your markup with Twig logic. The full details and
examples are in the [`agent/` suggestions docs](../agent/theming/suggestions.md).
