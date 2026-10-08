<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Based Login (fbl) — agent index

Lets users **log in with alternative fields** (a unique custom account field and/or email, vs username).
Config at `fbl.configuration` (`/admin/config/people/fbl`, permission `administer fbl`); provides config
schema + translation. Depends on core `user`. Version **2.3.x** (release `8.x-2.3`). Core `^9 || ^10 || ^11`.

Sound: a login-form validate handler (`fbl_login_name_validate`) **resolves the identifier to the real
username** (`$form_state->setValue('name', …)`) and **core's login authentication still verifies the
password** (doesn't weaken the check; flood control applies); neutral "unrecognized username or password"
message; a multi-match on the field is **rejected** (no ambiguous login). Uniqueness enforced at config
time and on user register/edit. No other access role.

- **Configure login fields & labels** → [configure/configure.md](configure/configure.md)
