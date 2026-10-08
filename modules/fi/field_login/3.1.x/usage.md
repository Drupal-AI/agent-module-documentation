<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Field Login enables users to log in via arbitrary field values, decorating the user authentication service.

---

User Field Login (field_login) lets users log in using the value of an arbitrary user field — for
example logging in with a phone number, membership ID or other custom field value instead of the username. It
is configured at `field_login.settings`, provides its own permissions, in the Administration package.

Use it to allow login by a custom field value. Its implementation is sound: it provides a `UserAuthDecorator`
that **decorates** core's user-authentication service — it looks up the account by the configured field and
then still verifies the **password via core's password checker** (it holds the password-hashing service), so
it does **not** weaken the credential check (login flood control also still applies). Security notes to keep
correct: ensure the chosen login field is **unique** (so a value maps to exactly one account — ambiguity is a
login/security problem) and be aware that exposing an additional login identifier can widen the identifier-
enumeration surface (keep login messages neutral). It has no other access-control role. Configure which field
is used for login.

---

- Log in via an arbitrary user field.
- Log in with phone/membership ID.
- Decorate the user-auth service.
- Still verify the password (core).
- Keep login flood control.
- Configure at field_login.settings.
- Provide its own permissions.
- Ensure the login field is unique.
- Avoid identifier ambiguity.
- Keep login messages neutral (enumeration).
- Not weaken the credential check.
- Have no other access-control role.
- Configure the login field.
- Handle field-based login.
- Look up by field value.
- Verify the password.
- Configure logins.
- Handle custom login IDs.
- Restrict to a unique field.
- Configure field login.
