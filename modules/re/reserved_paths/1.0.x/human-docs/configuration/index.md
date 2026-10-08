# Configuration

Reserved Paths has a single, simple settings screen: a list of the paths you want
to keep off-limits for URL aliases.

## Open the settings form

1. Log in as a user with permission to administer reserved paths.
2. Go to **Configuration → Reserved Paths**, or navigate directly to
   `/admin/config/reserved-paths`.

## Build your reserved list

The form provides a **textarea** where you enter the paths you want to reserve —
one per line. From then on, whenever someone tries to create content (or Pathauto
tries to generate an alias) whose alias matches an entry on the list, the alias is
rejected.

Points to keep in mind:

- **Coverage is exactly what you list.** The module does not guess or protect
  anything automatically — only the paths you enter are reserved. Take a moment to
  include the routes and names that matter on your site (for example admin and
  login paths, API endpoints, and any names you are holding in reserve).
- **It works with Pathauto.** If you use Pathauto, automatically generated aliases
  are checked against the same list, so bulk-generated aliases will not collide with
  your reserved paths either.

## Save

Click **Save configuration**. The reservations take effect immediately — try
creating a piece of content with a reserved alias to confirm it is blocked.
