# Animated Counter — manual setup guide

**Animated Counter** (`animated_counter`) provides a block that displays a number
counting up to a target value — the familiar "10,000+ customers" statistic that animates
from zero when it scrolls into view. It builds on the **Block Animate** module to trigger
the count-up as the block enters the viewport.

The numbers are configured by an administrator on the block, and the module has no
content or access-control role — it is a purely presentational, content-display feature
for showing eye-catching stat counters.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, then enable it.

## Where it lives in the admin menu

The counter is placed and configured like any other block, from **Structure → Block
layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** and place the Animated Counter block in the region
   where you want it.
2. Configure the block — set the target number (and any label around it) that should
   count up.
3. Save the block, then view a page where it appears and scroll it into view to watch the
   number animate up to its target.
