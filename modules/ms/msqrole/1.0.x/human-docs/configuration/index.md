# Configuration

Setting up Masquerade as Role is mostly about permissions — deciding who may
masquerade and into which roles. There is also one small settings form for
fine‑tuning the render cache.

## Permissions — who can masquerade, and as what

Grant these at **People → Permissions** (`/admin/people/permissions`).

- **Masquerade role** — lets a user open the masquerade form at **People →
  Masquerade as role** and view the site as other roles. This is the baseline
  permission for using the feature.
- **Create masquerade role link** — lets a user generate shareable links that
  activate a chosen role set for whoever opens them (optionally single‑use).
- **Administer masquerade role** — lets a user change the module's settings (the
  form described below). This is a restricted, sensitive permission — grant it
  only to trusted administrators.

### Per‑role permissions — the important part

On top of the baseline **Masquerade role** permission, the module generates one
permission **per role**, named **Masquerade as *(role label)***. This is what
actually authorizes impersonating a specific role. In other words, to let someone
view the site as the "Content editor" role, they need **both**:

1. **Masquerade role** (to use the form at all), and
2. **Masquerade as Content editor** (to choose that particular role).

This two‑part design lets you decide precisely which roles each user may
impersonate — you might allow a support agent to masquerade as a customer‑facing
role, but not as anything more privileged.

Note that these per‑role permissions are generated only for "configurable" roles.
The **Anonymous**, **Authenticated**, and **Administrator** roles are deliberately
excluded, so you will not find a "Masquerade as administrator" permission.

## Settings form — extra cache tags to clear

1. Log in as a user with the **Administer masquerade role** permission.
2. Go to **Configuration → People → Masquerade as role**, or navigate directly to
   `/admin/config/people/masquerade-role`.

The form has a single setting:

- **Tags to invalidate** — a list of extra Drupal **cache tags** to clear
  whenever a user activates or resets masquerade, one per line.

Why it exists: switching effective roles can leave stale, permission‑specific
markup in the render cache. The module already clears a standard set of tags on
every switch (things like local tasks and actions, the admin/account/tools menus,
and the current user's own tag), and it varies the render cache by masquerade
state automatically. But if a specific block or element still shows or hides
incorrectly after switching roles, add **its** cache tag here so it gets cleared
too. For most sites you can leave this empty.

Click **Save configuration** when done.
