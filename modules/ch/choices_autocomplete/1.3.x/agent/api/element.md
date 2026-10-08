<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `choices_autocomplete` render element, alter hook, libraries & theme

## The render element

`src/Element/ChoicesAutocomplete.php` defines `@FormElement("choices_autocomplete")`, extending core
`Select`. Use it in any form to get the Choices.js select UI:

```php
$form['custom_element'] = [
  '#type' => 'choices_autocomplete',
  '#title' => $this->t('My select'),
  '#options' => ['no' => $this->t('No'), 'yes' => $this->t('Yes')],
  '#multiple' => TRUE,
];
```

Element-specific properties (beyond core `Select`):

| Property | Purpose |
|---|---|
| `#choices_autocomplete_options` | The `options.instance` / `options.plugin` settings array (see [../fields/widgets.md](../fields/widgets.md)). Empty falls back to `ChoicesAutocompleteDefaults::getOptions()`. |
| `#cardinality` | Optional; when set and not unlimited, becomes Choices.js `maxItemCount`. |

`processChoicesAutocomplete()` (the element's `#process`) attaches the `choices_autocomplete/choices`
library and the `.choices-autocomplete` class, adds the active-theme add-on library, publishes the
settings to `drupalSettings.choices_autocomplete[<#id>]`, invokes the alter hooks, injects the
placeholder/empty option, then runs core `Select`'s original process callbacks (saved as
`#process_select`).

## Alter hook

`choices_autocomplete.api.php` documents `hook_choices_autocomplete_element_alter()`, invoked by the
element for both modules (`ModuleHandler::alter`) and themes (`Theme::alter`):

```php
function hook_choices_autocomplete_element_alter(array &$element, array &$settings, FormStateInterface $form_state): void {
  $settings['plugin']['loadingText'] = t('One moment…');
}
```

`$settings` is a reference to the same array published to `drupalSettings`, so changes reach the JS
(`Drupal.behaviors.choicesAutocomplete`).

## Libraries (bundled, no CDN)

Declared in `choices_autocomplete.libraries.yml`; Choices.js is compiled into the module's own assets
via webpack — nothing is fetched from a remote host.

| Library | Assets | Depends on |
|---|---|---|
| `choices_autocomplete/choices` | `public/css/widget.css`, `public/js/widget.js` | `core/drupal`, `core/once`, `core/drupal.ajax` |
| `choices_autocomplete/choices.claro` | `public/css/claro.css` | — |
| `choices_autocomplete/choices.olivero` | `public/css/olivero.css` | — |

The Claro/Olivero add-ons are attached automatically when that theme is active.

## Theme hook

`hook_theme()` registers `choices_autocomplete` with `base hook => 'select'`;
`hook_theme_suggestions_select_alter()` adds the `choices_autocomplete` suggestion whenever
`#choices_autocomplete_options` is present, so the element renders through
`templates/choices-autocomplete.html.twig` (a `<select>` with the same escaping as core's select
template). Override that template or the libraries in a theme to restyle the control.
