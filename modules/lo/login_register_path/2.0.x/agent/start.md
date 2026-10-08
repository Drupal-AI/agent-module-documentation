<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login Register Path — agent index

Lets you **change the URLs of the login and register pages** (serve `/user/login`, `/user/register` at custom
paths — branding). Config at `login_register_path.settings_form`. Version **2.0.2**. Core `^8||^9||^10||^11`.

Routing/UX — a **path change, NOT an auth change** (forms still enforce normal auth/registration; the path
change is not a security control). No access role.
