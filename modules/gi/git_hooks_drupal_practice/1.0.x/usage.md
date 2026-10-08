<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Git Hooks Drupal Practice scaffolds Git hooks that enforce Drupal coding standards (PHPCS) and Drupal Rector checks on staged files before each commit.
---
On install (via its `.install` logic) the module writes hook scripts into the project's `.git/hooks` directory. A pre-commit hook runs PHPCS using the Acquia strict Drupal coding standards and Drupal Rector against staged files, blocking commits that fail. A `commit-msg` hook enforces a message format that must begin with a ticket number (e.g. `ABC-123:`) and contain at least 10 characters after the colon.

The module is a local developer-workflow helper: it has no routes, permissions, services, or configuration UI, and it does not run on the live site's request path. It targets Drupal 10/11 and PHP 8.1, and assumes the relevant PHPCS/Rector tooling is available in the project (typically via Composer dev dependencies).

Typical setup: require the module in a development environment, enable it so the hooks are written, and commit as normal — the hooks now gate staged code and commit messages.
---
- Enforce Drupal coding standards on every commit locally.
- Run PHPCS (Acquia strict Drupal standards) on staged files pre-commit.
- Run Drupal Rector checks before committing.
- Require commit messages to start with a ticket number (e.g. `ABC-123:`).
- Reject commit messages shorter than 10 characters after the colon.
- Standardize code quality across a Drupal team.
- Catch standards violations before they reach CI.
- Auto-install hooks into `.git/hooks` without manual copying.
- Keep commit history traceable to issue trackers.
- Block malformed commit messages at author time.
- Pair with a Composer dev toolchain (phpcs, rector).
- Onboard new developers with consistent commit gates.
- Reduce review churn over formatting nits.
- Use in a DDEV/local dev environment only (not on production).
- Ensure staged-file checks rather than whole-repo scans.
- Complement CI pipelines with pre-commit enforcement.
- Adopt a ticket-prefixed commit convention team-wide.
- Prevent accidental commits of non-compliant code.
- Remove/disable the hooks by uninstalling the module.
- Practice Drupal contribution standards on personal projects.
