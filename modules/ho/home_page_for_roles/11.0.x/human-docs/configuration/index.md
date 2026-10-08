# Configuration

All of Homepage by role's setup happens on one short form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Homepage by role**
   (`/admin/config/people/homepage-roles`), the `home_page_for_roles.settings`
   form. A link also appears under **People** on the main Configuration page.

## Set the homepages

For each case you care about, paste the **path** of the page you want that
audience to land on when they visit the site's front page:

- **Anonymous users** — the homepage for visitors who are not logged in (for
  example, a public landing page).
- **All registered users** — a default homepage for any logged‑in user.
- **A specific role** — a homepage for users in a particular role, which takes
  precedence over the general "registered users" setting for those users.

Enter any existing internal path, starting with a slash — for example
`/welcome_anonymous_user` or `/registered_users_only`. Any path that already
exists on your site will work.

Save the form. From then on, visiting the front page redirects each user to the
homepage that matches their role.

## A reminder about access

This module only **redirects** — it does not protect anything. If a page should be
restricted, set the permissions or access rules on that page itself; pointing a
role's homepage at it does not by itself keep other users out.
