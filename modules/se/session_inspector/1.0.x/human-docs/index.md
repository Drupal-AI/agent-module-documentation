# Session Inspector — manual setup guide

**Session Inspector** (`session_inspector`) gives your users the "active sessions /
sign out other devices" feature familiar from major online accounts. A user can see
a list of the sessions they currently have open — with contextual details about each
— and close down any they don't recognise, including the one they're using right
now. The goal is to let users manage their own sessions without an administrator
having to step in.

That is a real security win: after using a shared or public computer, or if they
suspect their account has been compromised, a user can end the stray sessions
themselves. Access is scoped tightly — by default a user sees only their *own*
sessions, controlled by a permission.

The module depends on core **User**. It works as soon as you enable it and grant the
right permission — a **Sessions** tab then appears on the user profile page. An
optional settings form lets you tune how session details are presented. Two optional
plugin modules can format the raw data more nicely: a **BrowserDetector** formatter
turns the user-agent string into a readable browser/OS name, and a **Geocoder**
formatter turns the hostname/IP into a location. Supports Drupal 9, 10 and 11.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the session-inspection permissions.
2. [Configuration](configuration/index.md) — the optional settings form and the two
   permissions, explained.

## Where it lives in the admin menu

The module's settings form lives under **Configuration** (route
`session_inspector.config`). The user-facing feature, however, appears on each
user's own profile: once the permission is granted, users see a **Sessions** tab on
their profile screen, reachable directly at `/user/[uid]/sessions`.

## How to use it

Grant the **inspect own users sessions** permission to the roles that should manage
their own sessions. Those users then open the **Sessions** tab on their profile,
review the listed sessions, and delete any they want to end. Grant the broader
**inspect other user sessions** permission only to trusted roles who genuinely need
to view other people's sessions — use it sparingly.
