# Git Hooks Drupal Practice — manual setup guide

**Git Hooks Drupal Practice** (`git_hooks_drupal_practice`) is a developer helper
that wires up **Git hooks** to keep code quality in check *before* a commit ever
leaves your machine. It sets up **PHPCS** (PHP CodeSniffer, for Drupal coding
standards) and **Drupal Rector** in your project, and installs a **pre‑commit
hook** that runs those checks against your staged files. If the staged code fails
the standards, the commit is stopped so you can fix it first.

It also installs a **commit‑msg hook** that enforces a commit‑message convention:
the message must start with a ticket number (for example `ABC-123:`) and have at
least ten characters of description after the colon. That keeps your history tidy
and traceable to tickets.

This is a workflow/tooling module, not a site‑facing feature. It requires no
configuration: enabling it creates the hook scripts in your project's
`.git/hooks` directory, and from then on the checks run automatically each time
you commit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form and
needs none. It works by placing hook scripts into `.git/hooks`.

## Where it lives in the admin menu

The module adds no admin page. Its effect is entirely on the command line and in
Git: after it runs, `.git/hooks` in your project root contains a **pre‑commit**
hook (runs PHPCS + Drupal Rector on staged files) and a **commit‑msg** hook
(checks the message format). You'll notice it the next time you `git commit` — a
commit that fails a check is rejected with an explanation.

> **Note:** Git hooks live in each clone's local `.git/hooks` directory and are
> not committed to the repository, so every developer who wants the checks needs
> the module enabled in their own working copy.
