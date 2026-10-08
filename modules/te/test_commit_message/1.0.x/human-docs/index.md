# Test Commit Message — manual setup guide

**Test Commit Message** (`test_commit_message`) is a **testing fixture module** —
it is not something you install on a real website. Its whole reason for existing
is to contain intentionally deprecated Drupal 10/11 API calls so that
[drupal‑rector](https://www.drupal.org/project/rector) can generate patches
against it during automated testing, and so the project‑update bot's commit
messages and GitLab issue posting can be exercised end to end.

It provides **no site functionality whatsoever**. Its `.module` file deliberately
uses APIs that Drupal has deprecated — for example the `REQUEST_TIME` constant,
`watchdog_exception()`, `check_markup()`, `filter_formats()` /
`filter_fallback_format()`, and `system_region_list()` /
`system_default_region()` — each one chosen to map to the specific rector rule
expected to rewrite it. In other words, it is a controlled reproduction: a small,
stable target you can run rector against to verify the generated patches, commit
messages, and bot output.

Because it contains deliberately outdated code, **do not enable it on a production
site**. Treat it as a CI/testing artifact. It depends on core **Filter** and
**System**, supports **Drupal 10 and 11**, provides no permissions or routes, and
ships no submodules. (It is not covered by Drupal's security advisory policy — as
expected for a testing fixture.)

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — how to pull it in as a rector/CI target
   (and why not to enable it in production).

## How to use it

This module is used as a **target**, not enabled as a feature. The workflow is:

1. Add it to a test/CI environment where you are exercising drupal‑rector.
2. Run rector's `project_analysis` flow against it. Because its code uses known
   deprecated APIs, rector will detect them and generate patches.
3. Verify the results — the generated patches, the commit messages, and (if you are
   testing the bot) the GitLab issue/merge‑request output.

It is handy as a reference too: the deliberately deprecated calls show what
each deprecation looks like in code and which rector rule is expected to fix it.
