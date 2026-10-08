# Birthday Block — manual setup guide

**Birthday Block** (`birthday_block`) displays upcoming users' birthdays in a block.
Drawing on a user birthday field, it shows which members have birthdays coming up —
a friendly touch for community sites and intranets where people like to know when to
say happy birthday.

It is a user-engagement feature built around core's User module. You place the block
where you want the list to appear, and it reads the birthday field to work out whose
birthdays are next.

**Privacy matters here.** Birthdays are personal data, and showing them (and, by
extension, possibly someone's age) is a privacy consideration. Make sure users have
consented to having their birthday shown, and restrict the block's audience
appropriately so it is only visible to the people who should see it. The module
itself has no access-control role — that governance is up to you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core User).

## Where it lives in the admin menu

You place the block through **Structure → Block layout**
(`/admin/structure/block`), adding the birthday block to the region where you want
upcoming birthdays to show.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure your users have a birthday field populated (the block reads it to find
   upcoming birthdays).
3. Go to **Structure → Block layout**, place the birthday block in a region, and use
   the block's visibility settings to restrict who can see it — remembering that
   birthdays are personal data and should only be shown with consent to an
   appropriate audience.
