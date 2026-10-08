# Configuration

Like and Dislike shows **nothing** until you turn it on for specific entity types
and grant the permission to vote. There are two steps: enable the entity types on
the settings page, then set permissions.

## Step 1 — Choose which entity types show the widgets

1. Log in as a user with the **Administer like and dislike** permission.
2. Go to **Configuration → Search and metadata → Like and Dislike**, or navigate
   directly to `/admin/config/search/like_and_dislike`.
3. The form lists the available entity types and their bundles — content types,
   comments, files, users, and so on. **By default none are enabled.** Tick the
   ones where you want the like/dislike widgets to appear.
4. Save the form.

Once a type is enabled, its content displays the two widgets with the running
like and dislike tallies.

## Step 2 — Set who may vote

The widgets are gated by permissions, so you control exactly who can react — and
this is your main defense against anonymous vote abuse.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant the voting permission to the roles that should be allowed to like and
   dislike. There is a dedicated per‑type permission model, so you can allow
   voting for the roles and content you intend and leave the rest closed.
3. The **Administer like and dislike** permission controls who can reach the
   settings page in Step 1 — keep that limited to administrators.

## Guarding against abuse

If you allow **anonymous** users to vote, expect that counts can be inflated
without an account to tie a vote to. Limit anonymous voting through permissions,
and consider Drupal's flood/rate controls, so the tallies remain a signal you can
trust.

## How the data is stored

Votes are recorded through **Voting API** using two tags, `like` and `dislike`,
kept separate (not a single net score). Because the storage is Voting API's
standard schema, the tallies are available to other Voting‑API‑aware tools, and
migrating from some similar modules needs no special data conversion.
