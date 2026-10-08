<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form State Empty extends the core Form API States system to allow emptying (clearing) field values with JavaScript based on state conditions.

---

Form State Empty extends Drupal's core Form API `#states` system with the ability to empty (clear) a
field's value via JavaScript when a state condition is met — filling a gap where core states can show/
hide/enable/disable fields but cannot clear them. This helps build dynamic forms where hiding a field
should also reset its value (so stale data isn't submitted). It is in the Form package.

Use it when conditional form logic needs to clear dependent fields as conditions change. It is a
form/developer feature operating client-side on the states system; it affects form behaviour, not
content or access. Configure it as part of a field's `#states` definition.

---

- Empty fields via Form API states.
- Clear a field when a condition is met.
- Extend core #states with emptying.
- Reset dependent fields dynamically.
- Avoid submitting stale hidden data.
- Build dynamic conditional forms.
- Operate client-side on states.
- Clear values on state change.
- Complement show/hide states.
- Affect form behaviour, not access.
- Configure via #states.
- Reset fields on hide.
- Handle conditional field logic.
- Empty inputs with JavaScript.
- Fill a core states gap.
- Clear dependent inputs.
- Improve dynamic forms.
- Manage field state emptying.
- Reset on condition.
- Extend the states system.
