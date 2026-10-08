# Configuration

Forum Access does not have a settings page of its own. Instead it extends the
existing **forum overview**, so you configure access on each forum from the same
place you manage forums.

## Open the forum administration

1. Log in as a user with permission to administer forums.
2. Go to **Structure → Forums** (`/admin/structure/forum`).
3. Edit the forum you want to control (or add a new one). The edit form now
   includes a Forum Access grid rendered per forum.

## Set per‑forum access

For each forum, Forum Access presents a grid of **roles** against the actions they
may take in that forum. Use it to decide, role by role, who can:

- **View** the forum and its topics,
- **Post** new topics,
- **Edit** posts, and
- **Delete** posts.

This is how you make a forum **private**: grant *View* only to the roles that
should see it, and leave it off for everyone else. You can mix and match — for
example allow a role to read an announcements forum but not post to it, or open a
members‑only board to a paid‑membership role alone.

## Assign moderators

Each forum can also be given a list of **users who have administrative access on
that forum** — its moderators. Add the specific users who should be able to manage
that forum's content, and they gain moderator rights **on that forum only**,
without needing site‑wide forum or content permissions. This is how you delegate
moderation of a single board to a working group or community lead.

## Save and rebuild access if needed

Save the forum. On most sites the new access takes effect immediately. On **large
sites**, after changing access settings the node access records may need
rebuilding — an administrator can do this with:

```bash
drush php:eval 'node_access_rebuild();'
```

## Good to know

- **Access is applied through ACL.** Forum Access maps forums onto the ACL
  module's per‑user access lists rather than a bespoke grants system. If access
  behaves unexpectedly, ACL's tables are the place to look.
- **Grants are OR.** Drupal combines node‑access grants with OR logic, so if you
  run **other node‑access modules**, one of them granting access can override a
  Forum Access restriction. Keep that in mind when combining access modules — your
  results may vary depending on how they interact.
