# Custom Permissions — manual setup guide

**Custom Permissions** (`config_perms`) lets an administrator define brand‑new
permissions through an admin form, each tied to one or more Drupal **routes**, and
then assign them to roles just like any core permission. Its purpose is to break
up Drupal's broad, all‑or‑nothing admin permissions — most often **Administer site
configuration** — into finer slices you can safely delegate.

For example, out of the box core makes the "Site information settings" form
reachable only by users with `administer site configuration`, which also unlocks
dozens of other sensitive pages. With Custom Permissions you can create a
permission that gates just that one route, remove the broad permission from a
role, and hand that role only the scoped permission it needs. This is ideal for
"junior admin" roles, delegating one settings page to an ops or marketing team, or
giving a contractor temporary access to exactly one configuration route.

Under the hood, each custom permission is a `custom_perms_entity` config entity
with a machine ID, a human **label** (which becomes the permission's title on the
Permissions page), and a **route** value (one or more route machine names). A
route subscriber rewrites those routes so the only access check left is "does the
user hold this permission?" Custom permissions support **routes only**, not
arbitrary paths. User 1 always keeps full access, and the scoping only becomes
meaningful once you remove the broad permission from the roles you want to
constrain. The module ships four example permissions (account settings, date/time,
error logs, file system) so you can see the pattern.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating custom permissions and
   assigning them to roles.

## Where it lives in the admin menu

The management form is a **Custom permissions** tab under **People**, at
`/admin/people/custom-permissions/list`. It is gated by the **Administer custom
permissions** permission — grant that to trusted admins only, since anyone with it
can create permissions and rewire which routes they gate.

## How to use it

Enable the module, create a custom permission on the form (a label plus the routes
it should gate), rebuild the cache, then assign the new permission to a role on
**People → Permissions** — and remove the broad `administer site configuration`
from that role so the scoping takes effect. See
[Configuration](configuration/index.md) for the step‑by‑step.
