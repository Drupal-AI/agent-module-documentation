# All — manual setup guide

**All** (`all`) is a site-builder convenience module that gathers the settings of
many content types onto a **single admin page**, so you can change options across
several content types at once instead of opening each content type's settings
form one at a time. On a site with a lot of content types, that turns a lot of
repetitive clicking into one pass.

It edits content-type configuration, so it is squarely an administrator tool with
no front-end role. Access is controlled by a single **Administer all** permission
— grant it only to trusted site builders, since it can change settings across
your whole content model in bulk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and assign the permission.

## Where it lives in the admin menu

All adds an administration page where content-type settings are collected
together for editing. Access to it is gated by the **Administer all** permission,
which appears on **People → Permissions**.

## How to use it

1. Enable the module and grant the **Administer all** permission to trusted site
   builders on **People → Permissions**.
2. Open the module's admin page, where the settings of your content types are
   gathered on one screen.
3. Adjust the options you want across the content types and save — the changes
   apply to all of them at once, keeping your configuration consistent without
   visiting each content type individually.
