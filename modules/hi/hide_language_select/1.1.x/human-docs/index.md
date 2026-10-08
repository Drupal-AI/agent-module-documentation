# Hide Language Select — manual setup guide

**Hide Language Select** (`hide_language_select`) hides the **language‑select field**
on the user account (profile and registration) form, and reveals it again only for
users who hold a dedicated permission. It is handy on a multilingual site where you
want your editors or staff to be able to change their own backend/interface
language, but you would rather ordinary visitors never see that option.

The behavior is intentionally simple: enable the module and the field is hidden for
everyone by default; grant the **Show language select on user edit form**
permission to a role and its members will see the field again.

One important clarification: this controls the **display of the field on the form**,
not the underlying language capability. It is a form‑visibility convenience, not an
access‑control mechanism.

For the field to matter at all, your site must have **user‑based language selection
activated** (Drupal's per‑user language negotiation). Without that, the field has no
effect and there is nothing for this module to hide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** for this module — it is controlled entirely by a
permission, as described below.

## How to use it

- **To simply hide the field:** just enable the module. No further configuration is
  needed — the language‑select field disappears from the user form for everyone.
- **To reveal it for certain roles:** go to **People → Permissions**
  (`/admin/people/permissions`) and tick **Show language select on user edit form**
  for each role that should see the field. Save permissions.

Remember to make sure user‑based language selection is enabled under your site's
language and regional settings, or the field (and therefore this module) has nothing
to act on.
