# Request Parameter Condition — manual setup guide

**Request Parameter Condition** (`request_parameter_condition`) provides a
**condition plugin** that evaluates the **query parameters** of the current
request. That lets block visibility — and anything else built on Drupal's
condition system — depend on whether a URL query parameter is present or holds a
particular value. For example, you can show a block only when a page has a
`?search=` parameter, or only when it does *not*.

The motivation is a common limitation: tools like Views, Search API, and Facets
all read request parameters to do their work, but that handling is locked inside
each tool. If you want to conditionally render your *own* logic based on a query
parameter — the classic case being a block shown or hidden via
[Block Visibility Groups](https://www.drupal.org/project/block_visibility_groups)
— core has no built-in condition for it. This module supplies exactly that
condition. It sits in the *Conditions* package, needs no other modules, and
supports core `^10.5 || ^11`.

> **Query parameters are user-controlled — never use this as a security gate.**
> Anyone can add any query parameter to a URL, so this condition decides what is
> *shown*, not what a user is *allowed* to see. It must never be the sole control
> protecting sensitive blocks or content; anything sensitive needs a real access
> check. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the condition appears wherever Drupal's
condition system is used, as described below.

## How to use it

The condition is used like any other Drupal condition, most commonly on blocks:

1. Go to **Structure → Block layout** and place or edit a block (or use
   **Block Visibility Groups** if you have it installed).
2. Open the block's **visibility** settings. Alongside the core conditions you'll
   now find the **request parameter** condition.
3. Configure it — name the query parameter to check and the value/behaviour to
   match against (for example, show the block only when `campaign=summer` is
   present).
4. Save. The block's visibility now depends on the request's query parameters.

Because it is an ordinary condition plugin, it is also available anywhere else
Drupal conditions are consumed.
