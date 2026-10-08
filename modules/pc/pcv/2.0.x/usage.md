<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Core Validator adds password-requirement validation to core password fields, based on configurable criteria.

---

Using an OOP hook class (`src/Hook/PcvHooks.php`), it alters the core `password_confirm` element to attach an after-build and validate callback. On validate it checks the entered password against admin-configured rules — minimum length, and required lowercase, uppercase, number and punctuation characters — each independently toggleable with its own error message, and it pushes matching hints into the core JS strength meter's `drupalSettings`. Admins configure the thresholds, the messages, whether to show a success message and which roles are exempted (`roles_overwrite`) at `/admin/config/people/pcv` (`administer site configuration`).

It solves the need for a lightweight, core-only password policy without a heavier framework, letting you require a minimum strength for chosen roles. Because validation runs on the core password element, it applies wherever that element appears (registration, user edit, admin-created accounts). Note the exemption is role-based: users holding a role listed in `roles_overwrite` skip the extra rules. Typical setup: enable the module, set the required character classes and length, adjust the messages, and choose which roles (if any) are exempt.

---
- Require a minimum password length
- Require at least one lowercase letter
- Require at least one uppercase letter
- Require at least one number
- Require at least one punctuation/special character
- Toggle each requirement independently
- Customize the error message per requirement
- Exempt specific roles from the rules
- Show hints in the core password strength meter
- Enforce policy on user registration
- Enforce policy on user profile edits
- Enforce policy on admin-created accounts
- Display a success message when a password passes
- Tune complexity for high-privilege roles only
- Provide clearer password guidance to users
- Apply a lightweight policy without extra dependencies
