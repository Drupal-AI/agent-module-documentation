# Masquerade Field — manual setup guide

**Masquerade Field** (`masquerade_field`) extends the
[Masquerade](https://www.drupal.org/project/masquerade) module so an account can
masquerade as a **specific, named set of other users** — the ones listed in a user
reference field on that account — rather than as anyone on the site.

Plain Masquerade's "masquerade as" permission is close to unbounded: whoever holds
it can become the site administrator. That is why it is so tightly restricted, and
why many teams that genuinely need the support workflow (seeing exactly what a
customer sees) cannot safely grant it. This module narrows the power to a list. You
add a user reference field to accounts; each account may then masquerade only as
the users named in its field. A departmental support agent can impersonate the
members of their own department and nobody else; a delegated administrator can act
for just the accounts they actually manage.

The permission design is deliberate and worth understanding: **`edit masquerade
field`** — the permission that decides *who may impersonate whom* — is a
high‑privilege, restricted permission, while **`view own masquerade field`** and
**`view any masquerade field`** are separate and let a user merely *see* the list.
Seeing the list is not the same as being able to set it.

> **This is still an impersonation tool — treat it with care.** While masquerading,
> the impersonator can do anything the target user can do, so a list that includes
> any privileged account effectively hands over that account's authority. Two
> things to establish for any impersonation feature: an **audit trail** (log who
> masqueraded as whom and when, somewhere the impersonator cannot edit) and a
> **considered scope** (never add administrator or other privileged accounts to a
> masquerade field). Grant `edit masquerade field` only to fully trusted staff.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Masquerade) and enable it.

There is **no central settings page** — you add a field to the user entity and set
permissions, described in "How to use it" below.

## Where it lives in the admin menu

- **Configuration → People → Account settings → Manage fields**
  (`admin/config/people/accounts/fields`) — add the masquerade user reference
  field to accounts, and set its display formatter under **Manage display**.
- **People → Permissions** (`admin/people/permissions`) — grant the masquerade
  field permissions to the right roles.

## How to use it

1. **Add the field.** On the User entity's **Manage fields**, add a user reference
   field (the field this module works with) that will hold the accounts a user may
   masquerade as.
2. **Set the display.** On **Manage display**, use the formatter this module
   provides so each referenced user appears as a link the user can click to
   masquerade as that account.
3. **Populate the field.** An administrator with `administer users` and **`edit
   masquerade field`** edits a user's profile and selects the target accounts that
   user will be allowed to masquerade as.
4. **Grant viewing.** Give the relevant roles **`view own masquerade field`** so a
   user can see (and use) their own list on their account page; use **`view any
   masquerade field`** only where staff need to see other users' lists.
5. The user opens their account, sees the list, and clicks a target to masquerade
   as that account. To end the session, use Masquerade's own "switch back" control.
