<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Roles automatically grants an admin-chosen set of roles to accounts created through the Social Auth suite, on top of the default `authenticated` role, while leaving accounts created through ordinary Drupal registration untouched.

---

The module is small and single-purpose. It registers one event subscriber on the Social Auth `USER_CREATED` event (`SocialAuthEvents::USER_CREATED`), which the Social Auth suite fires when it creates a brand-new Drupal account for someone logging in through a social provider (Google, Facebook, GitHub and so on). When that event fires, the subscriber reads the `social_auth_roles.settings` config, iterates the stored list of role IDs, and calls `$user->addRole()` for each one, logging a notice per role added. Assignment happens **only at account creation, not on every subsequent login** — an account keeps whatever it was granted when it was first created, and later changes to the configuration do not retroactively affect existing accounts, nor are roles re-applied (or removed) on return visits. The role set is chosen entirely by an administrator at `/admin/config/social-api/social-auth/roles`, a settings form gated by the `administer social api authentication` permission; the form presents a checkbox list of every role on the site except `anonymous` and `authenticated`. Nothing in the role decision comes from the social provider — there is no mapping from a provider claim, group or email domain to a role, so the granted set is fixed by config and identical for every social signup. Version **2.0.1** targets `^8 || ^9 || ^10 || ^11` and requires `social_auth`. Because a role granted automatically at registration is effectively granted to anyone who can complete the social login flow, the roles selected here should carry only low-trust permissions; identity from a social provider is weakly verified (accounts can be new, disposable or automated, and the provider verifies email for its own purposes), so this is not the place to hand out content-management, configuration or permission-granting capabilities.

---

- Give every account created via Social Auth a distinct "social user" role.
- Mark accounts that registered through Google versus email/password.
- Auto-assign an "Employee" role to company-domain Google signups.
- Assign a partner or affiliate role at social signup.
- Distinguish social-created users from traditionally registered ones.
- Apply a lighter-weight role to weakly verified social identities.
- Target a view or block visibility at social-created users.
- Onboard a community whose members sign up with social accounts.
- Assign a trial or probationary role to social signups.
- Segment users by registration path for reporting.
- Support a partner-driven single-sign-on onboarding flow.
- Apply a role used purely for analytics segmentation.
- Give Facebook signups a specific downstream role.
- Support a two-tier membership model keyed on registration source.
- Assign a campaign-specific role during a social-login rollout.
- Reduce manual role assignment for high-volume social registration.
- Flag accounts that still need additional verification.
- Route social signups into a moderation or approval workflow.
- Grant a forum-participant role to community social signups.
- Keep normal Drupal registrations unaffected while customizing social ones.
- Provide a "newcomer" role that a welcome workflow keys off.
