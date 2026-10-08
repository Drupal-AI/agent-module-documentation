# Security Review — manual setup guide

**Security Review** (`security_review`) automates the tedious job of checking a Drupal
site for the configuration mistakes that most often lead to security problems. It runs
a checklist of around 20 checks — file permissions, whether PHP can execute from the
files directory, error reporting leaking details to the screen, dangerous permissions
granted to untrusted roles, trusted host settings, input formats, and more — and
reports each one as pass, fail, warning, or info.

You run the checklist from the admin UI, or headlessly with `drush secrev` so it can
gate a CI/CD pipeline (the command exits non-zero when a check fails). Results also
surface on the site's **Status report**, warning administrators when checks are failing
or have never been run. Because most checks only care whether a resource is reachable by
untrusted visitors, you tell the module which roles count as **untrusted** (anonymous
and authenticated, by default) and it evaluates the checklist from their point of view.

An important caveat: Security Review **raises awareness — it does not fix anything**. It
tells you what looks wrong; acting on the findings (tightening permissions, moving the
private files directory, and so on) is up to you. Checks you've reviewed and decided
don't apply can be individually **skipped** ("hushed") so they stop failing the run, and
some checks let you hush specific findings (a particular file, view, or upload
extension) without disabling the whole check.

The module is extensible — developers can add their own checks — and depends on no
contrib modules (just PHP 8.1+ and Symfony Filesystem, which Composer handles).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent — the SecurityCheck plugin type, the
services API, and the Drush command options — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant its permissions.
2. [Configuration](configuration/index.md) — run and review the checklist, mark
   untrusted roles, skip/hush checks, and use the `drush secrev` command.

## Where it lives in the admin menu

- **Run & review the checklist** — **Reports → Security Review**
  (`/admin/reports/security-review`).
- **Settings** (untrusted roles, logging, skipped checks) —
  **Configuration → Security → Security Review** (`/admin/config/security-review`).

Both pages require the **Access security review list** permission; running checks
requires **Run security checks**. Grant these to trusted roles only — the pages reveal
sensitive information about your site's security posture.
