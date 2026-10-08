<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# msf — configuring multistep forms

msf has **no admin route**; you configure it through field_group on a form display.

1. Enable `msf` (pulls in `field_group` and `account_field_split`).
2. Go to the entity's **Manage form display** (e.g. `/admin/structure/types/manage/<bundle>/form-display`, or `/admin/config/people/accounts/form-display` for user registration).
3. **Add field group(s)** (field_group UI) — one group per step.
4. Set each group's **Format** to **Form step**.
5. Drag the fields you want into each step group and order the groups; group order = step order.
6. Save. The form now renders one step at a time with a step indicator and Next/Previous buttons; each step validates only its own fields.

Notes:
- Nested field groups inside a step are hidden until their step is active.
- Known TODO in `MultistepController::rebuildForm()`: on the user form the account `pass` field is forced `#required = FALSE` on non-current steps to avoid premature validation.
