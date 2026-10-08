# Logged In — manual setup guide

**Logged In** (`logged_in`) is a very small, single‑purpose module: it adds one
**Views field** that tells you whether the user on a given row is currently logged
in. That's the whole module. It was inspired by the common question of how to
check, inside a view, whether a user has an active session — and it answers it by
exposing a simple boolean field you can drop into any user‑based view.

Because it returns a plain true/false, it's most useful as a building block. You
can show it directly as an "online now" indicator, or reference its value in Twig
— for example inside a **Custom Text** field or a field rewrite — to render your
own label, icon, or conditional markup.

Logged In has no settings, no dependencies of its own beyond Views, and no
access‑control role. It simply reports status; the view's own access settings
decide who can see the result.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the field is set up entirely within the
Views UI, described in "How to use it" below.

## Where it lives in the admin menu

Logged In adds no admin page of its own. You use it from **Structure → Views**
(`/admin/structure/views`) when building or editing a view.

## How to use it

1. Create or edit a view whose rows are **users** (or that has a relationship to
   the user entity).
2. Under **Fields**, click **Add** and search for the **Logged In** field. Add it
   to the view.
3. Display it as‑is for a straightforward logged‑in/not indicator, or use it as a
   data source: rewrite another field or a **Custom Text** field with Twig that
   reads the value to render your own "Online" / "Offline" presentation.

> **A privacy note worth keeping in mind:** showing who is *currently online* is
> user presence data, and it can reveal usage patterns. Expose the field only in
> views whose access is limited to appropriate roles, rather than on pages any
> anonymous visitor can read.
