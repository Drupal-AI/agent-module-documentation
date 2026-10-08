<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Required by Form mode makes fields required based on the active form mode.

---

Required by Form mode lets you make a field required depending on which form mode is active — so a field
can be optional in one form display (e.g. a quick-add form) but required in another (e.g. the full edit
form), giving per-form-mode required rules. It provides its own permissions, in the Field package.

Use it for form-mode-specific required fields. It is a content-editing/validation feature affecting field
requiredness per form mode; it shapes form validation and has no access-control role. Note: requiredness is a
form-mode validation rule, not a data constraint on all writes (a value set via another form mode/API isn't
forced) — so treat it as UI/validation, not a guarantee. Configure requiredness per form mode.

---

- Make fields required per form mode.
- Vary requiredness by form display.
- Require a field in one mode, not another.
- Provide its own permissions.
- Give per-form-mode required rules.
- Shape form validation.
- Have no access-control role.
- Treat it as form validation, not a data constraint.
- Note other modes/API aren't forced.
- Configure requiredness per mode.
- Handle form-mode required.
- Set required by mode.
- Vary field requiredness.
- Configure the rules.
- Require fields conditionally.
- Handle per-mode validation.
- Configure required fields.
- Set mode-specific required.
- Require by form mode.
- Configure requiredness.
