<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Summation Field — agent start

**What**: Hidden webform element `webform_summation_field` that sums selected other fields'
values onto the submission at presave. Depends on `webform`.

## Set up
1. `drush en webform_summation_field -y`.
2. Edit a webform → **Add element** → *Advanced elements* → **Webform Summation Field**.
3. In its settings, check the fields to **collect** (sum). The element is hidden on the form.

## Key facts
- Element: `Drupal\webform_summation_field\Element\WebformSummationField` (extends core
  `FormElement`; rendered hidden, `display:none`).
- Plugin: `...\Plugin\WebformElement\WebformSummationField` (extends `WebformElementBase`,
  category "Advanced elements"); setting `collect_field` = checkboxes of other value elements.
- `hook_webform_submission_presave()` sums `$result += $value` over collected keys and
  `setElementData()` writes the total.
- Numeric addition at presave; no JS live-total in this module. No routes/permissions.
