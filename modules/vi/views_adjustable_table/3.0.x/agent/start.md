<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Adjustable Table (views_adjustable_table) — agent index

**Views table style whose columns end users can show/hide (and reorder) through an exposed selector.**

- **Version:** 3.0.x  (info.yml `3.0.0`)
- **Core:** ^11  •  **Depends on:** views
- **Style plugin:** `@ViewsStyle("adjustable_table")` extends core Table — `src/Plugin/views/style/AdjustableTable.php`
- **Filter plugin:** `@ViewsFilter("at_selection")` — `src/Plugin/views/filter/SelectionHandler.php` (always exposed)
- **Pre-render:** `src/BsmSelect.php` (`TrustedCallbackInterface`, escapes settings to `drupalSettings`)
- **Assets:** `views_adjustable_table.libraries.yml` (bsmselect + core jQuery UI sortable)

**Security:** No routes or permissions; configured in the Views UI (requires *administer views*). The end-user-facing surface is the exposed `columns` multi-select. Selected keys are validated with `array_key_exists()` against the view's own field handlers before being used, so arbitrary/unknown input is discarded and never reaches the SQL query — the module only prunes which already-configured field handlers render. Settings passed to JS are run through `Html::escape()`. No mutating endpoints.

See [configure/style.md](configure/style.md)
