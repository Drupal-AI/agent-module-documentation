<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logout After Password Change enhances the logout after a password change.

---

Logout After Password Change **forces a user to be logged out after their password is changed/reset** —
its event subscriber calls `user_logout()` when a password-reset flag is set, so a session is terminated after
a password change, requiring re-authentication with the new password. It is in the Administration package.

Use it to harden session handling around password changes. This is a **security-positive** feature: forcing
re-authentication after a password change is good session hygiene (it helps ensure a changed password takes
effect for the session and supports "log out everywhere" style behaviour after a credential change). It has no
access-control role. Enable it to force logout on password change.

---

- Force logout after a password change.
- Terminate the session via user_logout().
- Require re-auth with the new password.
- Trigger on a password-reset flag.
- Harden session handling.
- Support log-out-after-credential-change.
- Improve session hygiene.
- Have no access-control role.
- Enable forced logout.
- Handle post-change logout.
- Log out on change.
- Configure the behaviour.
- Force re-authentication.
- Handle the subscriber.
- Log users out.
- Configure logout.
- Handle sessions.
- Terminate sessions.
- Enable it.
- Provide logout on password change.
