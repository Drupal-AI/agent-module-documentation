<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Multiselect registers a Drupal asset library that wraps David Stutz's bootstrap-multiselect jQuery plugin, which renders a multiple-select as a Bootstrap dropdown of checkboxes.

---

The module is deliberately thin: it declares one asset library (`bootstrap_multiselect/multiselect`) that loads the bootstrap-multiselect 1.1.1 CSS and JS — from cdnjs by default, or from the site's `/libraries` folder when the files are present there — and does nothing else. It registers no form element, field widget, configuration form, route, or service, and it does not itself convert any select on a page. Turning a real `<select multiple>` into the checkbox dropdown is left to the consuming theme or module: attach `bootstrap_multiselect/multiselect` to the render array and initialise the plugin (`$('select').multiselect(options)`) in your own JavaScript. That division is a feature — you keep a genuine native select as the underlying element, so keyboard operation, standard form submission and assistive technology continue to work, and the plugin is only presentation on top. The native `<select multiple>` is one of the worst-understood controls on the web: it needs ctrl-click or shift-click to pick more than one option, silently discards earlier selections on a normal click, is nearly unusable on a touch screen, and shows only a few rows however many options exist. A checkbox dropdown is self-explanatory, and on a Bootstrap-themed site this library uses the framework's own dropdown component so it needs no extra styling. When you wire it up, prefer a build that announces how many options are selected (a closed control reading "3 selected") so screen-reader users get the same state a sighted user sees. Version 2.0.3, runs on `^9 || ^10 || ^11`.

---

- Provide the bootstrap-multiselect library to a custom theme without adding it by hand.
- Attach the library to a form and turn a `<select multiple>` into a checkbox dropdown via your own JS.
- Replace ctrl-click multi-selection with self-explanatory checkboxes.
- Make a multi-select usable on a touch screen.
- Improve a category or tags multi-select field's usability.
- Serve the multiselect assets from cdnjs with zero local files.
- Switch to serving the assets locally from `/libraries` for offline or air-gapped sites.
- Match a site's Bootstrap theme by reusing its dropdown component.
- Add a searchable/filterable multi-select to a large option list.
- Show a running count of selected options in a closed control.
- Improve an exposed Views filter that uses a multiple-select.
- Enhance a role-assignment or permissions multi-select on an admin form.
- Reduce accidental deselection mistakes on a long option list.
- Keep a genuine native `<select multiple>` as the underlying element for accessibility.
- Provide select-all / deselect-all controls (a plugin option) on a multi-select.
- Group options under headings using optgroups in the dropdown.
- Standardise multi-select styling across several custom modules by depending on one library.
- Pin a known library version (1.1.1) across a site's front-end code.
- Prototype a Bootstrap multi-select quickly without bundling the plugin yourself.
- Avoid shipping the plugin in every custom module by centralising it in one library.
