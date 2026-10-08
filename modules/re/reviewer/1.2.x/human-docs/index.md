# Reviewer — manual setup guide

**Reviewer** (`reviewer`) automates reviews of your Drupal **configuration**. It
provides plugins that check your site's config against expectations and
best practices, so a developer can catch build issues quickly instead of clicking
through configuration forms by hand. Think of it as an automated checklist for how
your site is configured.

Reviews are run from **Drush**, or browsed in the admin UI when you enable the
optional **Reviewer UI** submodule. Each review reports failures, errors, and (on
request) passed, ignored, or not-run checks, and you can interactively mark
findings as "ignored" so future runs focus on what is new.

This is a developer/administration tool. Its reports can reveal configuration
detail, so keep access to developers and administrators, and note that Reviewer
itself has no access-control role beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.

There is **no site-wide settings form** for this module. You run reviews from
Drush or view them at the report page, described in "How to use it" below. Creating
your own reviews is a developer task documented in the module's `README.md`.

## Where it lives in the admin menu

When the **Reviewer UI** submodule (`reviewer_ui`) is enabled, review results are
shown at **Reports → Reviewer** (`/admin/reports/reviewer`). Without that
submodule, Reviewer is Drush-only.

## How to use it

Reviewer's main interface is Drush:

```bash
drush reviewer:list          # list all available reviews
drush reviewer:run           # run reviews
```

You can target specific reviews by ID, and — for reviews that support bundles —
specific bundles:

```bash
drush reviewer:run test_node test_taxonomy    # run just these two reviews
drush reviewer:run test_node:test_fail        # run "Test Node" on the test_fail bundle only
```

Useful options include `--review` and `--review-new` (interactively prompt to
ignore failures, or only *new* failures), `--review-reset` (forget previously
ignored items and start over), and display toggles such as `--show-passed`,
`--show-not-run`, `--show-ignored`, and `--show-all`. Add `--help` to any command
to see all options.

> **Tip:** To try Reviewer out with sample content and reviews, enable the
> `reviewer_test` submodule, which installs test content and example reviews.
