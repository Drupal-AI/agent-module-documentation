# Meeting API — manual setup guide

**Meeting API** (`meeting_api`) is a framework for running online meetings from
Drupal without tying your site to any single conferencing provider. It models a
meeting as a **content entity** — with a time, a description, participants and a
join URL — so meetings become first‑class things that can appear in views,
calendars and notifications. The actual conferencing is delegated to **pluggable
backends**, which means switching provider later is a plugin swap rather than a
site‑wide migration. A direct integration with, say, Zoom would otherwise spread
that provider's identifiers and API quirks throughout your site; Meeting API keeps
the provider at one clean boundary.

It ships with **meeting types** (bundles) that you configure, and two submodules for
common needs: **`meeting_api_manual`**, for meetings whose join URL is simply pasted
in by hand (the simplest case, and one many systems overlook), and
**`meeting_api_scheduler`**, for automated scheduling. Provider integrations for
specific platforms — such as BigBlueButton via the separate `meeting_api_bbb`
module — build on top of this framework.

Notably, Meeting API depends on **`datetime_range_timezone`** rather than core's
plain date‑range field, which is the right call: a meeting without an explicit
timezone is the classic distributed‑team bug, and this dependency ensures each
meeting carries one. The module supports Drupal 10 and 11 and is currently an
**alpha** (1.0.0‑alpha3), so treat its API as still evolving.

> **Two things to plan.** Provider **API credentials** belong in environment
> variables behind **Key** entities — a meeting‑platform API key can typically create
> and read meetings across your whole account. And a **join URL is a capability**:
> anyone who has it can usually enter the meeting, so treat join links as secrets in
> listings, feeds and emails rather than as ordinary fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull in
   its date/timezone dependency, and enable the submodules you need.

There is **no single module settings page**. You work with meeting *types* and
*meetings* as entities, and configure a backend by enabling a provider submodule —
described in "How to use it" below.

## Where it lives in the admin menu

Meeting API works through Drupal's entity administration rather than one settings
form:

- **Meeting types** are managed under **Structure** (the meeting‑type admin), gated
  by the `administer meeting_api_meeting types` permission.
- **Meetings** themselves are created and listed as content entities.

## How to use it

1. Install and enable Meeting API plus the submodule(s) you need — start with
   **`meeting_api_manual`** if you just want to paste in meeting URLs, and/or
   **`meeting_api_scheduler`** for automated scheduling.
2. To use a real conferencing platform, also enable a **provider** module — for
   example **`meeting_api_bbb`** for BigBlueButton — which supplies a backend plugin.
3. Create one or more **meeting types**, each bound to the backend you want.
4. Create **meetings** of those types. With the manual submodule you paste the join
   URL; with a provider backend the meeting is created on that platform through its
   plugin.
5. Reference or list meetings wherever you need them — remembering to treat join URLs
   as sensitive.
