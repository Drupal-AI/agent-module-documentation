# CiviCRM Autologout Bridge — manual setup guide

**CiviCRM Autologout Bridge** (`civicrm_autologout_bridge`) fixes a specific,
annoying problem: users getting logged out while they are actively working in
CiviCRM. If you run the [Automated Logout](https://www.drupal.org/project/autologout)
module alongside CiviCRM, you may have seen this. CiviCRM's interface is heavily
AJAX-driven — opening popups, submitting inline edits, navigating menus, running
searches — and much of that never triggers a full Drupal page request. Automated
Logout doesn't see the activity, counts the user as idle, and ends the session
mid-task.

This module bridges the gap. It attaches a small piece of JavaScript to CiviCRM
pages (for authenticated users only) that detects the three kinds of activity
Automated Logout can't catch on its own — CiviCRM AJAX navigation, scrolling, and
touch input — and reports each one as activity, keeping the session alive for as
long as the person is genuinely working. Signals are debounced (throttled to about
once every five seconds by default) so the keep-alive doesn't flood the server.

The best part is there is **nothing to configure**. There is no settings page, no
permissions to assign, and no content types or fields added. Enable it alongside
Automated Logout and CiviCRM and it works automatically. It does not change your
logout timeout or any other behaviour — that stays governed by the Automated Logout
module's own settings, which remain the right place to tune session length. On
non-CiviCRM pages, standard autologout behaviour is unchanged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it needs Automated Logout and CiviCRM).

## Where it lives in the admin menu

Nowhere — the module has no admin page, no permissions, and no configuration. To
adjust session timeout, warning dialogs, or the logout redirect, use the **Automated
Logout** module's own settings; this bridge only feeds extra activity signals into
that existing mechanism.
