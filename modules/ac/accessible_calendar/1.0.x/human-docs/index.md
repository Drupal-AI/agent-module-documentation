# Accessible Calendar — manual setup guide

**Accessible Calendar** (`accessible_calendar`) provides accessible **month** and
**week** calendar displays. It renders your date-based content as calendars that
are built for keyboard and screen-reader users — with proper ARIA markup and focus
management — so a calendar view is usable by everyone, not only sighted mouse users.

The calendar content comes from Drupal's core **Views** module, which the calendar
depends on. Because the content is sourced through Views, it respects the normal
access controls on that content; the module itself does not grant or restrict
access to anything. It is a content-display and accessibility feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Views is required).

## How to use it

Accessible Calendar plugs into Views. After enabling it, build or edit a View of
your date/event content and use the calendar display the module provides to render
that content as an accessible month or week calendar. Because the calendar draws
from a View, you control which content appears, how it is filtered, and who can see
it through the View itself.
