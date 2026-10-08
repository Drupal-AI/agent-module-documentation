# Group Notify — manual setup guide

**Group Notify** (`group_notify`) emails a group's members when new content is
posted to that group. It extends the
[Group](https://www.drupal.org/project/group) module — specifically its Group
Node (`gnode`) plugins — and turns a group from a place people are told to check
into one that tells them when something happens. That difference is what separates
a working intranet, project space, or course cohort area from a document dump, and
because Group already models who belongs to each group and in what role, the
module already knows exactly who should be told.

You switch notifications on per group content type. Once the module is enabled you
go to your group types, look at the content plugins provided by Group Node, and
turn on **Notify group members** for the ones you want to announce. From then on,
saving that kind of content in a group emails its members.

There are a few things worth planning before you turn this loose, because email is
easy to over-send:

- **Volume decides whether it works.** A busy group that emails every member on
  every item trains people to filter it out within a week. If your groups are
  active, a digest or a per-member frequency preference tends to work better than
  one message per item.
- **Access and notification must agree.** A notice about content the recipient
  cannot actually open is worse than no notice — and this is not checked
  automatically, because the email is composed when content is *saved* while
  access is evaluated when it is *read*. Make sure the members you notify can
  reach what you are announcing.
- **The email's content is a disclosure decision.** A message that carries the
  content itself sends group-restricted material to whatever mailbox a member
  uses, possibly a shared one. A subject line plus a link back to the site is the
  safer shape and keeps the access decision where it belongs.

If saving group content becomes slow because a group has many members to notify,
the `queue_mail` module can move the sending into a queue to smooth it out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group Node.
2. [Configuration](configuration/index.md) — turn on *Notify group members* for
   the group content types you want.

## Where it lives in the admin menu

Group Notify has no standalone settings page. You enable notifications on the
Group Node content plugins, under **Administration → Groups → Group types → *(your
group type)*** → *Set available content*, described in
[Configuration](configuration/index.md).
