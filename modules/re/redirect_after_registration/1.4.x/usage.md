Redirect After Registration sends a user to a configurable internal path immediately after they submit the user registration form, replacing Drupal's default post-registration destination.

---

The module is a single, tiny piece of glue: `hook_form_alter` appends a submit handler to the core `user_register_form`, and that handler reads one config object (`redirect_after_registration.settings`) to decide where to send the user. If the `redirect` path is non-empty it builds a URL with `Url::fromUri('internal:' . $redirect)` and calls `$form_state->setRedirectUrl()`. The redirect only fires when either the registrant is anonymous (normal self-registration) or the `redirect_admin_user_create` flag is enabled (so an admin creating accounts at `/admin/people/create` is also redirected). Configuration lives at `/admin/config/redirect_after_registration/config`, gated by the core `administer site configuration` permission, and the path field is a core `#type = 'path'` element (max 64 chars, no path validation/conversion — `CONVERT_NONE`). The default shipped value is `/user/login`. There are no permissions of its own, no plugins, no services, no Drush commands — just the setting plus the submit handler. Because the redirect uses the `internal:` URI scheme, the target is restricted to on-site paths and is set only by a trusted site administrator, so it is not an open-redirect vector.

---

- Send newly self-registered users to a custom welcome or onboarding page instead of the front page.
- Redirect registrants to a "your account is pending approval" explainer page when admin approval is required.
- Point new users to a profile-completion form right after they register.
- Route registrants to a membership/pricing page after sign-up.
- Send new users to a "check your email to verify" instructions page.
- Redirect to a getting-started tutorial or documentation landing page post-registration.
- Keep the default behavior of dropping users on the login page (the shipped `/user/login` default).
- Redirect to a community guidelines or terms page immediately after account creation.
- Send new users to a survey or "tell us about yourself" page.
- Direct registrants to a downloads or gated-content page they just unlocked by registering.
- Point new members to a Slack/Discord/forum invitation page.
- Redirect to a subscription or newsletter opt-in confirmation page.
- Also redirect accounts created by an administrator at `/admin/people/create` (enable `redirect_admin_user_create`).
- Keep admin-created accounts on the normal admin flow while still redirecting public sign-ups (leave the admin flag off — the default).
- Send registrants to a paid-plan checkout page as the first step after account creation.
- Redirect to an event-registration or RSVP page after the user creates their account.
- Land new users on a personalized dashboard route.
- Disable the feature entirely by leaving the redirect path empty (no submit-handler redirect fires).
- Provide a consistent post-registration landing target across a multi-site or multi-form setup via exported config.
- Override the redirect target per environment using `$config['redirect_after_registration.settings']['redirect']` in `settings.php`.
