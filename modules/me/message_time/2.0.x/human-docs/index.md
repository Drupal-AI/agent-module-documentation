# Message Time — manual setup guide

**Message Time** (`message_time`) controls **how long Drupal's status messages stay
on screen**. By default the green "saved", yellow warning and red error messages sit
at the top of the page until the user dismisses them or navigates away. Message Time
lets you give them a time delay so they auto-dismiss after a set number of seconds,
keeping the interface tidy without the user having to close each message.

The idea is simple and the setup is light. There are no other module dependencies and
no external libraries — it works across a wide range of Drupal versions (8 through
11). Once enabled you set the display duration on a single settings form, and status
messages then fade out after that interval.

It is a presentation aid only: it changes *how long* messages show, not *which*
messages show or *what* they say. It has no content or access-control role. Bear in
mind that auto-dismissing messages can hide information a user hasn't finished
reading, so pick a duration that gives people enough time to read important errors and
confirmations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set how long messages stay visible.

## Where it lives in the admin menu

Its settings form sits at **Configuration → User interface → Message Time**
(`/admin/config/user-interface/message-time`), reached via the
`message_time.settings_form` route.
