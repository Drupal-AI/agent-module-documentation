<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform SWIFT/BIC Field — agent start

**What**: Webform element `webform_bic_field` that collects + validates a SWIFT/BIC code.
Depends on `webform` (uses Symfony Validator's `Bic` constraint, bundled with core).

## Set up
1. `drush en webform_bic_field -y`.
2. Edit a webform → **Add element** → *Advanced elements* → **Webform SWIFT/BIC field**.
3. Optionally enable **multiple** values; set size/min/max/placeholder as needed.

## Key facts
- Element: `Drupal\webform_bic_field\Element\WebformBicField` (extends core Textfield);
  `#element_validate` = `validateWebformBIcField()` → `new Bic()` constraint;
  invalid → `setError`.
- Plugin: `Drupal\webform_bic_field\Plugin\WebformElement\WebformBicField` (extends
  `TextBase`, category "Advanced elements").
- Renders a text input with class `webform-bic-field`.
- Example webform `webform_bic_field` installed as config (single + multiple demo).
- No routes/permissions/settings pages.
