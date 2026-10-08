# Configuration

Configuring Display Mode Extras is a two‑part job: choose which display modes should
be governed by role, then assign the permissions it generates for them.

## Step 1 — opt display modes into governance

1. Log in as a user with the **Administer site configuration** permission.
2. For **form modes**, go to **Structure → Display modes** settings
   (`/admin/structure/display-modes/settings`). For **view modes**, go to
   `/admin/structure/display-modes/settings/view_modes`.
3. On each form, select the specific form modes / view modes you want to bring under
   role‑based control. Only the modes you opt in here become governed; everything
   else keeps its default (unrestricted) availability.
4. Save.

## Step 2 — assign the generated permissions

For every display mode you opted in, the module generates one **dynamic permission**
("use *[mode]*"). To grant it:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the permission(s) named after your managed display modes.
3. Tick the roles that should be allowed to use each mode, and save.

> **Tip:** because the permissions are generated dynamically, clear caches after
> marking a new mode as managed so its permission shows up on the Permissions page.

## How it behaves

- Once a mode is managed, **only roles granted its permission** can use that form or
  view mode; other roles cannot.
- A typical use is giving a "Basic editor" role a slimmed‑down form mode while a
  "Power editor" role gets the full one.
- The generated permissions are ordinary Drupal permissions — exportable via CMI and
  deployable across environments.
- The settings routes are gated by the core **Administer site configuration**
  permission and marked as admin routes; the module does not expose entity data
  through any route, it only affects display‑mode availability.
- Removing a mode from management restores its default, unrestricted availability.

Since enabling governance widens the permissions matrix, review the generated
permissions after you add each mode to be sure roles have exactly the access you
intend.
