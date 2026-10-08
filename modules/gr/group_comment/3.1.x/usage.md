<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Comment turns each core comment into a Group relationship, so a comment posted on a group or grouped entity is automatically attached to that entity's group(s) and its access follows the group's comment permissions instead of only site-wide ones.

---

The Group module scopes nodes, media and other content to groups, but core Comment stays outside that model: comment permissions are per comment type and site-wide, and a comment has no idea which group its host belongs to. Group Comment closes that gap by registering a **group relation plugin** (`group_comment`, one derivative per comment type) with `entity_access = TRUE`, so Group's own entity-access layer governs who may view, update or delete a comment, using per-comment-type group permissions. The wiring is event-driven rather than manual: on `hook_entity_insert` a new comment is attached to every group its commented entity belongs to (a comment on a group attaches to that group; a comment on a grouped entity attaches to each group the entity is in), and on `hook_entity_predelete` of a group relationship the comments of the detached entity are removed from that group. Because the module never lets you add a comment to a group by hand, its operation provider returns no group operations and its access-control handler closes the group-relationship create routes — comments only ever enter a group through the normal comment form. Version **3.1.0-alpha1** on core `^10 || ^11`, requiring core `comment` and contrib `group ^3.0`. Note the README requirement: core must be patched (issue [#2879087]) for comment create-access delegation to work. The module also adds a per-comment-type **"skip comment approval"** group permission and a group-scoped **Comments overview** view at `group/{group}/comments` gated by the `access group_comment overview` group permission.

---

- Scope a group's comment threads to its members.
- Keep a department's internal discussion private to the department group.
- Restrict a project team's notes on a shared document to that team.
- Let a course cohort ask questions only its members can read.
- Keep a club's thread about an event visible to members only.
- Grant commenting on group content through a group role rather than a site role.
- Give trusted group roles "skip comment approval" so their comments publish immediately.
- Auto-attach every comment on a grouped node to all groups that node belongs to.
- Auto-detach a page's comments from a group when the page is removed from it.
- Give group admins a single "Comments" overview per group to moderate threads.
- Filter the group comments overview by approval status and comment type.
- Delegate "update any / update own / delete any / delete own" comment rights to group roles per comment type.
- Enforce group membership on comments in a multi-team intranet.
- Support a members-only discussion area built on core comment fields.
- Keep a committee's comments internal to the committee group.
- Apply group access to reader notes attached to shared media.
- Run per-group forums using standard comment threads plus Group permissions.
- Moderate unapproved comments per group instead of only site-wide.
- Let editors of one group comment on that group's content without site-wide "post comments".
- Alter which groups a comment attaches to via `hook_group_comment_attach_groups_alter`.
