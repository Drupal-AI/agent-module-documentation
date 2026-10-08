# Personal Notes Widget — manual setup guide

**Personal Notes Widget** (`pnw`) gives every logged-in user a lightweight,
private notes-and-to-do panel that floats over the page. A floating action button
is available across the interface; clicking it opens a responsive modal where a
user can quickly capture and manage personal reminders without leaving what they
were doing.

Inside the modal a user can create short personal notes (up to 256 characters),
browse their existing notes with pagination, and delete notes instantly — all via
smooth AJAX interactions, with no page reloads. Notes are stored **per user and
kept private**: each person only ever sees and manages their own list, and access
is scoped securely to the owner.

It is designed for dashboards, admin panels and internal portals where users want
a quick, personal note-taking utility on hand. The widget is framework-independent
(no Bootstrap or other external UI dependency) and built with an accessible modal —
keyboard navigation, focus management and ARIA-compliant behavior.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — no additional configuration is required. Once
enabled, the widget is automatically available to authenticated users.

## Where it lives in the admin menu

The module adds no admin settings page. The widget appears as a floating action
button in the interface for any logged-in user; access is limited to authenticated
users by default and every note is scoped to its owner.

## A note on security coverage

This module is **not covered by Drupal's security advisory policy**
(`security_advisory_coverage: not-covered`). Weigh that before deploying it on a
site with sensitive data or strict security requirements.
