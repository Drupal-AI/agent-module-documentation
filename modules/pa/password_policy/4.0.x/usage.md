Password Policy enforces configurable password constraints (length, character types, blacklist, history, etc.) per user role and can expire passwords on a schedule, forcing users to choose a new one.

---

Password Policy is built around two ideas: **constraints** (pluggable rules a password must satisfy) and **policies** (config entities that bundle constraints and target roles). The core module provides the `PasswordConstraint` plugin type, the policy config entity, the admin UI at `/admin/config/security/password-policy`, and the password-expiration engine; the individual rules ship as submodules (length, character types, characters-of-type, consecutive characters, blacklist, history, username, delay). Each policy selects roles, adds constraints with per-constraint settings, and optionally defines a time-based reset interval. As users set or change a password, `password_policy_form_user_form_alter()` injects a live policy-compliance table and validation blocks saving until every constraint passes. Expiration is driven by cron (`password_policy_cron()`, throttled by `cron_threshold`), which flags accounts whose password age exceeds the policy and sends reminder/expiry emails; an event subscriber then forces expired users to their edit form on next request. Administrators can also force an immediate reset for whole roles via the "Force Password Reset" form. Externally authenticated users (externalauth) and masqueraded sessions are excluded. Policies are exportable configuration, so they deploy across environments like any other config.

---

- Require a minimum password length site-wide for a given role.
- Enforce a mix of character types (upper, lower, digit, special) in passwords.
- Require a specific number of a character type (e.g. at least 2 digits).
- Blacklist common or company-specific passwords and phrases.
- Prevent reuse of a user's recent passwords (password history).
- Block passwords containing the user's own username.
- Disallow long runs of consecutive identical characters.
- Impose a delay before a password can be changed again.
- Expire passwords after N days and force a reset.
- Force an immediate password reset for every user in a role.
- Show users a live compliance table as they type a new password.
- Apply stricter rules to administrator roles than to regular members.
- Meet corporate or regulatory password-strength requirements.
- Send reminder emails a few days before a password expires.
- Send an email when a password has been reset/expired.
- Exclude SSO/externalauth users from password rules and expiration.
- Combine several constraints into one named policy per role.
- Export password policies as config and deploy them across environments.
- Throttle expiration processing on large sites via the cron threshold.
- Manually override a user's last-reset date (manage password reset permission).
- Enforce a maximum password length as well as a minimum.
- Require special characters only in privileged-role passwords.
- Prevent a new password from matching any of the last N used.
- Give editors a clear checklist of unmet password requirements at signup.
- Build a custom constraint plugin for organization-specific rules.
- Apply different expiration windows to different roles.
- Prevent password reset immediately after a recent change (anti-churn).
