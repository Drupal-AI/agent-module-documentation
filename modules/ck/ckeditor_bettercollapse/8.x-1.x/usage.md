<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Better Collapse

CKEditor 4 plugin: a collapse toggle that hides only the 2nd toolbar row.


## What & when

- Use it with the (legacy) CKEditor 4 editor to keep a compact one-row toolbar while allowing a second row on demand.
- Unlike CKEditor's default collapser (which hides the whole toolbar), this keeps the first row visible.
- Applies only to editors that have exactly two toolbar rows.

---

## Install & configure

- `composer require drupal/ckeditor_bettercollapse` then `drush en ckeditor_bettercollapse -y`.
- Targets the CKEditor 4 (`ckeditor`) editor, not CKEditor 5.
- Enable per text format: in the CKEditor settings for a format, tick **CKEditor Better Collapse enabled**.
- When enabled it sets `toolbarCanCollapse = TRUE` and `toolbarStartupExpanded = FALSE`.
- No permissions or routes.

---

## Usage & behaviour

- Give editors a tidy single-row toolbar that expands to two rows when needed.
- Reduce vertical space taken by a large toolbar on dense forms.
- The plugin moves first-row buttons out of the collapsible area on `instanceReady`.
- If only one toolbar break exists, it shows the toolbar and hides the collapser (nothing to collapse).
- If more than one break exists, it relocates the first row and removes the second break.
- Configuration is per-format via the plugin's settings checkbox.
- No buttons are added to the toolbar; it only alters collapse behaviour.
- Startup state is collapsed (second row hidden) when enabled.
- Purely a UI/JS enhancement — no content or data changes.
- Depends on the CKEditor 4 `toolbar` plugin internals.
- Safe to leave disabled per format; it is opt-in.
- Works on Drupal 9.3+ and 10 (legacy CKEditor 4 module required).
- No JavaScript API exposed to other modules.
- The plugin id is `ckeditor_bettercollapse`.
- Useful during CKEditor 4 → 5 migrations where CKEditor 4 formats remain.
