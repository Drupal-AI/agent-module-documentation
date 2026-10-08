# Configuration

Role Expire is configured in three places: a global **settings form**, each
**role's** edit form (for default durations), and each **user's** edit form (for
individual expiry dates). This page walks through all three, plus the
permissions that gate them.

## The settings form

Go to **Configuration → People → Role Expire**
(`/admin/config/people/role-expire`) — this needs the **Administer role expire**
permission. From here you control which roles participate in expiration and how:

- **Enabled / disabled roles** — choose which roles can have expirations. By
  default all normal roles (everything except Anonymous and Authenticated) are
  enabled. Disable expiration for any role you never want auto-removed.
- **Default duration per role** — for each participating role you can set a
  default duration, written as a relative time phrase such as `1 day`,
  `3 months`, or `1 year`. New grants of that role then auto-expire after this
  span. (You can also set this on the role's own edit form — see below.)
- **Replacement role on expiry** — optionally map a role to another role that
  should be assigned when the first one expires. This is how you "downgrade" a
  user, for example turning an expired **member** into an **alumni**. The
  replacement role then picks up its own default duration, if it has one.
- **Expiration details expanded** — whether the per-role expiration fields on the
  user edit form start opened or collapsed.

## Per-role default duration (role edit form)

You can also set a role's default duration directly on **People → Roles → Edit**
(`/admin/people/roles/manage/<role>`). A **"Default duration for the role"** field
appears there for anyone with the **Edit role expire default duration**
permission (or *Administer users*). Enter a **relative, future** time phrase (e.g.
`6 months`) — the form validates that it is relative, positive, and in the future.
Users granted the role afterwards will expire after this duration unless you set
an explicit date on their account.

## Per-user expiry (user edit form)

On any user's edit form (`/user/<id>/edit`), each expiration-enabled role the user
holds gets its own **"Role expiration"** section with a date/time field. This is
available to anyone with the **Edit users role expire** permission (or *Administer
users*). You can enter:

- **Nothing** — the role uses its default duration, or never expires if the role
  has no default;
- an **absolute** date and time, `YYYY-MM-DD HH:MM:SS`; or
- a **relative** phrase like `1 day`, `2 months`, or `1 year` (must be in the
  future).

These per-user dates are stored in the module's own database table, not in site
configuration, so they travel with your content/user data rather than exported
config.

## Permissions

| Permission | What it lets a user do |
|------------|------------------------|
| **Administer role expire** | Open and change the settings form at `/admin/config/people/role-expire`. |
| **Edit users role expire** | Edit other users' role-expiration dates on the user form. |
| **Edit role expire default duration** | Set a role's default duration on the role form. |

All three are marked as security-sensitive ("restrict access"), so grant them
only to trusted administrator roles.

## What happens when a role expires

On each cron run, Role Expire finds any expirations that have passed and, for
each one, removes the role from the user. If you configured a replacement role for
that role, it is added at the same time (and that role's own default duration, if
any, starts counting). An event is also dispatched, which the optional
`role_expire_rules` submodule uses to let you build Rules reactions. Because this
all happens on cron, make sure cron runs regularly.

## Reporting on expirations

The module provides Views field plugins for role-expiry data, so you can build a
Views report of users showing their role expiry dates and remaining time —
handy for spotting memberships about to lapse.
