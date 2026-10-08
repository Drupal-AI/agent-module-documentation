# Configuration

Comment Limit is configured **per comment field**, on a per‑node‑type basis, so
you can give different content types different caps (or no cap at all). There is no
single site‑wide settings page — you set the maximum where the comment field is
defined.

## Set the limit on a comment field

1. Log in as an administrator.
2. Go to the content type whose comments you want to limit — **Structure →
   Content types → *(your type)* → Manage fields**
   (`/admin/structure/types/manage/*/fields`).
3. Edit the **Comments** field on that type.
4. Set the maximum number of comments a user may post, then save.

The cap now applies to that comment field. A user who reaches the maximum can no
longer add comments on that content type; content with a different (or unset) limit
is unaffected.

## Review the permission

Comment Limit adds its own permission, which you manage at **People → Permissions**
(`/admin/people/permissions`). Review it and grant it to the appropriate roles —
typically you'd let trusted or administrative roles operate without being subject
to the cap while ordinary users remain limited. Configure this to match how you
want the limit applied on your site.

## Tips

- **Pick the number carefully.** The limit counts comments, not quality, so set it
  high enough that genuine, active commenters aren't frustrated, while still low
  enough to bound flooding and volume‑based spam.
- **Combine it with other measures.** Comment Limit reduces volume‑based abuse but
  isn't a substitute for moderation or a CAPTCHA — use it as one layer among your
  anti‑spam tools.
