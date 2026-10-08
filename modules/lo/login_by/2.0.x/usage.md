<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login By configures whether users log in with email, username, or both.

---

Login By **lets users log in by email, username, or both** — configuring which identifier the login form
accepts, so a site can allow email-based login (or keep username-only, or accept either). It works across core
8–11 (settings gated by `administer site configuration`).

Use it to enable email login. It is an authentication-convenience feature. Security note: allowing **login by
email** relies on emails being **unique** and matched unambiguously — ensure your site enforces unique emails, and
be aware the identifier lookup should behave consistently (e.g. case handling) so login is deterministic. It layers
on core authentication and adds no bypass. Configure the allowed login identifier(s).

---

- Allow login by email/username/both.
- Configure the accepted identifier.
- Enable email login.
- Serve authentication convenience.
- Gate settings by administer site configuration.
- Layer on core auth.
- RELY on unique emails for email login.
- Ensure consistent identifier lookup (case handling).
- Add no authentication bypass.
- Configure the login identifier(s).
- Handle login identifiers.
- Allow email login.
- Configure the login.
- Accept identifiers.
- Handle the form.
- Match users.
- Configure auth.
- Handle the login.
- Set the identifier.
- Provide flexible login identifiers.
