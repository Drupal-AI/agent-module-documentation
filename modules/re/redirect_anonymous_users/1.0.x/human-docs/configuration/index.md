# Configuration

This module has one setting that matters: the **exclusion allow-list** of routes
anonymous visitors may still reach. Because everything not on the list redirects
to login, building this list correctly is the whole job.

## Open the settings form

1. Log in as a user with the **administer redirect_anonymous_users
   configuration** permission (this permission is marked restricted, so grant it
   only to trusted roles).
2. Go to `/admin/people/redirect_anonymous_users/settings`.

## Routes to Exclude

The form has a single **Routes to Exclude** text field. Enter **one Drupal route
name per line** — these are route *names*, not URL paths. The form validates
this: any value containing a `/` is rejected, because a slash means you have
typed a path by mistake.

To find a route name, use `drush route` or the Devel module's "Router info"
report, then copy the name (for example `user.pass`, `user.register`,
`entity.node.canonical`).

The login route is **always** reachable and does not need to be listed.

### Routes you almost certainly need to add

By default only login works, so add every route anonymous users legitimately
need. Common ones:

- **`user.pass`** — the password-reset form. Without this, users who forget their
  password cannot recover it.
- **`user.register`** — the self-registration form, if you allow public sign-up.
- Any **REST / JSON:API / webhook** route that must respond to anonymous or
  external callers — add each by its route name.
- The **cron** route, so scheduled runs are not redirected.
- Any **custom controller route** that must stay public.

You can add as many as you like — one route name per line.

## Save

Click **Save configuration**. On save the module stores both the raw text you
entered and a parsed list of route names, and the new allow-list takes effect
immediately.

## Verify — and watch for the classic pitfall

In a logged-out browser, confirm that:

- an ordinary page still redirects you to login, and
- each route you excluded now loads without redirecting.

The most common problem after enabling this module is a flow that breaks because
its route was not excluded — password reset is the usual victim, since the
subscriber redirects POST requests too. If something an anonymous user should be
able to do stops working, the fix is almost always to add the missing route name
here rather than to change any code.
