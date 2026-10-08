<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User API adds REST resources to work with user registration and management.

---

User API **adds REST resources for user registration and account management** — endpoints for registering
(`POST /user-api/register`), setting a password (`/user-api/set-password`), cancelling an account, and resending
the registration email, for decoupled/headless user flows. It depends on core REST and User, Simple OAuth and the
Verification module.

Use it to drive user registration/management from a decoupled front end. It is a web-services/auth feature, and it
is **securely designed** on the sensitive operations: the **set-password** resource only ever changes the
**currently authenticated user's** password and requires **either the correct current password or a valid token
from the `verification` module** (so no arbitrary-account takeover); the **registration** resource extends and
delegates to core's registration resource, and **respects core registration settings** — it activates the new
account only when visitors are allowed to register without approval, otherwise it blocks the account (so it can't
be used to bypass admin approval or inject roles/status). Security essentials: grant the REST **`restful post
<resource>` permissions** only to the roles that should use each endpoint (e.g. anonymous only for public
registration), **rate-limit/flood-protect** the public register/resend endpoints (they send email / create
accounts), and serve over HTTPS. It relies on the verification and Simple OAuth modules for tokens/auth. Configure
the REST resources and permissions.

---

- Add REST resources for user registration/management.
- Expose register/set-password/cancel/resend endpoints.
- Support decoupled/headless user flows.
- Depend on core REST/User + Simple OAuth + Verification.
- Serve web-services/auth.
- Manage users via API.
- SET-PASSWORD only for the CURRENT authenticated user (no arbitrary-uid takeover).
- REQUIRE the current password OR a verification-module token to change the password.
- REGISTER respects core registration settings (activate only when approval-free; else block; no role/status injection).
- Grant the restful post <resource> permissions only to intended roles + rate-limit public endpoints + HTTPS.
- Rely on the verification + Simple OAuth modules for tokens/auth.
- Configure the REST resources and permissions.
- Handle user REST.
- Register users.
- Configure the resources.
- Set passwords.
- Handle the endpoints.
- Cancel accounts.
- Gate the permissions.
- Provide user-management REST.
