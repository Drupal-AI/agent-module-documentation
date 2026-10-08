<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Password Reveal adds a toggle for showing or hiding password fields; notably, passwords are shown (revealed) by default.

---

Simple Password Reveal adds a small toggle control to password input fields so users can switch
between masked and plaintext entry — helpful for reducing mistyped passwords. Its notable behaviour,
stated in its own description, is that **passwords are shown by default**: the field renders in
plaintext until the user chooses to hide it, rather than the usual masked-by-default.

Use it to improve password-entry usability, but weigh the default carefully. Showing passwords by
default increases shoulder-surfing exposure — anyone able to see the screen (in an office, on a
shared/kiosk machine, over a screen-share or recording) sees the password as it is typed. For most
sites the safer default is masked; if this module is used, consider whether the default should be
flipped or whether it belongs only on low-risk forms. It is a front-end/UX module in the "utilities"
package with no server-side access behaviour.

---

- Add a show/hide toggle to password fields.
- Reveal a password to check it before submit.
- Reduce mistyped passwords.
- Note passwords are SHOWN by default.
- Toggle between masked and plaintext.
- Improve password-entry usability.
- Weigh shoulder-surfing exposure of the default.
- Consider masking by default on shared machines.
- Apply to login and registration forms.
- Provide a front-end UX enhancement.
- Hide the password after revealing it.
- Avoid on kiosk forms if risky.
- Let users verify a typed password.
- Understand the default is plaintext.
- Use on low-risk forms.
- Have no server-side access role.
- Flip the default to masked if preferred.
- Mind screen-share/recording exposure.
- Add reveal to any password input.
- Balance usability against visibility.
