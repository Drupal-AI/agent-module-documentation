# Configuration

Setting this module up is two stages: **classify your roles** on the settings form,
then **grant the permissions** to your sub‑admin roles. Do them in that order — some
permissions only appear once a role is classified as *Custom*.

## 1. Classify your roles

Go to **People → Administer Users by Role**
(`/admin/config/people/administerusersbyrole`). This form requires core's
**Administer permissions** permission. It lists every *managed* role — that is,
every role except anonymous, authenticated, and any role that already holds core's
*Administer users*. For each one, pick a required option:

| Option | Meaning |
|---|---|
| **Allowed** | Sub‑admins who hold the matching base permission (below) can manage users who have this role. |
| **Forbidden** | Sub‑admins can never manage users who have this role. This is the default for any role you don't set, and the "admin" role (and any role with *Administer users*) is always forbidden. |
| **Custom** | Access to users with this role is governed by four *extra* per‑role permissions that this role then generates on the Permissions page. |

Remember the golden rule: a sub‑admin may act on a target user only if they have
access to **every** role that user holds. One forbidden role puts the whole account
out of reach.

The classifications are stored as configuration, so they export and deploy with
`drush config:export`.

## 2. Grant the permissions

Now go to **People → Permissions** (`/admin/people/permissions`) and grant your
sub‑admin role the permissions it needs.

### The four base operations (apply to all *Allowed* roles)

| Permission | Lets a sub‑admin… |
|---|---|
| **Edit users with allowed roles** (`edit users by role`) | Edit any user whose roles are all Allowed (e.g. reset passwords). |
| **Cancel users with allowed roles** (`cancel users by role`) | Cancel/delete such users. |
| **View users with allowed roles** (`view users by role`) | View a single user's profile. |
| **Assign allowed roles** (`role-assign users by role`) | Assign any Allowed role to a user. |

### Per‑role permissions (only for *Custom* roles)

Every role you classified as **Custom** produces four extra permissions of the form
`{operation} users with role {role}` — for example **Edit users includes role
Editor** (`edit users with role editor`). Each of these only takes effect **combined
with** its matching base permission above. Use Custom when you want to allow one
specific role that you don't want to mark globally Allowed.

### Standalone permissions

| Permission | Lets a sub‑admin… |
|---|---|
| **Create new users** (`create users`) | Add new accounts without needing core's *Administer users*. |
| **Access the users overview page** (`access users overview`) | See the People list — automatically filtered to only the users they can manage — and use the multi‑cancel confirm form. |
| **Allow empty user mail when managing users** (`allow empty user mail`) | Create or edit accounts that have no email address. |

## How it behaves once set up

- The **People list** hides accounts a sub‑admin cannot edit, so they only see users
  they can manage.
- On the **user edit form**, the role checkboxes are limited to the roles the
  sub‑admin is allowed to assign.
- The core **"Add role to the selected users" / "Remove role"** bulk actions respect
  the same limits — only assignable roles are offered.
- **User 0 (anonymous) and user 1 (root) are never grantable**, regardless of
  configuration.
- Assigning a role is permitted if the sub‑admin can edit the target user *or* can
  already assign every role that user holds — and can assign every role being
  changed.

### Example: a helpdesk role

Grant a "support" role the ability to view and edit low‑privilege users and reset
their passwords, but never elevate anyone:

```bash
drush role:perm:add support 'access users overview'
drush role:perm:add support 'edit users by role'
drush role:perm:add support 'role-assign users by role'
```

Combined with classifying the sensitive roles (administrator, editor) as
**Forbidden** and the ordinary member roles as **Allowed**, this gives support staff
a safe, tightly‑scoped slice of user administration.
