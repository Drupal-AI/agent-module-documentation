# Inactive Autologout — manual setup guide

**Inactive Autologout** (`inactive_autologout`) automatically logs authenticated
users out after a configurable period of inactivity. Before the session actually
ends, it shows a countdown warning modal so the user has a chance to stay signed
in by moving the mouse or pressing a key. It is a lightweight way to satisfy the
common security requirement that unattended, logged-in sessions must time out —
for admin workstations, kiosks, or back-office screens showing sensitive data.

The module is driven by a single settings form and a small JavaScript library.
When enabled, it loads that library only for authenticated users (anonymous
visitors are never affected), tracks real activity with lightweight background
pings, and when the idle time is reached it ends the session and redirects to the
login page. The warning modal's title and text are fully customizable, including
a placeholder for the live countdown number.

You can set one idle timeout for everyone, or turn on **role-based timeouts** to
give different roles different limits — for example a very short timeout for a
"kiosk" role while editors get longer. The minimum allowed timeout is 120
seconds. The module has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn it on, set the idle timeout,
   customize the warning modal, and configure per-role timeouts.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Autologout settings**
(`/admin/config/people/autologoutsettings`). It is gated by the **Administer
inactive autologout** permission (`administer inactiveautologout`), so grant that
to the roles that should manage the policy.
