# Badge Notification — manual setup guide

**Badge Notification** (`badge_notification`) shows small count badges on menu
items — the little "3" bubble you see next to a menu link to signal unread
items, pending tasks, or anything else worth counting. The counts are loaded
**asynchronously**, so they can update without reloading the page.

The counts themselves are driven by Views. Because a View already respects the
viewing user's access, each user only sees a count for the items they are
actually allowed to see — the module adds no access-control behaviour of its own
beyond its permission. It builds on core's **History**, **Views** and **Menu UI**
modules and runs on Drupal 8 through 11.

This is a user-interface / engagement feature. It ships its own permission so you
can control who the badges are shown to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is no central settings page. You wire a badge up by connecting a menu item
to a View that produces the count you want to show, and the module renders that
number as a badge on the menu link, refreshing it asynchronously. Because the
count comes from a View, you control exactly what is counted (unread content,
open items, and so on) using the normal Views UI — filters, contextual filters
for the current user, and access settings all apply as usual. Grant the module's
permission to the roles that should see the badges.
