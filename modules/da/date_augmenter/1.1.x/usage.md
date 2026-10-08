<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Augmenter API is a developer-facing plugin system that lets modules extend or modify the rendered output of date field formatters — adding things like "Add to Calendar" links or related content — which site builders enable and order per formatter instance.

---

The module ships no end-user feature by itself: it defines a `DateAugmenter` plugin type (manager service `plugin.manager.dateaugmenter`, discovery directory `Plugin/DateAugmenter`, PHP attribute `Drupal\date_augmenter\Attribute\DateAugmenter` with legacy annotation fallback, interface `DateAugmenterInterface::augmentOutput()`, base classes `DateAugmenterBase` / `DateAugmenterPluginBase`). A date field formatter opts in by implementing a `supportsDateAugmenter()` method; when it does, `date_augmenter_field_formatter_third_party_settings_form()` injects an "Enabled Date Augmenters" checkbox list, a drag-and-drop weight table, and per-augmenter settings tabs into that formatter's settings form. The chosen configuration is stored as a third-party setting under the `date_augmenter` namespace on the formatter component (schema key `field.formatter.third_party.date_augmenter`, with optional `instances` and `rule` sets when the formatter returns named sets). At render time the formatter calls the enabled plugins (retrieved via `DateAugmenterManager::getActivePlugins()`, sorted by weight) whose `augmentOutput()` mutates the date's render array. The primary supported formatter is contrib **Smart Date**; the augmenter plugins themselves (Add to Calendar, Link, Content, AP Style) live in separate contrib modules. A helper `hook_date_augmenter_plugin_info` alter hook lets other modules tweak the discovered plugin definitions.

---

- Provide the shared plugin contract that "Add to Calendar" date augmenter modules build on.
- Let site builders enable multiple date augmenters on a single Smart Date formatter.
- Order augmenters via a drag-and-drop weight table so their output stacks predictably.
- Configure each augmenter's own settings from the formatter's settings form.
- Add per-formatter-instance date enhancements without writing a bespoke formatter.
- Build a custom augmenter that appends a countdown or "starts in X days" note to dates.
- Wrap date output in a configurable link via a link augmenter plugin.
- Append related content beneath a date via a content augmenter plugin.
- Format dates per AP Stylebook rules through an AP-style augmenter plugin.
- Separately configure augmenters for individual instances vs. recurring-rule dates (the `instances` / `rule` sets).
- Store augmenter configuration in exported config as formatter third-party settings.
- Make your own date formatter augmenter-aware by adding a `supportsDateAugmenter()` method.
- Return named sets from `supportsDateAugmenter()` to get separate augmenter config per set.
- Retrieve the active, weight-sorted augmenter plugins programmatically via `getActivePlugins()`.
- Read augmenter settings from field definitions or rule objects with `getThirdPartyFallback()`.
- Register an augmenter with a PHP attribute (`#[DateAugmenter(...)]`) on Drupal 10/11.
- Register an augmenter with a legacy `@DateAugmenter` annotation for Drupal 9 compatibility.
- Provide a configurable augmenter by implementing `PluginFormInterface` plus `ConfigurablePluginInterface`.
- Alter or remove discovered augmenter definitions with `hook_date_augmenter_plugin_info`.
- Assemble exactly the date-display capabilities a site needs by combining small augmenter plugins.
- Keep date storage untouched while enriching only the rendered display.
