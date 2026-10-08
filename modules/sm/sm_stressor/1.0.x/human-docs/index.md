# SM Stressor — manual setup guide

**SM Stressor** (`sm_stressor`) is a load- and stress-testing tool for Symfony
Messenger. It dispatches bursts of test messages through the `sm` message bus so
you can benchmark throughput and latency and observe how your workers behave
under heavy load — before that load arrives from real traffic.

The problem it solves is capacity planning and confidence: async processing that
looks fine at low volume can fall over under a flood of messages, and Stressor
lets you generate that flood deliberately and measure the result. Pair it with
the Metrics and Monitor modules to watch the numbers while it runs.

A word of caution from the maintainer: this is **designed for use in
production**, not just development (the author deliberately avoided calling it a
"test" module), but pushing real infrastructure hard can cause user-initiated
breaks in that infrastructure. Run it knowingly and be ready for the load you
generate to affect the live system.

It depends on **Symfony Messenger** (`sm`) and **Message Scheduler**
(`sm_scheduler`), works on **Drupal 10.6+ and 11.3**, and provides its own
permissions. Note it is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, use SM Stressor to dispatch bursts of test messages onto the `sm`
message bus and watch how the system copes. Observe throughput, latency, and
worker behaviour under the generated load — ideally with the Symfony Messenger
Metrics and Monitor modules open so you can see the effect in real time. Because
it can genuinely stress live infrastructure, start with modest loads and scale up
carefully.
