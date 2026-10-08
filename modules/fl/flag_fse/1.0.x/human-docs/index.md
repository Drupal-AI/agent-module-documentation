# Flag for someone else — manual setup guide

**Flag for someone else** (`flag_fse`) extends the
[Flag](https://www.drupal.org/project/flag) module so that authorized users can
flag content **on behalf of another user**. Where a normal flag records "I flagged
this", Flag FSE lets a moderator or administrator create the flagging for a
*chosen* account — for example bookmarking a resource into a specific member's
list, assigning a task to someone, or logging content a user reported offline.

It works by adding a **"For someone else"** link type to your flags. On flags that
use it, an authorized user sees both the standard flag link and a "Flag for
someone else" link. Clicking the latter opens a form where they can search for an
existing user by username or email (with autocomplete) and — for administrators —
even create a brand‑new user account on the spot. The form checks for duplicate
flaggings before it creates one, and it can open as a normal page, a dialog, or a
modal dialog.

Because this feature acts on behalf of other people, it is permission‑gated **per
flag**: the module automatically generates a `flag fse [flag_id]` permission for
each flag, and only roles that hold that permission see the "for someone else"
link. Grant it to trusted roles such as moderators and administrators. Users
without the permission simply see the ordinary flag link and can only flag or
unflag for themselves.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (with the Flag module), and grant the per‑flag permissions.

There is **no central settings page** — you set the "For someone else" link type
and its options on each individual flag, and grant the generated per‑flag
permissions, so there is no separate configuration chapter in this guide.

## Where it lives in the admin menu

- **Flags:** create or edit flags at **Structure → Flags**
  (`/admin/structure/flags`) and set their **Link type** to **For someone else**.
- **Permissions:** grant the generated `flag fse [flag_id]` permissions at
  **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Go to **Structure → Flags** and create or edit a flag. Under **Link type**,
   choose **For someone else**, then configure its options:
   - **Fallback plugin** — the link type used for users who lack the FSE
     permission (for example an AJAX link).
   - **Flag FSE link text** — the text of the "for someone else" link
     (default: *Flag for someone else*).
   - **Flag confirmation message** — the message shown in the confirmation form.
   - **Create flagging button text** — the submit button label.
   - **Form behavior** — open the form as a **New page**, **Dialog**, or **Modal
     dialog**.
2. Save the flag.
3. At **People → Permissions**, find the `flag fse [flag_id]` permission for that
   flag and grant it to the roles that should be able to flag on behalf of others
   (moderators, administrators).
4. Those users will now see the "Flag for someone else" link next to the standard
   flag link, and can select (or, as admins, create) the target user in the form.
