<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Select Other is a form widget for core List fields (list_string, list_integer, list_float) that shows the field's configured allowed values as a select list plus an "Other" choice that reveals a text field for a value not in the list.

---

The pattern is universal in forms and missing from Drupal's stock widgets: every list of answers has a tail — "How did you hear about us?" with six options and a seventh that is whatever the person actually did; a job title, a country, a referral source. A bare "Other" with no box throws that information away; a permanently visible "please specify" field clutters the form for everyone. This module is a direct port of the Drupal 6/7 CCK "select or other" widget (the `cck_` prefix is the giveaway), rebuilt for **Drupal 11.3+ / 12** — note the tight `^11.3 || ^12` requirement — and shipping as **2.0.0-alpha3**. It attaches to any `list_string`, `list_integer`, or `list_float` field (not `list_boolean`), adds an `other` option to the select, and a tiny jQuery behavior shows/hides the accompanying textfield as the selection changes; the typed value is written straight into the same list field. A companion field formatter renders stored values (looking the key up in `allowed_values`, falling back to the raw stored value), and a Views filter adds the "Other" bucket to exposed filters. The load-bearing detail an integrator must understand is **how the "other" value clears validation**. Drupal decouples fields from widgets, so a widget cannot legally loosen a field's allowed-values check; to get around this the module **replaces core's `AllowedValues` validation constraint plugin site-wide** (`hook_validation_constraint_alter`) with its own subclass, and its validator, for any List field that carries this widget on some form display, adds the submitted value to the allowed choices so arbitrary text passes. The README says it plainly: "Any field that has an instance using this widget will bypass allowed values." Two consequences to design around. First, that field is **no longer a closed set** — on every write path, form or API, not just the widget — so facets, Views filters, and any code that treats the key as a known machine value must tolerate off-list values; if you need the list to stay authoritative, store the free text in a second field instead. Second, the "other" value is **user-entered text on display**; the module's own formatter runs it through `FieldFilteredMarkup` and core render filtering, but it still accumulates near-duplicates that need reconciliation if anyone intends to report on it. On `list_integer`/`list_float` fields, free text that is not numeric is a storage/robustness hazard, so "Other" is most natural on `list_string`.

---

- Add an "Other, please specify" option to a select list field.
- Collect a referral source ("How did you hear about us?") not in the list.
- Let users enter a job title that is not in a predefined list.
- Capture an answer outside a fixed set without a separate always-on textfield.
- Improve registration-form data quality with an escape hatch.
- Collect an unlisted country, region, or city.
- Let a user specify a department or team name not yet in the options.
- Support an open-ended survey answer alongside canned choices.
- Discover which list options are missing by mining submitted "other" values.
- Reduce forced miscategorisation into a wrong bucket.
- Add a customizable "Other" label (e.g. "Something else") via the widget setting.
- Render stored list values (including off-list ones) with the provided formatter.
- Expose an "Other" bucket in a Views filter on a select-other field.
- Port a Drupal 6/7 CCK Select Other field's behavior to Drupal 11/12.
- Collect a specialism or skill not yet listed on a profile form.
- Support an evolving taxonomy of options without redeploying config each time.
- Let content editors add an off-list value that other code can later normalise.
- Capture "other" free text on an application or intake form.
