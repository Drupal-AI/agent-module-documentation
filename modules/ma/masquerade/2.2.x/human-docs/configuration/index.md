# Configuration

Masquerade has **no dedicated settings form**. Configuration means granting the
right permissions, optionally placing the Masquerade block, and — rarely —
setting one config flag. This page walks through each.

## 1. Grant permissions

This is the essential step: without permissions, no one can switch users.

1. Log in as an administrator and go to **People → Permissions**
   (`/admin/people/permissions`).
2. Find the Masquerade section and grant the permissions each role should have.
   You have three kinds to choose from:

| Permission | What it allows |
|-----------|----------------|
| **Masquerade as any user except super user** | Impersonate any account except UID 1 (the super user). A broad grant — give it only to trusted staff. |
| **Masquerade as super user** | Impersonate UID 1, the super user. The most powerful grant; hand it out very sparingly. |
| **Masquerade as *(role)*** | One permission **per role** (for example *Masquerade as editor*). Lets you grant "become an editor" without granting "become an admin". |

The per‑role permissions are the safest way to give support or QA staff exactly
the reach they need. Anonymous is intentionally excluded — to see the site as an
anonymous visitor, use a private/incognito browser window instead.

Every masquerade permission is marked **restricted**, because impersonation is a
sensitive capability. Grant them thoughtfully.

## 2. How people switch users

Once permissions are granted, authorized users can switch in any of these ways:

- **The `/masquerade` form** — an autocomplete **"Masquerade as…"** field plus a
  **Switch** button. Type the account to become and switch.
- **The Masquerade tab on a profile** — visit a user's page and use the
  **Masquerade** tab (`/user/{user}/masquerade`) to switch straight into that
  account.
- **Switch back** — go to `/unmasquerade`, or use the **Unmasquerade** link that
  appears in the account menu while you're impersonating someone.

## 3. Place the Masquerade block (optional)

For quick switching during testing you can add the switch form to a region as a
block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, and choose the **Masquerade**
   block (it's in the *Forms* category).
3. In the block's settings there's one Masquerade‑specific option:
   - **Show unmasquerade link** *(off by default)* — when ticked, the block shows
     a "Switch back" link while you're already masquerading, instead of the
     switch form.
4. Save the block.

## 4. The `update_user_last_access` flag (optional, no UI)

Masquerade stores one setting that has no form field:
`masquerade.settings.update_user_last_access` (a boolean, **false** by default).
It controls whether the target user's "last access" timestamp is updated while
you're impersonating them. Leaving it off means your impersonation sessions don't
disturb the real user's last‑access record. Change it only if you specifically
want the opposite, using Drush:

```bash
drush config:set masquerade.settings update_user_last_access true -y
```
