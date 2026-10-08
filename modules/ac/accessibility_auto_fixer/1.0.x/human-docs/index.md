# Accessibility Auto Fixer — manual setup guide

**Accessibility Auto Fixer** (`accessibility_auto_fixer`) is an in-Drupal
accessibility scanner. It walks your node content, checks it against WCAG rules,
and presents the findings in an admin **dashboard** — so an editorial or QA team
can run a repeatable accessibility audit inside Drupal instead of reaching for an
external tool.

The scanner flags common issues such as **missing image alt text**, **heading
order** problems, contrast hints and **ARIA gaps**. It can **batch-scan** many
nodes at once, and it offers a CI-friendly mode so the same checks can run in a
build pipeline. From the dashboard, a team can review findings per node, track
accessibility over time, and prioritise remediation.

Two permissions gate the module. **Access accessibility reports** lets a user view
the findings — grant it to your editors and QA. **Administer accessibility
settings** lets a user configure the scanner — grant it only to trusted roles. The
scanner reads content that the running user can see, so treat its report pages as
authenticated admin UI, not something to expose publicly.

One honest note on scope: a scanner surfaces problems, but fixing them still means
editing content and templates — real accessibility comes from semantic markup,
keyboard operability and a design with adequate contrast. Use this to *find and
track* issues as part of an editorial workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. (The agent docs for this module are
brief — this guide reflects what they describe.)

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Once enabled, the module adds a report/dashboard area reachable by users with the
**Access accessibility reports** permission, and a settings area for users with
**Administer accessibility settings**. Grant the two permissions at
**People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Grant **Access accessibility reports** to editors/QA and **Administer
   accessibility settings** to trusted admins.
2. Run a scan — the module can batch-scan across many nodes at once, and also run
   in a CI pipeline.
3. Review the findings in the dashboard: missing alt text, heading-order issues,
   ARIA gaps and contrast hints, per node.
4. Prioritise and work through remediation, re-scanning to track progress over
   time.
