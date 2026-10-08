<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Flow provides a plugin-based user authentication (challenge) framework.

---

Login Flow **provides a plugin-based authentication framework** — defining an extensible login "flow" of
`Challenge` plugins (e.g. multi-step or additional verification steps) that run during user authentication. It
depends on core User.

Use it to build custom multi-step login flows. It is an **authentication framework**, so its security depends
entirely on the challenge plugins used: each challenge is part of the login trust path, so ensure challenges
**cannot be skipped/bypassed**, that they fail closed, and that any plugin you add is implemented securely (it
governs who gets logged in). The framework itself is neutral; review the specific challenges. Configure the login
flow and challenges.

---

- Provide a pluggable login flow.
- Run Challenge plugins during auth.
- Enable multi-step login.
- Depend on core User.
- Serve authentication.
- Extend the login trust path.
- DEPEND on the challenge plugins for security.
- Ensure challenges can't be skipped + fail closed.
- Review any added plugin (it governs login).
- Configure the flow and challenges.
- Handle the login flow.
- Run challenges.
- Configure the flow.
- Authenticate users.
- Handle the challenges.
- Verify login.
- Configure auth.
- Handle the plugins.
- Gate login.
- Provide a login-flow framework.
