# Configuration

Configuration is a single form: enter the memory limit you want for each role. Leave
a role blank and it stays on the server's normal PHP limit.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Role memory limit**
   (`/admin/config/system/role-memory-limit`).

## Set a limit per role

Next to each role, enter the memory limit you want to apply while that role is
active. A few rules govern how the values are interpreted:

- **Values are plain integers in megabytes** — for example `256` for 256&nbsp;MB.
  Enter just the number.
- **`-1` means unlimited** — use this only for a role you fully trust.
- **The highest limit wins when a user has several roles.** If someone holds two
  roles with different limits, the larger of the two is applied for the request.
- **User&nbsp;1 uses the `administrator` value**, so set the administrator limit to
  whatever you want the superuser to get.

A typical setup leaves anonymous and authenticated users on the server default and
raises only the administrator (and perhaps an editor or migration/import) role that
genuinely needs more headroom.

Save the form. Because the limit is applied early in each request, the change takes
effect on the next page load for users in that role.

## Grant generous limits only to trusted roles

Raising the limit for a role means every request made by users in that role may
consume that much memory. Keep low-trust roles — especially anonymous — on a
conservative limit, and reserve high or unlimited limits for the small set of
trusted roles that actually need them. This keeps the memory relief targeted rather
than exposing the whole site to high per-request memory use.
