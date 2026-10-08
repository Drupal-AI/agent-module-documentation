<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Summation Field

Provides a webform element, **Webform Summation Field**, that computes the sum of selected
other fields' values on a submission. The element itself is hidden in the rendered form
(`display: none`); when a submission is saved, a presave hook adds up the values of the
elements the admin chose to "collect" and stores the total in the summation field's value.

---

## Summary

The element `Drupal\webform_summation_field\Element\WebformSummationField` (extends core
`FormElement`, `@FormElement id="webform_summation_field"`) renders as a hidden form element
via `preRenderWebformSummationFieldElement()`. The webform plugin
`Drupal\webform_summation_field\Plugin\WebformElement\WebformSummationField` (extends
`WebformElementBase`, category "Advanced elements") adds a `collect_field` setting — a
checkbox list of the webform's other value-bearing elements to include in the sum.

`hook_webform_submission_presave()` finds the summation element in the webform, reads its
`#collect_field` list, iterates the submission data, and adds (`$result += $value`) the
values of the collected keys, then writes the total back with `setElementData()`. Summation
is numeric addition of submitted values at presave — there is no live/JS recalculation of the
displayed total in this module's PHP (the field is hidden). No routes, permissions, or
settings pages beyond the per-element config.

---

## Use cases

- Total several numeric quantity fields into one submission value.
- Compute an order/line-item subtotal from multiple amount fields.
- Sum scores across question fields for a simple scored form.
- Add up donation amounts entered across several fields.
- Aggregate hours or units reported in different webform elements.
- Store a computed grand total on the submission for reporting/exports.
- Combine multiple fee fields (base + add-ons) into a single total.
- Produce a summed value for downstream handlers (email, remote post).
- Keep a hidden running total that admins see in submission data.
- Total points collected across a multi-step (wizard) webform.
- Sum measurement fields (e.g. weights) for a logistics form.
- Feed a computed total into confirmation messages via tokens.
- Roll up itemized expense fields on an expense-claim form.
- Calculate total attendees from per-category count fields.
- Persist a numeric summary without exposing an editable total field.
