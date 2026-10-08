# Request Data Conditions — manual setup guide

**Request Data Conditions** (`request_data_conditions`) adds a set of **condition
plugins** that test the incoming HTTP request. Drupal's condition system is what
drives block visibility (and is reused by modules like Context and Page Manager),
and core ships the obvious conditions — request path, content type, user role,
language. What core does *not* offer is a way to say "show this block when the
`campaign` query parameter is present," or "when this cookie is set," or "when a
session flag was set earlier in a flow." This module fills that gap.

It provides four conditions, all based on request data:

- **Cookie** — match on a named cookie.
- **HTTP header** — match on a named request header.
- **Query parameters** — match on a URL query parameter (e.g. `?param=something`).
- **Session data** — match on a named session variable.

Every one of the four offers the same three fields: the **name** (of the cookie,
parameter, header, or session variable), an **operator** (must equal, regular
expression, and so on), and the **value** to match against. Because these are
ordinary condition plugins, they work anywhere Drupal's condition system is
consumed — block visibility most obviously, but also
[Context](https://www.drupal.org/project/context), Page Manager, and custom code.

The module has no dependencies, no routes, no permissions, and no configuration
page. It supports core `^9.3 || ^10 || ^11`. (The current release is a beta.)

> **Two cautions worth keeping in mind:**
>
> 1. **Never use these for access control.** Cookies, headers, query parameters,
>    and (to a lesser degree) session values are all client-influenced. They
>    decide what is *shown*, not what a user is *allowed* to see. Anything
>    sensitive needs a real access check.
> 2. **Check cache behaviour for anonymous traffic.** A condition that varies on
>    request data must contribute the matching cache context, or the internal page
>    cache can serve one visitor's variant to the next. Verify under page cache,
>    not only while logged in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the conditions appear wherever Drupal's
condition system is used, as described below.

## How to use it

The most common use is block visibility:

1. Go to **Structure → Block layout** and place (or configure) a block.
2. In the block's configuration, open the **visibility** settings. Alongside the
   core conditions you'll now see **Cookie**, **HTTP header**, **Query
   parameters**, and **Session** conditions.
3. Pick the condition you need and fill in its three fields — the **name**, an
   **operator** (e.g. must equal, regular expression), and the **value** to match.
4. Save the block. Its visibility now depends on the request data you specified.

The same conditions are available anywhere else conditions are consumed, such as
Context reactions.
