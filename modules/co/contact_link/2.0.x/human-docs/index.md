# Personal Contact Form Link — manual setup guide

**Personal Contact Form Link** (`contact_link`) provides a **Display Suite (DS)
field** that renders a ready-made link to a user's **personal contact form** at
`/user/{uid}/contact`. Place it on a user-profile display and you get a one-click
"contact this user" link without having to theme one by hand.

The problem it solves is small but common: you want a "Contact" link on user
profiles, but building it yourself means writing template code and repeating the
correct access checks. This field does it for you, and it slots into a Display
Suite layout alongside your other profile fields. It requires the
[Display Suite](https://www.drupal.org/project/ds) module (`ds`).

Crucially, the link only shows when it should: it respects core's personal contact
form access rules, so it appears only if the target user has enabled their personal
contact form **and** the current viewer has permission to use it. It adds no access
bypass, no routes, and no permissions of its own — the security surface is trivial.

There's no settings form. You set it up entirely on the user entity's **Manage
display**, as described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it along with its Display Suite dependency.

There is **no configuration page** for this module — you place and arrange the
field on the user display, as described below.

## Where it lives in the admin menu

Personal Contact Form Link adds no settings page. You use it through Display Suite
on the user entity at **Configuration → People → Account settings → Manage
display** (`/admin/config/people/accounts/display`), using a DS layout.

## How to use it

1. Make sure **Display Suite** is enabled (it's a dependency) and that a DS layout
   is applied to the user display you want to edit.
2. Go to the user entity's **Manage display** and switch on a Display Suite layout
   if you haven't already.
3. Place the **contact link** DS field into one of the layout's regions.
4. Save the display.

The field then renders a link to each user's personal contact form
(`/user/{uid}/contact`) on that view mode — appearing only when the target user
has their personal contact form enabled and the viewer is allowed to use it. To
remove it later, just unplace the field or uninstall the module.
