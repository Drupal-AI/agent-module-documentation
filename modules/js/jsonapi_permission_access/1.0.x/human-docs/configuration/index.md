# Configuration

There is no settings form for this module — its entire behavior is controlled by
a single permission. "Configuring" it means deciding which roles are allowed to
reach JSON:API and granting them the **Access JSON:API Routes** permission.

## Grant the permission from the UI

1. Log in as an administrator and go to **People → Permissions**
   (`/admin/people/permissions`).
2. Find **Access JSON:API Routes** (listed under this module).
3. Tick the checkbox for each role that should be allowed to use JSON:API, then
   **Save permissions**.

To keep JSON:API private, leave the box **unticked** for `anonymous` — and
usually for `authenticated` too — granting it only to a dedicated API or consumer
role. To make JSON:API an authenticated‑only API, grant it to `authenticated` but
not `anonymous`.

## The shipped `json_api_user` role

The module installs an optional role called **JSON:API User** (`json_api_user`)
whose only permission is *Access JSON:API Routes*. It's a ready‑made "API client"
role: assign it to a user, service account, or OAuth/Simple OAuth consumer that
needs API access, and it grants nothing else. Manage it under **People → Roles**,
or assign it from the command line.

## Command‑line recipes

Grant the permission to a role:

```bash
drush role:perm:add json_api_user 'access jsonapi routes'   # or any role
```

Assign the shipped role to a user:

```bash
drush user:role:add json_api_user someuser
```

Lock JSON:API down fast (for example during an incident) by revoking the
permission from every role — all JSON:API URLs then return 403:

```bash
drush role:perm:remove <role> 'access jsonapi routes'
```

## Good to know

- This gate is **additive**. It adds a prerequisite on top of core's entity and
  field access — it does not replace or relax them. Holding the permission unlocks
  the route, but the response is still filtered by the usual access checks.
- The permission is **not** marked as security‑restricted, so it is safe to grant
  to lower‑trust API roles; it only opens the door to the routes, not to any data
  the role couldn't already read.
- It applies automatically to every JSON:API route, including any custom route
  flagged as a JSON:API route — you never have to edit route definitions.
