# Configuration

Require Login works the moment it's enabled — with the default settings it requires
login on **every** page. This form is where you soften or reshape that: change the
login flow, and narrow *where* the requirement applies.

## Open the settings form

1. Log in as a user with the **Administer require login** permission (see the
   Permission section below — grant it only to trusted admins).
2. Go to **Configuration → People → Login Requirements**, or navigate directly to
   `/admin/config/people/login-requirements`.

Saving the form clears all caches, so any change you make takes effect immediately.

## The login flow settings

- **Login path** (`login_path`) — the path anonymous users are redirected to. Leave
  it blank to use Drupal's standard `/user/login`, or set a custom path if you have
  your own login page.
- **Login message** (`login_message`) — an optional warning shown to users after
  they're redirected, for example "Members only. Please log in." Leave blank for no
  message.
- **Login destination** (`login_destination`) — where users land *after* logging
  in. Leave it blank to return them to the page they originally requested (the
  friendliest option), or set a fixed path such as `/dashboard` to always send them
  to the same place.

## Narrowing where login is required

By default the requirement applies everywhere. To limit it, use the **Requirements**
section, which exposes core **condition plugins** — most importantly **Request
Path**. When you configure conditions, they are combined with AND: login is enforced
only when all configured conditions pass (or are neutral).

Using the Request Path condition:

- **Require login only on some paths** — enter the paths (one per line, wildcards
  allowed, e.g. `/members` and `/members/*`) and leave the condition **not**
  negated. Login is then required only on those paths; the rest of the site stays
  public.
- **Require login everywhere except some paths** — enter the paths the same way but
  **negate** the condition. Login is required everywhere *but* those paths — handy
  for a mostly-private site with a few public pages.

Some conditions (node type, user role, current theme) are intentionally hidden from
this form, since they don't make sense for a login gate.

Regardless of your conditions, a fixed set of routes always stays reachable so the
login flow itself keeps working: the login, registration, and password-reset pages,
and the CSS/JS/image-style asset routes.

## Also gate the error pages

Under the extra options:

- **Include 403 (access denied)** (`extra.include_403`, default off) — when on, the
  access-denied page also redirects anonymous users to login. **Recommended** — it
  stops anonymous visitors from telling the difference between "forbidden" and
  "doesn't exist."
- **Include 404 (not found)** (`extra.include_404`, default off) — when on, the
  not-found page likewise redirects to login. Also **recommended** for a fully
  private site, so 404s don't leak which paths exist.

## Setting values from the command line

```bash
drush config:get require_login.settings
drush config:get require_login.settings requirements.request_path.pages
```

The whole configuration lives in the `require_login.settings` object, so you can
export it and deploy the same login gate across environments.

## Permission

The module defines a single permission:

- **Administer require login** (`administer require login`) — gates access to this
  settings form. It's marked security-sensitive, because whoever holds it controls
  whether the entire site is locked behind login. Grant it only to trusted
  administrators, at **People → Permissions** (`/admin/people/permissions`).

There are no per-content or per-user permissions — who has to log in is decided
entirely by the conditions you configure here, not by permissions. And "bypassing"
the requirement simply means being an authenticated user.
