# Configuration

Select Registration Roles does nothing until you tell it which roles to offer, so
this page is the essential setup — and it is also where the security decisions are
made.

## Open the settings form

1. Log in as an administrator.
2. Go to **People → Registration Role Set By Admin** (config route
   `select_registration_roles.roles_set_by_admin`).

## Choose which roles appear on the registration form

The settings form lists your site's roles. Tick the ones you want to appear as
options on the registration form. Only the roles you select here are rendered on
`/user/register`; everything else stays hidden and unavailable to registering
visitors. A visitor can then pick one or several of the offered roles (they appear
as checkboxes) when they sign up.

## Require approval for sensitive roles

For each offered role you can also flag whether it **requires administrator
approval**. The two behaviours are:

- **No approval** — the role is granted and the account is **active immediately**
  after registration. Use this for low-risk, self-identifying roles.
- **Approval required** — the account is created but left **blocked** until an
  administrator reviews and unblocks it. Use this where you want a human to vet
  the request before the person gets in.

This lets you activate harmless audience roles instantly while holding sensitive
ones for review.

## The security rule that matters most

The whole arrangement is only as safe as the roles you decide to offer. **Never
offer a role that can escalate privileges** — anything carrying `administer
permissions`, `administer users`, `administer nodes`, `administer filters`, or any
other permission that can grant further access. A role placed on this form is
effectively available to anyone who can reach the registration page, so treat the
list of offered roles as a public-facing decision.

A registering visitor cannot forge a role you did not offer — Drupal's Form API
rejects submitted values that are not among the offered options, so posting an
unlisted role fails and no account or role is created. Keep in mind that this
protection is provided by Drupal core's form validation rather than by the module
re-checking its own list, which is another reason your choice of offered roles is
the control to rely on.

## Known issue: a warning on the registration form

There is a minor bug to be aware of. If a role is selected to appear on the form
but has no matching entry in the approval settings — the natural state right after
you save the form with some approval boxes unticked — the module can emit an
"Undefined array key" PHP warning while building the registration form. On a normal
production site (where error display is hidden) this is only a log entry. But on a
site that displays errors — a development or staging site, or a misconfigured
production one — it prints a file path and warning on the **public** registration
page, which is low-grade information disclosure. Keep error display off in
production, and be aware of this if you see such a warning.

## Save

Click **Save configuration** to store your role choices and approval flags. The
role chooser reflects them on the next visit to `/user/register`.
