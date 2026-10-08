# Comments Ban — manual setup guide

**Comments Ban** (`comments_ban`) lets site administrators stop specific users from
posting comments — without banning them from the whole site. It's a targeted
moderation and spam‑control tool: a persistently abusive commenter can be blocked
from the comment system while keeping their account and any other access intact.

Under the hood it adds a **"User banned from comments"** field to user accounts and
a validation check on the comment entity: when a banned user tries to post, the
comment is rejected. It also ships handy actions and a dedicated view — a *Remove
comment and ban user* action you can add to a comments view, an *Unban user from
the comments* action for user views, and a **Users banned from comments** admin
view at `/admin/config/people/banned-from-comments` for seeing and managing who's
banned. It depends on core's Comment module, sits in the Spam control package, and
works on Drupal 9, 10, and 11.

Access is governed by two core permissions: **`administer users`** lets a person
edit the ban checkbox on a profile and see the management view, and
**`administer comments`** lets a person run the *Remove comment and ban user* and
*Unban user from the comments* bulk actions. Both are trusted admin permissions.
Beyond blocking comment posting for the banned accounts, the module plays no
broader access‑control role. Note that the ban targets **authenticated** accounts;
anonymous commenters are unaffected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, set
   permissions, and expose the ban field on the user form.

There is **no dedicated settings form** — setup is a few one‑time steps and then
banning happens per user, as described in "How to use it" below.

## Where it lives in the admin menu

The management view lives at **Configuration → People → Users banned from
comments** (`/admin/config/people/banned-from-comments`). Banning itself happens on
each user's edit form, and permissions are managed at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

**Initial setup (one time):**

1. Grant the core **`administer users`** permission (to manage bans via the profile
   field and the management view) and/or **`administer comments`** (to use the
   ban/unban bulk actions) to the roles that should be allowed to ban commenters
   (**People → Permissions**).
2. Enable the **"User banned from comments"** field on the user account form —
   under **Configuration → People → Account settings → Manage form display**
   (`/admin/config/people/accounts/form-display`) — so the checkbox appears when
   editing a user.

**To ban a user:** open the user's profile, click **Edit**, tick **User banned
from comments**, and save. That user can no longer post comments.

**To unban a user:** either edit the user again and untick the field, or go to
**Configuration → People → Users banned from comments**
(`/admin/config/people/banned-from-comments`), select one or more users, and use
the bulk **unban** operation.

You can also add the *Remove comment and ban user* action to a comments view for
one‑click moderation, and the *Unban user from the comments* action to a user view.
