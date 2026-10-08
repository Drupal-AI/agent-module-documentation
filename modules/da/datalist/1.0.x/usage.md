<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Datalist provides a Drupal render element for HTML5's `<datalist>` — a text input with browser-native suggestions, where the user may pick a suggested value or type their own.

---

`<datalist>` sits between a text field and a select: the browser shows a suggestion list as the user types, but the field still accepts anything. That is the right control for "usually one of these, sometimes something else", and Drupal has no core render element for it. This module adds one — `src/Element` for the render element (used in a form array as `'#type' => 'datalist'`), `templates/input--datalist.html.twig` for the markup, `src/Plugin` for a Webform element (`webform_datalist`, active only when the Webform module is installed), and `src/Cache` + `DatalistSupportedHelper` for browser-support handling. There are no routes, permissions or configuration, and the only dependency is core; Webform is a dev dependency. Options are given as an associative `value => label` array: the label is shown to the user and the value is submitted (a `use_keys` option flips this). The suggestion list itself is a native element, so it works with no JavaScript and inherits the browser's own accessibility handling — a genuine advantage over scripted autocompletes. The module does add optional JavaScript (attached when a clear button is enabled) for a "clear" button and, importantly, a fallback for mobile browsers that render `<datalist>` poorly (mobile Firefox and Edge), where it switches the field to a server-side autocomplete. Dropdown styling is largely not author-controllable and filtering behaviour varies between browsers, so it is a good fit where "close enough, everywhere" beats pixel-identical.

---

- Offer suggestions on a text field without JavaScript.
- Let users pick a suggestion or type their own value.
- Add native autocomplete to a form.
- Suggest common values on a webform.
- Give a free-text field a hint list.
- Avoid a scripted autocomplete widget.
- Inherit browser accessibility for suggestions.
- Provide a datalist render element to custom code.
- Reduce typos on a semi-open field.
- Suggest units, categories or codes.
- Cache a suggestion list.
- Support a form that must work without JS.
- Give an admin form a value hint.
- Reduce load compared with an AJAX autocomplete.
- Offer country or language suggestions.
- Prefill likely values on a survey.
- Use HTML5 semantics in a Drupal form.
- Suggest previously used values statically.
