Webform Options Limit adds a submission handler that enforces per-option quotas on select, checkboxes, and radios elements, so individual choices can "sell out" and become unavailable once their limit is reached.

---

Many forms need capacity limits on specific choices — a workshop slot that seats 20, a T-shirt size with limited stock, an appointment window that fills up. Webform Options Limit provides an **Options limit** WebformHandler (`OptionsLimitWebformHandler`) that you attach to a webform and point at an options element. For each option you set a limit; the handler counts existing submissions per option value and blocks, disables, hides, or relabels options that are full. It supports configurable behaviors for reached options (disable/remove/none), custom messages and label templates (e.g. "{label} [{remaining} remaining]"), and a total-limit mode. A results summary page at `/admin/structure/webform/manage/{webform}/results/options-limit` (and the node equivalent) shows counts, limits, and remaining capacity per option. Because it is a handler it inherits Webform's conditional logic, per-handler enable/disable, and config export. Its settings have a config schema (`webform_options_limit.schema.yml`) so limits deploy with the webform configuration.

---

- Cap seats on each session/time-slot option in a registration form.
- Sell limited-stock product variations (sizes, colors) until they run out.
- Disable a radio/checkbox option automatically once it is full.
- Remove sold-out options from the list entirely.
- Show "X remaining" next to each available option.
- Show a custom "sold out" message when a choice is unavailable.
- Enforce a combined total limit across all options of an element.
- Limit appointment windows so overbooking is impossible.
- Cap volunteer shifts per role.
- Manage conference track/room capacity per option.
- Display a live options-limit summary report to organizers.
- Reserve capacity per option and track remaining count in real time.
- Prevent double-booking of equipment or resources.
- Limit RSVPs per meal/dietary choice.
- Combine with per-user submission limits for fine-grained control.
- Apply different limits per option value within one element.
- Relabel full options (e.g. strike-through or "(full)") without deleting.
- Deploy option quotas as exportable webform config.
- Restrict giveaway/coupon codes to a fixed quantity.
- Cap class enrollment by grade/level option.
- Throttle high-demand choices during peak sign-up.
