# Form template suggestions added by Formdazzle!

Formdazzle adds no config — install it and the suggestions appear. All logic is in
`Drupal\formdazzle\Dazzler`.

## The suffix pattern

For each element that has `#theme` / `#theme_wrappers`, Formdazzle appends:

```
<type_suggestion?>__<form_id_suggestion><__element_name?>
```

So core's `input` / `input--textfield` gains, for a field named `first_name` on form
`webform_contact`:

```
input--textfield--webform-contact.html.twig
input--textfield--webform-contact--first-name.html.twig
```

(Underscores in the machine names become dashes in the template file name, per Drupal's
convention.) The element name comes from `#name`, else `#webform_key`, else the imploded
`#parents` (files use `files_<first-parent>`). It is sanitised to `[a-z0-9_]`.

## How it is applied (so you know timing)

1. `hook_form_alter` (registered late via `hook_module_implements_alter`; module weight set to
   10 on install) stores `#formdazzle['form_id']` and appends `#pre_render => Dazzler::preRenderForm`.
2. At `#pre_render` (after all alters), `traverse()` walks the whole render array. For each
   element it calls `addDefaultThemeProperties()` (pulls default `#theme`/`#theme_wrappers`
   from `element_info`) then `addSuggestions()` to append the suffix to `#theme` and
   `#theme_wrappers`.
3. `hook_preprocess_form_element` appends the same suffix to the element **label's** `#theme`,
   so labels get suggestions like `form_element_label__<form-id>__<name>`.

Because suggestions are added at pre-render, using them requires nothing in your `.theme` /
`hook_theme_suggestions` — just create the template file.

## Special form-ID suggestions (`getFormIdSuggestion`)

| Case | Suggestion used |
|---|---|
| Webform submission form | `webform_<webform_id>` (e.g. `webform_contact`) |
| `views_exposed_form` | folds in View name + display, e.g. `views__frontpage__page_1` |
| Form ID with a trailing number matching the last `#theme` (e.g. commerce add-to-cart) | the simpler last theme suggestion |
| otherwise | the raw form ID |

Elements whose `#type` is `actions`, `more_link`, `password_confirm`, or
`system_compact_link` also get a `__<type>` suggestion because core omits good ones there.

## Twig debug comment for the form template

When `twig.config.debug` is TRUE and the form has a `#theme`, Formdazzle sets `#markup` to an
HTML `<!-- FILE NAME SUGGESTIONS: … -->` comment listing the form-level suggestions — which
core normally hides for the top-level form element (see core issue #2118743). Turn on Twig
debug (`drush config:set system.performance … ` / `services.yml` `twig.config: debug: true`)
to read the full suggestion list straight from page source.

## Create a template to use a suggestion

1. Enable Twig debug and view source of the page with your form.
2. Find the suggestion you want, e.g.
   `<!-- * input--textfield--webform-contact--first-name.html.twig -->`.
3. Copy core's `input.html.twig` (from `core/modules/system/templates`) into your theme's
   `templates/` as `input--textfield--webform-contact--first-name.html.twig`.
4. Clear cache (`drush cr`). That field now renders through your template; other fields are
   unaffected.

The same approach works for `select--…`, `form-element--…`, `form-element-label--…`,
`fieldset--…`, buttons (`input--submit--…`), etc.
