<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Themable Forms — theme suggestions & templates

Themable Forms is entirely theme-layer. It exposes extra Twig template suggestions for two core
theme hooks and gives every form element the `#form_id` of its form. You use it by dropping Twig
templates into your theme.

## `#form_id` on every element

`themable_forms_form_alter()` walks the form render array recursively and sets
`$element['#form_id']` on each child (unless already set) to the form's id, e.g.
`node_article_form`, `user_login_form`, `views_exposed_form`, `contact_message_feedback_form`.
You can read `{{ element['#form_id'] }}` in templates, and it powers the suggestions below.

## `form_element` suggestions

Added by `themable_forms_theme_suggestions_form_element()` for the core `form_element` theme hook:

| Suggestion | Template file | Matches |
|---|---|---|
| `form_element__type__<type>` | `form-element--type--<type>.html.twig` | all elements of a `#type` |
| `form_element__form_id__<form_id>` | `form-element--form-id--<form-id>.html.twig` | all elements on a form |
| `form_element__<form_id>__<type>` | `form-element--<form-id>--<type>.html.twig` | a type on one form (most specific) |

`<type>` is the element `#type` (e.g. `textfield`, `checkbox`, `radios`, `select`, `email`).
`<form_id>` is the form id. In file names, underscores in the suggestion become hyphens **and** the
`__` separators become `--`, so `form_element__form_id__node_article_form` →
`form-element--form-id--node-article-form.html.twig`.

Priority: Drupal tries the most specific registered template first, so
`form-element--<form-id>--<type>` beats `form-element--form-id--<form-id>` beats
`form-element--type--<type>` beats the base `form-element.html.twig`.

## `form_element_label` suggestions

Added by `themable_forms_theme_suggestions_form_element_label()` for the `form_element_label` hook.
`themable_forms_preprocess_form_element()` first copies `#form_id` and `#form_element_type` onto the
label element so these have data:

| Suggestion | Template file |
|---|---|
| `form_element_label__type__<type>` | `form-element-label--type--<type>.html.twig` |
| `form_element_label__form-id__<form_id>` | `form-element-label--form-id--<form-id>.html.twig` |
| `form_element_label__<form_id>__<type>` | `form-element-label--<form-id>--<type>.html.twig` |

Note the label's form-id suggestion uses `form-id` (hyphen) as the middle token, matching the source.

## Using it

1. Enable the module (no configuration needed).
2. In your theme, copy core's `form-element.html.twig` (or `form-element-label.html.twig`) to a file
   named after the suggestion you want, e.g.
   `themes/custom/mytheme/templates/form-element--form-id--node-article-form.html.twig`.
3. `drush cr` to rebuild the theme registry so the new suggestion template is discovered.
4. Edit the template markup as needed; only elements matching the suggestion use it.

## Discovering available suggestions for a form

Build the form and inspect the attached `#form_id`, or call the suggestion hook directly:

```php
$vars = ['element' => ['#type' => 'textfield', '#form_id' => 'node_article_form']];
themable_forms_theme_suggestions_form_element($vars);
// => ['form_element__type__textfield',
//     'form_element__form_id__node_article_form',
//     'form_element__node_article_form__textfield']
```

There is no configuration, permission, or Drush command — the module's whole surface is these
suggestions plus the `#form_id` attachment.
