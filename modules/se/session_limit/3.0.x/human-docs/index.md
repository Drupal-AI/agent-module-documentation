# Session Limit — manual setup guide

**Session Limit** (`session_limit`) lets you cap how many browsers or devices a
single user account can be logged in from at the same time. By default Drupal
creates a new session for every browser a user signs in with, so one account can
be active in many places at once. Session Limit puts a ceiling on that: once a
user exceeds the configured maximum, the module steps in.

It's most useful for curbing account sharing and enforcing "one login at a time"
policies. If the limit is 1, for example, a user logged in at work who then logs
in from home is forced either to end the work session or to abandon the new
login — you choose which behavior applies. No extra database tables are needed;
the maximum and its exceptions are all configuration.

The module works as soon as you configure it — there is nothing to set up beyond
enabling it and choosing a limit. You can set a site-wide default, override it per
role, exclude specific users, and pick what happens on a collision (prompt the
user to choose a session to end, silently drop the oldest session, or block the
new login). It has **no dependencies** and integrates with Token, Rules, and
Masquerade.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the maximum, per-role
   exceptions, and the collision behavior.

## Where it lives in the admin menu

Session Limit's settings form sits under **Configuration → People → Session
limit** (`/admin/config/people/session-limit`, route
`session_limit.config_form`). It is gated by the core **Administer site
configuration** permission — the module defines no permissions of its own.

There is also a small front-end page at `/session-limit` (route
`session_limit.limit_form`) that the "ask the user" behavior redirects to when a
user must choose which existing session to end.
