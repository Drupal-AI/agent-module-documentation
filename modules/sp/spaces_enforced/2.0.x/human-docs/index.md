# Spaces Enforced! — manual setup guide

**Spaces Enforced!** (`spaces_enforced`) is a small anti-spam module built on a
simple observation: spammers almost never put a space in their usernames. So it
requires new usernames to contain a space, which quietly blocks the common
spam-bot pattern of run-together, single-word names and cuts down on junk
registrations — without a CAPTCHA or anything a genuine user has to solve.

By default the rule is straightforward: one-word usernames are rejected, so a new
account must include a space. Newer releases add flexibility — you can specify
your own required character (not just a space) and how many times that character
must occur in the username — letting you tune the heuristic to your site. It has
no other module dependencies and provides its own permission.

This is a **spam-prevention** heuristic, not a complete access-control or
anti-abuse solution; treat it as one cheap layer among others (such as honeypot,
CAPTCHA or approval workflows). It shapes what usernames are *allowed*, and takes
effect on user registration once enabled.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing you must configure to get the basic behaviour: once enabled, the
registration form rejects usernames that do not contain a space. If you want to
change the required character or how many times it must appear, adjust the
module's rule to suit your needs. After enabling, register a test account with a
single-word name to confirm it is refused.
