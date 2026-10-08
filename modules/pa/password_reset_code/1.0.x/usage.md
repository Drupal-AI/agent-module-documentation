<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Reset Code lets users reset their password using a code rather than a link.

---

Password Reset Code lets users **reset their password with an emailed code** (a 6-digit code) instead of
the standard reset link — the user requests a reset, receives a code by email, enters it, then sets a new
password. It provides its own permissions, in the User package.

Use it for code-based password resets. It is an **access-control/authentication** feature and — unlike some
code/OTP reset modules — it is **implemented correctly** (reviewed): the code is generated with a **CSPRNG**
(`random_int`), verified with the timing-safe **`hash_equals()`**, subject to a configurable **attempt limit**
(`max_tries`, default 5 — the counter is incremented per wrong attempt and enforced, so the 6-digit code can't
be brute-forced), enforces an **expiry** (default `password_reset_timeout` = 24h), and is **single-use** (the
record is **deleted after a successful reset** and on expiry). Two things to set well: keep `max_tries` low and
the timeout modest, and ensure the **reset mail path is trustworthy** (as with any emailed secret). It grants
access only through the correct reset flow. Configure the code/attempt/expiry settings.

---

- Reset passwords via an emailed code.
- Use a 6-digit code (CSPRNG random_int).
- Verify with hash_equals() (constant-time).
- Enforce a max_tries attempt limit (default 5).
- Bound brute-force of the code.
- Enforce an expiry (default 24h).
- Delete the code after a successful reset (single-use).
- Delete on expiry too.
- Keep max_tries low + timeout modest.
- Ensure the reset mail path is trustworthy.
- Provide its own permissions.
- Configure the code/attempt/expiry settings.
- Handle code-based reset.
- Reset via code.
- Configure the reset.
- Verify codes.
- Handle the flow.
- Reset passwords.
- Secure the reset.
- Provide code-based reset.
