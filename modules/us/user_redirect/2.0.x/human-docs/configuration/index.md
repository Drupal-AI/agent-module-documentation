# Configuration

User Redirect does nothing until you fill in and save this form — it ships with no
defaults. Everything lives on one settings page.

## Open the settings form

1. Log in as a user with the **Administer User Redirect Settings** permission
   (grant it at `/admin/people/permissions` — it is access-restricted, so it is not
   given to any role by default).
2. Go to **Administration → People** and open **User Redirect**, or navigate
   directly to `/admin/people/users/redirect/form/settings`.

The form has two draggable tables — **Login** and **Logout** — followed by the
ignore settings.

## The Login and Logout tables

Each table lists every role on your site except *Anonymous*, one row per role, with
three columns:

- **Role** — the role name (read-only). *Authenticated user* and any custom roles
  such as *Administrator*, *Content editor*, or *Member* all appear here.
- **Redirect URL** — where members of this role should go after logging in (Login
  table) or logging out (Logout table). Enter either:
  - an **internal path** starting with `/` — for example `/admin/content`,
    `/dashboard`, or `/` for the front page; or
  - a **full external URL** starting with `http://` or `https://` — for example
    `https://portal.example.com`.
  Leave it **blank** to give that role no redirect (it keeps Drupal's default
  behaviour).
- **Weight** — the drag handle / priority. This matters only when a user has more
  than one role: the module walks the user's roles and uses the first one that has
  a redirect URL, checking the **last** role in the user's role list first. In
  practice, arrange the tables so the role whose destination should win sorts
  **lowest** (heaviest weight). Drag rows to reorder them.

Fill in a Redirect URL only for the roles you actually want to redirect. A common
setup: give *Administrator* `/admin/content` on login, *Content editor*
`/dashboard` on login, and *Authenticated user* `/` on logout.

### How the URL is validated

When you save, each non-empty Redirect URL must be a valid internal Drupal path or
a valid external URL. If it is neither, the form rejects it with *"Redirect URL is
invalid."* An empty field is always allowed.

## Ignore paths

Below the tables:

- **Ignore paths** — a textarea of path patterns, one per line, that should be left
  alone (no redirect) even when a matching role has a redirect URL. Wildcards work,
  e.g. `/user/reset/*`. The module defaults this to `/user/reset/*` so that
  one-time password-reset login links take the user to the password-change screen
  instead of being redirected away. Add more patterns here if certain flows must
  render normally after login — for example a checkout return page — to avoid
  redirect loops.
- **Ignore the above paths for** — two checkboxes, **login** and **logout**, that
  decide which flow the ignore list applies to. By default the ignore list is
  applied to **login** only. Tick **logout** as well if you need the same paths
  skipped when users log out.

## Save

Click **Save configuration**. The redirects take effect on the next login/logout.
Because the module reads its settings fresh on each request, changes apply
immediately — no cache rebuild needed.

## How a redirect actually happens

For reference, once configured: on login and logout the module looks up the user's
roles (highest priority first), takes the first role with a redirect URL, and sends
the user there. **Internal** paths are applied through Drupal's normal post-login
`destination` handling; **external** URLs trigger an immediate redirect. Before
redirecting, it checks the current path against your ignore list and skips the
redirect on a match. The deeper mechanics are in the
[`agent/` service docs](../agent/api/service.md).
