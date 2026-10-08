# Call Now Button — manual setup guide

**Call Now Button** (`call_now_button`) adds a click-to-call button fixed to the
bottom of the screen, shown **only on mobile devices**. It gives mobile visitors
a persistent, one-tap way to phone the business — the kind of call-to-action a
local service site wants front and centre for people browsing on their phones.

The phone number is set by an administrator and rendered as a standard `tel:`
link, so tapping it opens the visitor's dialler with your number ready to call.
Because that number is published in the page, use a number that is meant to be
public. The module provides its own permission but has no access-control role
beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Call Now Button provides its own permission, which you set under **People →
Permissions** (`/admin/people/permissions`). It stores the phone number and
button settings in its own configuration; grant the permission only to the roles
that should manage it.

## How to use it

1. Enable the module.
2. Grant the module's permission to the roles that should manage the button.
3. Set the **phone number** the button should dial — make sure it is a number
   you are happy to publish, since it becomes a public `tel:` link.
4. The button then appears fixed at the bottom of the screen for mobile
   visitors, who can tap it to call.
