# Session Limit — manual setup guide

**Session Limit** (`session_limit`) caps how many active sessions a single user
account may have at the same time. It is a straightforward defence against password
sharing and a way to reduce the damage a stolen login can do: if an account is only
allowed one session, a second person logging in with the same credentials can't
quietly ride along.

You decide what happens when a user goes over their limit. There are three
behaviours: **ask** the user which existing session to end (the default, via a
`/session-limit` page), **drop the oldest** session automatically, or **prevent the
new login** and drop the newcomer back to anonymous. The limit itself is one active
session by default, but you can raise it site‑wide and set higher (or unlimited)
limits per role — useful for staff who legitimately work across several devices.

The module enforces the cap on every request by counting the user's rows in
Drupal's sessions table. HTTP and HTTPS sessions for the same user are counted as
one. By default the super‑admin (user 1) and anonymous users are never checked, and
you can optionally include user 1 for high‑security sites, ignore masqueraded
sessions, and log every enforcement event to the log for auditing. Developers can
fine‑tune enforcement through events (bypass the check, react to a collision, or
customise/prevent a disconnect).

Everything is configured from one settings page under **People**, and the settings
export cleanly as configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the default and per‑role limits,
   choose what happens when the limit is exceeded, and tune the message and other
   options.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Session limit settings**
(`/admin/config/people/session-limit`).
