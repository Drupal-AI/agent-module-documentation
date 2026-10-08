# Configuration

Bootstrap Site Alert has two sides to set up: **who can do what** (two
permissions) and **the alerts themselves** (content an editor creates).

## Set the permissions

The module defines two permissions. Go to **People → Permissions**
(`/admin/people/permissions`) and assign them to the appropriate roles:

- **`administer bootstrap site alerts`** — lets a role create, edit, and remove
  alerts. Give this only to trusted editors or administrators, since an alert
  appears to everyone who can see it.
- **`view bootstrap site alerts`** — controls who *sees* alerts. If alerts should
  be universal, make sure the roles you want (including anonymous visitors) have
  it. If some alerts are meant for logged-in users only, use this permission to
  keep them from anonymous visitors.

Deciding the view permission deliberately matters: it is the difference between a
banner everyone sees and one shown only to authenticated users.

## Create and manage alerts

With the administer permission in place, create alerts through the admin UI. For
each alert you typically set:

- **The message** shown in the banner.
- **The Bootstrap alert style** — for example info, warning, or danger — which
  determines the banner's colour via Bootstrap's alert classes.
- **Whether it is dismissible**, so a visitor can close it. Dismissal is
  remembered per visitor using the `js_cookie` dependency, so a closed alert
  stays closed for that person.

Create as many alerts as you need; remove or unpublish them when the situation
they announce has passed.

## Check the theme

Because the module only emits Bootstrap alert classes, confirm your active theme
actually renders them. On a Bootstrap-based theme this is automatic. On a theme
that does not include Bootstrap, the banner will still appear but will be
unstyled until you give the alert classes meaning in your own CSS.

## Save and verify

After creating an alert, load a front-end page as a user who has the **view**
permission — the banner should appear in the chosen Bootstrap style. Click its
dismiss control and reload; it should stay closed for you.
