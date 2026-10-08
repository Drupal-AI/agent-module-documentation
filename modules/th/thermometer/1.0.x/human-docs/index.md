# Thermometer — manual setup guide

**Thermometer** (`thermometer`) gives you a classic fundraising "thermometer"
widget: a bar that fills up to show how much of a goal has been reached. You place
it as a block, tell it the target amount and the current amount, and it draws a
filling thermometer so visitors can see progress at a glance — the kind of thing
you see on donation and campaign pages.

It does this entirely with CSS and JavaScript, without relying on any external
third-party service or Flash, so nothing leaves your site and there is nothing to
sign up for. The goal and current values are set by an administrator on the block
itself, so the module has no content or access role of its own — it simply displays
the numbers you give it.

The output is themeable if you want to restyle it, but bear in mind that the
JavaScript depends on the block's markup to a certain extent, so tread carefully
when overriding the template.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no separate settings page — everything is configured on the block:

1. Enable the module.
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Place the **Thermometer** block in the region where you want it to appear.
4. In the block's configuration, set the **target** (goal) value and the
   **current** value.
5. Save. The thermometer renders in that region, filled to reflect current
   progress toward the goal.

To update progress later, edit the block and change the current value.
