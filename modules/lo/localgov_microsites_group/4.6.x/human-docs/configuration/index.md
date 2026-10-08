# Configuration

Configuring LocalGov Microsites Group happens per microsite: you **create** a
microsite, then adjust its **per-microsite settings** (theme, site details, content
types and domain), and manage **who can do what** through a layered permissions model.

## Create a microsite

Go to **`/admin/microsites/add/{group_type}`** (where `{group_type}` is your microsite
group type). This form is gated by Group's entity create-access, so you need
permission to create groups of that type. Submitting it creates the microsite Group,
seeds its default group content and roles, and binds it to a domain.

## Per-microsite settings

Each microsite is configured from its own settings form at
**`/group/{group}/domain-settings`**. The form gathers several settings "plugins" into
one place:

- **Theme settings** — apply a theme override for this microsite. Controlled by the
  group permission *set localgov microsite theme override*.
- **Site settings** — per-microsite details such as the site name and email.
- **Content type settings** — enable or disable which content types are available on
  this microsite.
- **Domain** — the domain binding for the microsite. This is the restricted
  *administer group domain settings* group permission, so only trusted roles should
  hold it.

Access to this whole form is granted either to users with the global **bypass domain
group permissions** permission, or on a per-plugin basis to users who pass that
plugin's own group/account access check — so, for example, someone allowed to change
the theme override can reach the form for that purpose without holding the platform-wide
bypass.

## How domains map to microsites

A domain context provider and resolver map the active domain to its owning Group, and a
theme negotiator applies that microsite's theme override. When an administrator visits
`/admin/microsite`, the module resolves the "current" microsite from the domain/group
context and lands them on their own group's admin — but only when a current-group
context actually resolves; otherwise access is forbidden.

## The permissions model

Access is layered on top of the Group module. The key permissions are:

**Global (site-wide) permissions** (People → Permissions):

- **access microsites overview** — reach the microsites overview.
- **bypass domain group permissions** — a powerful super-admin permission that grants
  access across microsites; assign it only to platform administrators.

**Group permissions** (set per group type / per microsite via the Group UI):

- **administer group domain settings** and **administer group domain site settings** —
  restricted permissions controlling the domain and site settings.
- **set localgov microsite theme override** — allows changing the microsite's theme.
- **manage microsite enabled module permissions** — manage which modules'
  permissions a microsite admin can control.

The `localgov_microsites_permissions` submodule extends Group's `group_permissions`
so that a microsite administrator can manage their own microsite's per-group
permissions, without needing site-wide access.

## Members and roles

Add members to a microsite and assign their roles using the platform's group tools —
**Group Invite** (ginvite) for inviting users, and **Role Delegation** for letting
microsite admins assign a controlled set of roles. Content submodules (blogs, news,
events, and so on) add their content types per microsite once enabled.
