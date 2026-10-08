<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Masked Input (masked_input) — agent index

Adds client-side **input masks** (e.g. `(___) ___-____`) to text fields to guide format-as-you-type.
Version **dev-1.x**. Core `^9 || ^10 || ^11`. Settings at
`/admin/config/user-interface/masked_input`.

**A mask is a UX convenience, not validation.** It runs in browser JS: it shapes what a cooperating
user types and does nothing to a script, curl, or JS-disabled client. **Always back it with
server-side validation** and never treat a masked field as sanitised. Useful as a formatting hint;
a false assurance if mistaken for a control.