# Account Name — manual setup guide

**Account Name** (`account_name`) changes the **My account** menu link so it shows
the logged-in user's own name and picture instead of the generic "My account" text.
It is a small personalization: the account menu becomes clearer and friendlier
because visitors see themselves in it, which also helps them orient in the account
area.

It is a user-interface and theming enhancement. It does not create content and has
no access-control role of its own — it only changes how the existing account menu
link is displayed. It supports a wide range of Drupal versions, from 8.9 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Enable the module and the **My account** menu link automatically shows the current
user's name and picture. There is no settings form to fill in. The module does
define a permission of its own; if you want to control who sees the personalized
link, review **People → Permissions** (`/admin/people/permissions`) after enabling
it and set that permission for the relevant roles.
