# Configuration

There is a single settings form, at **Configuration → Web services → JSON:API →
Role Access** (`/admin/config/services/jsonapi/role_access`). It requires the
**Access JSON:API role access settings** permission. The form has just two
fields.

## Allow / Restrict roles

This radio choice sets the mode:

- **Allow** (the default) — only users who hold at least one of the selected
  roles may use JSON:API. Everyone else is denied with a `403`. Choose this when
  you want to name the roles that *should* have API access.
- **Restrict** — users who hold any of the selected roles are blocked, and
  everyone else is allowed. Choose this when you want to name the roles that
  should *not* have API access.

In both modes the match is "any of" — the user needs (Allow) or is blocked by
(Restrict) holding at least one of the chosen roles.

## User roles

A set of checkboxes listing your site's roles. Tick the roles the mode applies
to. This field is required.

## Examples

- **Block anonymous, allow logged‑in users** (the install default): Allow mode
  with **Authenticated user** ticked.
- **API for a service role only**: Allow mode with just your `api_consumer` role
  ticked — no one else can reach JSON:API.
- **Block a low‑trust role**: Restrict mode with that role ticked; every other
  role still passes.

## Setting it from Drush

The same two values live in the `jsonapi_role_access.settings` config object, so
you can script them:

```bash
drush config:set jsonapi_role_access.settings negate 0 -y
drush config:set jsonapi_role_access.settings roles.editor editor -y
```

Here `negate` is `0` for Allow mode and `1` for Restrict mode, and `roles` is the
set of role IDs.

## Scope and limits

The gate applies only to JSON:API routes (those whose route name starts with
`jsonapi`), and it deliberately excludes the JSON:API, JSON:API Extras, and this
module's own settings pages. Remember that it can only **deny** — core JSON:API's
entity and field access still applies on top and is never widened by this module.
