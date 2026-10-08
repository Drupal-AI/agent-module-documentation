# Configuration

Setting up menu delegation takes two steps: pick one active **access scheme** site‑wide, then
assign **sections** to each menu you want to restrict. Both forms require the **Administer
workbench menu access** permission.

> **Prerequisite:** at least one Workbench Access **access scheme** must already exist. Create
> one with the [Workbench Access](https://www.drupal.org/project/workbench_access) module at
> **Configuration → Workflow → Workbench Access** (`/admin/config/workflow/workbench_access`).

## Step 1 — Pick the active scheme (site‑wide)

1. Go to **Configuration → Workflow → Workbench Access → Menu settings**
   (`/admin/config/workflow/workbench_access/menu_settings`).
2. Choose an **access scheme** from the select list. The option **"Do not restrict menu
   access"** turns menu restriction off entirely.
3. Save.

If no schemes exist, the form tells you to create one first.

## Step 2 — Assign sections to a menu (per menu)

1. Go to **Structure → Menus** (`/admin/structure/menu`) and open the **Access settings**
   operation for a menu (or visit its **Workbench menu access** tab directly at
   `/admin/structure/menu/manage/{menu}/access`).
2. Select the editorial **section(s)** that should be allowed to edit this menu and its links.
3. Save.

Selecting one or more sections restricts editing that menu to users in those sections.
**Selecting none leaves the menu unrestricted** — only core's `administer menu` permission
applies. So assign sections to *every* menu you intend to lock down.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

- **Administer workbench menu access** *(security‑sensitive)* — access both configuration forms
  and the per‑menu section selector. It also **bypasses** the section checks, so grant it only to
  trusted site administrators.
- **Bypass workbench access** *(from Workbench Access)* — a user with this skips the per‑menu
  section check and is treated as unrestricted (core `administer menu` still applies).

Your delegated, lower‑trust editors should **not** get *Administer workbench menu access*. They
get their menu access from two things together: their Workbench Access **section membership**,
plus a **core menu permission** (typically `administer menu`). Remember this module only *adds*
restrictions — it never grants menu access to someone who lacks the core permission.

## How enforcement resolves (read before relying on it)

A menu is restricted **only when both** are true: an active scheme is set **and** the menu has
sections assigned. If either is missing, the menu is *not* restricted by this module and falls
back to core's `administer menu` gate. This "no sections = unrestricted" behavior is by design —
so double‑check that every menu you want protected actually has sections assigned under its
*Workbench menu access* tab.
