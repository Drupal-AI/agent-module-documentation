# Commit History — manual setup guide

**Commit History** (`commit_history`) adds an admin page that lists the **commit
history** of your site's code repository, so operators can see recent code and
deployment changes without leaving Drupal. It integrates the
`Spiriitlabs/commit-history` library to fetch commits from a **GitLab** or
**GitHub** repository and displays them on a report page, filterable by year.

The problem it solves: it gives site owners and operations staff an in‑admin view
of what has been committed and deployed, rather than making them switch to the
Git host. You point it at a repository and provide an access token, and the
history page renders the commit list.

It has no other module dependencies. It does **not** show anything useful until
you configure the repository connection. Access is controlled by two permissions:
**view commit history** (who can see the report) and **administer commit history**
(who can configure the connection). Tokens are stored in **Drupal state** and are
never exported to configuration — and an existing token is preserved when you save
the form with the password field left empty.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your GitLab/GitHub
   repository and set who can view the report.

## Where it lives in the admin menu

- The **settings/connection** form is at **Configuration → Web services → Commit
  history** (`/admin/config/services/commit-history`).
- The **history report** is at **Reports → Commit history**
  (`/admin/reports/commit-history`).

See [Configuration](configuration/index.md) for the walkthrough.
