Module Filter adds a live filter box (and optional server-rendered tabbed layout) to Drupal's Extend/modules page, update status report, and permissions page so you can quickly find modules and projects by name.

---

Module Filter enhances several long, hard-to-scan admin pages with an instant client-side filter. On the Extend (modules) page it adds a text field that hides modules not matching your input, plus checkboxes to narrow by state (Enabled, Disabled, Unavailable). By default it also converts the package fieldsets into vertical tabs — rendered server-side in 6.0.x so the final layout paints on first load — letting you browse packages quickly, list every module alphabetically, and see per-tab enabled counts and match highlighting; all of it can be toggled on its settings page. The modules filter supports "filter operators" such as `description:`, `requires:` and `requiredBy:` to filter by description or dependency relationships. It similarly filters the update status report by status (All, Update available, Security update, Unsupported) and adds a filter to the permissions page. The 6.0.x branch is a vanilla-JavaScript rewrite that requires **no jQuery and no contrib dependency** ("Nothing, not even jQuery!") and runs on Drupal 11.4+ or 12. Configuration lives at Admin → Configuration → User interface → Module filter and is gated by the `administer module_filter` permission. It is a pure administrator-usability tool with no effect on the front end.

---

- Quickly find a module by typing part of its name on the Extend page.
- Browse modules by package using the server-rendered tabbed layout instead of long fieldsets.
- List all modules alphabetically regardless of package.
- Filter to only enabled modules with the Enabled checkbox.
- Filter to only disabled modules to see what's available to turn on.
- Spot modules that are unavailable due to missing dependencies.
- Use `requires:block` to find modules that require a given module.
- Use `requiredBy:` to find what a module is required by.
- Use `description:` to filter modules by words in their description.
- Combine queries by space-delimiting them, quoting phrases with spaces.
- See a count of enabled modules per package tab.
- Highlight which tab a module belongs to when hovering in the all-modules view.
- Hide tabs with no matches while filtering to reduce clutter.
- Filter the update status report to show only projects with available updates.
- Show only projects with security updates on the update report.
- Show projects that are unsupported on the update report.
- Filter the permissions page to a specific module's permissions.
- Keep the save button reachable on very long module lists.
- Show module machine-name paths in the list for debugging.
- Always expand module description details via a setting.
- See recently enabled and newly available modules flagged in the list.
- Remember the filter value across a form submit/redirect.
- Deep-link to a filtered modules view via the `filter` query parameter.
- Run the filter with no jQuery or contrib dependency on Drupal 11.4+/12.
