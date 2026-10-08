# Group Privacy — manual setup guide

**Group Privacy** (`group_privacy`) extends the
[Group](https://www.drupal.org/project/group) module with a per‑group "private"
switch. When you mark an individual group private, it denies *all* operations on
that group and its content to outsiders — anonymous visitors and logged‑in users
who are not members — even if the group type's permissions would otherwise let
them in.

The clever part is *where* it enforces this. Group Privacy doesn't just hide the
group's full page; it filters private‑group content at the database‑query level.
So a private group's content also drops out of listings, search results, and
Views for anyone who isn't a member. This is a "fail‑closed" design: for a
non‑member outsider of a private group, every permission check returns "deny"
unless that user holds the special **bypass group privacy** permission.

A practical example: suppose you have a "Department" group type whose members can
create Documents and where all users may view Documents. You want one department,
"Management", to behave like the others but keep its Documents members‑only.
Marking the "Management" group as private achieves exactly that, without changing
the group type or building custom access code.

Because the **bypass group privacy** permission overrides the whole mechanism,
treat it as sensitive and grant it only to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.

There is **no central settings page** for this module. Privacy is a property of
each individual group plus a permission — both described below.

## How to use it

Group Privacy adds an **Is Private** checkbox to groups. To make a group private,
edit that group and tick the box; save. From that moment the group and its
content are invisible and inaccessible to non‑member outsiders, at both the page
level and the query level (listings, search, Views).

The module also provides a **bypass group privacy** permission. Anyone who holds
it can see and operate on private groups as though the privacy switch were off —
so it belongs to a named administrative role only. Grant the ordinary group
membership roles and permissions through the Group module as usual; Group Privacy
layers the private/not‑private decision on top of them.

Because it builds directly on Group, you need Group installed with at least one
group type and one or more groups before Group Privacy has anything to act on.
