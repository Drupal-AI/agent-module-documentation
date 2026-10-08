<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Overview Field is a small field type whose allowed values are supplied by code: a select widget whose options come from `hook_overview_field_options_alter()`, so an editor picks a named "overview" and a module decides what that choice renders.

---

The pattern solves a recurring structural problem. A content type needs a slot where an editor chooses *which* dynamic listing appears — recent news, upcoming events, staff in this department — but the list of available listings is a developer concern, not an editorial one, and it changes with code rather than with content. Storing that choice in a plain text field invites typos; storing it in a config-defined allowed-values list means a config change every time a developer adds one. This field type puts the option list behind an alter hook instead. Install it (`ddev drush en overview_field`, depends only on core **Field**), add an **Overview field** to any entity/bundle under *Manage fields*, and leave *Manage form display* (widget `overview_field_widget`, a `select`) and *Manage display* (formatter `overview_field_formatter`) at their defaults — there are no field- or widget-level settings to fill in. Out of the box the select shows only "No overview": you make it useful by implementing two hooks in a custom module — `hook_overview_field_options_alter(&$options)` to add `$options['my_key'] = t('Label')` entries, and `hook_overview_field_output_alter($key, &$output)` to build the render array for the chosen key (commonly `$output = overview_field_load_view('view_name', 'block_1');`, or a block's `build()`). Enable the bundled **`overview_field_example`** submodule to see a working `recent_content` option, and copy it as your starting point. The stored value is the option key (a 255-char string), not the rendered output; rendering is resolved at display time by the formatter. It integrates with `single_content_sync` for content export/import, and stays deliberately thin — no settings page, routes, services, permissions, or config — the plumbing you would otherwise hand-write, and no more.

---

- Let an editor choose a dynamic listing per node.
- Register listing options from code, not config.
- Avoid typos in a listing key with a fixed select.
- Place a "recent news" block per page.
- Give developers an extension point via alter hooks.
- Choose an overview per node or per bundle.
- Avoid a config change every time you add an option.
- Dispatch rendering on the stored key at display time.
- Provide a select of code-defined options.
- Build a flexible landing-page slot.
- Let multiple modules register their own overviews.
- Choose which staff list appears on a page.
- Add an events listing to a page.
- Load a Views display with `overview_field_load_view()`.
- Render a block from the output hook.
- Provide an empty "No overview" option.
- Replace a hand-rolled select field plus dispatch code.
- Follow the `overview_field_example` submodule as a template.
- Round-trip the field with single_content_sync export/import.
- Attach the field programmatically with FieldStorageConfig/FieldConfig.
