<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Username provides a variety of username modes for registration and login.

---

Username provides **alternative username modes for registration and login** — letting a site use a display
name, phone number or other identifier instead of (or alongside) the standard username, with
`username_displayname` and `username_phone` submodules. It depends on core User and Token, provides its own
permissions, in the Username package.

Use it to offer flexible login/registration identifiers. It touches **authentication identifiers**, so keep
the security properties correct: an identifier used for **login** must be **unique** (map to exactly one
account — ambiguity is a login/security problem) and, where it's a contact identifier like a **phone number**,
ideally **verified** (an unverified phone/display identifier used for login or reset is an identity/takeover
risk). It changes the identifier surface, not the password check (core still verifies the password). Its
permission gates configuration. Configure the username modes and ensure uniqueness/verification.

---

- Offer alternative username modes.
- Register/log in with display name or phone.
- Use identifiers beyond username.
- Provide displayname/phone submodules.
- Depend on core User and Token.
- Provide its own permissions.
- ENSURE login identifiers are unique.
- Verify contact identifiers (phone) where used.
- Know an unverified identifier is a takeover risk.
- Keep core's password check.
- Have no access-control role beyond permission.
- Configure the username modes.
- Handle username modes.
- Configure identifiers.
- Set login modes.
- Handle registration.
- Configure login.
- Ensure uniqueness.
- Verify identifiers.
- Provide username modes.
