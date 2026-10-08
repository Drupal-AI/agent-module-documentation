# Performance and Scalability Checklist — manual setup guide

**Performance and Scalability Checklist** (`pasc`) is an interactive checklist of
performance and scalability optimization tasks for Drupal. Rather than optimizing
your stack from memory, you work through a guided, checkable list of recommended
tuning steps — spanning the whole stack, from the web server up to your Drupal
theme — so a team can see at a glance which optimizations have been done and which
are still outstanding.

It is built on the **Checklist API** (`checklistapi`) module, which provides the
checkable‑list machinery: each item can be ticked off, and Checklist API records
who completed it and when. That makes the module useful as a shared, trackable
reference during a performance review or a launch checklist, not just a one‑off
reading list.

There is nothing to configure — the value is in the checklist itself. Install it,
enable it, and start working through the items.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Checklist API dependency, and enable it.

There is **no configuration page** for this module — its content is the checklist
you fill in, described under "How to use it" below.

## How to use it

1. Once enabled, open the checklist from Drupal's administration area (the module
   registers a Checklist API checklist; you will find it among the site's
   checklists/reports).
2. Work down the list of performance and scalability tasks. As you complete each
   optimization on your site, tick its box.
3. Checklist API saves your progress — including who checked each item and when —
   so the whole team can track what is done and what remains.

The module does not change your site's performance by itself; it is a structured
guide to the changes *you* make.
