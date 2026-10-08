<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Exposed Filters widget

`src/Plugin/better_exposed_filters/filter/CssToggleSwitch.php` —
`@BetterExposedFiltersFilterWidget(id = "css_toggle_switch", label = "CSS Toggle Switch")`,
extending `Drupal\better_exposed_filters\Plugin\better_exposed_filters\filter\FilterWidgetBase`.
Only available when the **`better_exposed_filters`** module is installed (it is a *suggested*, not
required, dependency). Lets a Views exposed filter be rendered with the `toggle_switch` element.

## Enable / use

1. Install and enable `better_exposed_filters` (`drush en better_exposed_filters`).
2. In a View, expose a filter (best suited to a filter with two options, e.g. a boolean).
3. In the View's **Better Exposed Filters** settings, set that filter's widget to
   **"CSS Toggle Switch"** and configure the three options below.

## Widget settings (`defaultConfiguration()`)

- `toggle_type` — select, `switch-light` ("Light") or `switch-toggle` ("Toggle"); default
  `switch-toggle`.
- `toggle_classes` — textfield of space-separated CSS classes applied to the switch (the library
  classes that decide appearance/behaviour).
- `toggle_on__attributes` — textfield; space-separated classes for the "on" indicator.

`buildConfigurationForm()` renders these three fields on the BEF widget config form.

## What it does at render time (`exposedFormAlter()`)

- Resolves the exposed field id: `group_info['identifier']` when the filter is grouped, otherwise
  `expose['identifier']`.
- Calls `parent::exposedFormAlter()`, then if the form element exists:
  - flattens option objects to strings via `BetterExposedFiltersHelper::flattenOptions()`,
  - sets `#type = 'toggle_switch'` and `#toggle_type` from config,
  - appends `toggle_classes` to `#attributes['class']`,
  - `preg_split`s `toggle_on__attributes` on whitespace and, if any classes result, sets
    `#toggle_on__attributes = ['class' => $classes]`.

All three values are **admin-configured** in the Views/BEF UI (requires the Views admin
permission), not taken from end-user request input; they are emitted as element class attributes.
