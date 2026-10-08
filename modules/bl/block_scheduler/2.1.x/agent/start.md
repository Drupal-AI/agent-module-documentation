<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Scheduler (block_scheduler) — agent index

One core `Condition` plugin, **`expiry`**, that adds **Publish Date** + **Expiry Date** to any
block's Visibility section so the block shows only inside that time window. Version **2.1.0**
(dir `2.1.x`). Core `^10.3 || ^11`, PHP `>=8.1`. No dependencies, no cron, no permissions, no
admin settings page, no config schema, no services beyond the hook class.

## What it provides

- **Condition plugin `expiry`** (`src/Plugin/Condition/Expiry.php`, label "Expiry", provider
  `block_scheduler`) — two `datetime` fields, `start` (Publish Date) and `end` (Expiry Date),
  stored as Unix timestamps in the block's visibility configuration.
- **`hook_block_access()`** (`src/Hook/BlockSchedulerHooks.php::blockAccess`) — a second,
  independent enforcement layer that forbids the `view` op when the stored `expiry` config is
  outside the window.
- **`hook_help()`** — renders `README.md`; via contrib `markdown` module if installed, else `<pre>`.

There is no configure route, no `*.routing.yml`, no `*.permissions.yml`, no `config/schema`, no
`hook_cron`. All state lives inside the host block entity's visibility config.

Solution doc: [`configure/scheduling.md`](configure/scheduling.md) — how to set the dates, the
storage shape, evaluate/access/cache mechanics, and edge cases.

## Mechanism (quick)

- **Set dates:** block layout UI (`/admin/structure/block`) → any block → Visibility → **Expiry**
  tab; also available in Layout Builder block configuration. Both fields optional.
- **Visible when:** `time() >= start` (if set) **and** `time() <= end` (if set). Both blank ⇒ always
  shows (`evaluate()` returns TRUE when unconfigured and not negated).
- **Two enforcement paths run:** the condition's `evaluate()` (normal visibility) and
  `blockAccess()` (`AccessResult::forbiddenIf(...)`). `blockAccess` treats `end` as exclusive
  (`time() >= end` ⇒ forbidden); `evaluate()` treats it inclusive (`time() <= end`). Net effect is
  the same: hidden before start and after end.
- **Cache:** `Expiry::getCacheMaxAge()` returns seconds until the next boundary so pages re-render
  when a block is due to appear/disappear — no cron needed.

## Semantics to keep straight

1. **Presentation + block access, not entity access.** A scheduled-off block is not rendered and
   its `view` access is forbidden, but this governs the *block*, not access to any entity the block
   references. Do not use it to protect content.
2. **Timestamps, server timezone.** Dates are captured via `DrupalDateTime` and stored as epoch
   seconds; comparisons use `time()` / request time.
3. **Validation:** the form rejects an Expiry Date that is `<=` the Publish Date (both must be set
   for that check to fire).
