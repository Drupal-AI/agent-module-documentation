# Webform Translation Permissions — manual setup guide

**Webform Translation Permissions** (`webform_translation_permissions`) solves one
specific access problem. Out of the box, letting someone translate a webform means
granting Drupal's site‑wide **Translate configuration** permission — which also
lets them translate *every other* configuration entity on the site. That is far
more power than a webform translator usually needs.

This module narrows it down. It adds two new, clearly named permissions —
**Translate any webform** and **Translate own webform** — so you can give a
translator or webform author exactly the rights they need and nothing more. The
"own" permission only applies to webforms the user created (it compares the
webform's owner to the current user).

Once a user holds one of these permissions, a **Translate** operation link appears
next to webforms in the admin listings, and the webform's config‑translation pages
open for them — all while the powerful **Translate configuration** permission stays
reserved for administrators. There is no settings form to configure; the whole
module is driven by these two permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

This module has **no settings page of its own**. Everything happens on the
permissions page at **People → Permissions**
(`/admin/people/permissions`) — look for the two permissions under the *Webform
Translation Permissions* group.

## How to use it

1. Go to **People → Permissions**.
2. Grant the permission you need to the appropriate role:
   - **Translate any webform** — for a translator or language‑team role that
     should be able to translate every webform on the site.
   - **Translate own webform** — for authors who should only translate the
     webforms they created themselves.
3. Save permissions.

You can also grant them from the command line:

```bash
drush role:perm:add translator 'translate any webform'
drush role:perm:add webform_author 'translate own webform'
```

Users with the permission will now see a **Translate** link on webforms in the
admin listings and can open the webform's translation pages. For those links to be
actionable, the site must already have multilingual / configuration translation
set up, and the webform must have translatable content.
