# StandWithUkraine — manual setup guide

**StandWithUkraine** (`standwithukraine`) is a purely cosmetic front-end module
that shows your support for Ukraine. It displays a support message/banner and adds
image styling in the Ukrainian flag colors, so your site visibly expresses
solidarity. It sits in the User interface package and adds nothing to your content
model or access model beyond a permission of its own.

The module depends on the **Service** module (`service`) and must be installed
alongside it. Once enabled, the effect is front-end only — a message and styling —
so there is little to secure or maintain. Its own permission governs who can work
with the support-message display.

Note that the module's own machine name (`standwithukraine`) differs from the
similarly named `stand_with_ukraine` module, which is a separate block-based
project; make sure you are installing the one you intend.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Service module) and enable it.

## How to use it

Once enabled, StandWithUkraine adds its support message and flag-color image
styling to the front end. It is cosmetic — there is no ongoing content to manage.
The module ships its own permission controlling the support-message display; grant
it to the roles you want on the **People → Permissions** page
(`/admin/people/permissions`).
