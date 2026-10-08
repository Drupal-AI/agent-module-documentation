# Configuration

One Time Password is described by its own maintainers as opinionated and near
zero‑configuration, so there is very little to set on the form itself. The real
"configuration" of a 2FA rollout is a policy decision — who must enrol, and how
you recover a lost device — handled through permissions and process rather than a
long settings screen.

## Open the settings form

1. Log in as a user with the **Administer one time password settings** permission.
   (This permission is marked *restrict access* because it governs a security
   feature — grant it only to trusted administrators.)
2. Go to **Configuration → People → One Time Password**, or navigate directly to
   `/admin/config/people/one_time_password/settings`.

## The settings form

The 2.x branch's form has essentially one option:

- **Force users to set up two‑factor authentication** — when enabled, users are
  required to enrol a second factor rather than leaving it optional. This is the
  switch that turns 2FA from "available" into "enforced". Turn it on once you have
  a recovery process in place (see below), so that people who are forced to enrol
  are not locked out if they later lose their device.

Save the form to apply your choice.

## Permissions and who can enrol

Enrolment happens per user at `/user/{user}/two-factor-auth`, guarded by the
`user.update` entity‑access check. In practice that means:

- **A user can manage their own second factor.**
- **Holders of core's Administer users permission** can manage another user's
  factor — which is how an administrator helps someone reset after losing a
  device.

Review **People → Permissions** and confirm that only trusted roles hold
**Administer users** and **Administer one time password settings**, since both can
affect other people's second factor.

## Plan recovery before you enforce

The two decisions that make or break a 2FA rollout are not on this form:

1. **Recovery.** If a user loses their device and has no recovery codes, an
   administrator must clear the factor for them by hand (via the user's
   two‑factor page). Decide who is allowed to do this and how they will verify the
   person's identity *before* clearing it — otherwise "reset my 2FA" becomes an
   easy social‑engineering path around the second factor.
2. **Coverage.** Decide which roles are *required* to enrol. Enforcing 2FA only
   for low‑privilege accounts while leaving administrators optional defeats the
   purpose; make sure the accounts that matter most are covered.

## Save

Save the settings form after choosing whether to force enrolment. Combined with
the permission review and recovery plan above, that completes a sound 2FA setup.
