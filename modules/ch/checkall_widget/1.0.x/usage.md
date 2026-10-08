Checkall Widget adds "Check all" and "Uncheck all" buttons to Drupal's standard checkbox/radio (options_buttons) field widget so editors can toggle every option at once.

---

Checkall Widget ships a single field widget plugin, `checkall_widget_options_buttons` (class `CheckallOptionsWidget`), which extends core's `OptionsButtonsWidget`. Select it in a field's Manage form display for boolean, entity_reference, list_integer, list_float, or list_string fields configured to allow multiple values. On top of the normal checkbox list it renders two `<button>` elements ("Check all" / "Uncheck all") and attaches a small jQuery behavior (`js/checkall_widget.js`, library `checkall_widget/checkall_widget`) that, on click, sets or clears the `checked` state of every checkbox inside that widget's `field--widget-checkall-widget-options-buttons` wrapper. There is no admin settings page, no route, no permission, no service, and no config schema of its own — it is purely a display-layer convenience over the core widget and stores exactly the same allowed-option values the core widget would.

---

- Add a bulk select-all / clear-all control to a long list of checkboxes on a content edit form.
- Speed up tagging content against a many-term entity_reference (taxonomy) field rendered as checkboxes.
- Let editors quickly select every option of a `list_string` field (e.g. days of week, categories) then deselect a few.
- Provide a "select all" affordance for a multi-value boolean/options field on a node, media, or custom entity form.
- Reduce clicks when an editor almost always wants every option checked (opt-out workflow).
- Clear all selections in one click before re-selecting a small subset (opt-in workflow).
- Apply to a `list_integer` rating/priority multi-select field to toggle all values at once.
- Apply to a `list_float` field of numeric options where editors frequently select the full set.
- Use on user-profile fields (e.g. interests, notification categories) rendered as checkboxes.
- Improve editor ergonomics on webform-like custom forms that use core options_buttons widgets.
- Swap in as a drop-in replacement for the core "Check boxes/radio buttons" widget without changing stored data.
- Offer a keyboard/mouse shortcut for mass selection without writing custom JavaScript.
- Standardize a check-all UX across multiple fields and content types via Manage form display.
- Enable on entity_reference fields (nodes, taxonomy terms, users) exposed as checkbox lists.
- Combine with field cardinality "unlimited" or a fixed multi-value limit for full-list selection.
- Retrofit existing sites: change only the widget in form display; existing field data is unaffected.
- Support content moderation / editorial teams that need to bulk-toggle flags or categories quickly.
- Use during data-entry migrations where staff manually check large option sets repeatedly.
- Provide a lightweight alternative to heavier multi-select JS libraries for simple check-all needs.
- Works across Drupal 8, 9, 10, and 11 (core_version_requirement `^8 || ^9 || ^10 || ^11`).
