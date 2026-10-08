# Content Patch GitLab API — manual setup guide

**Content Patch GitLab API** (`content_patch_gitlab_api`) lets editors and
administrators export selected content entities — Nodes, Media, Taxonomy Terms —
straight from a Drupal site into a GitLab repository as a **Merge Request**,
without touching the Git command line. It serialises the chosen content to YAML
and pushes it via GitLab's REST API, so content changes can be captured as patches
in version control for review and deployment.

The problem it solves: Drupal 11's Site Templates support a full site export
(`drush site:export`), but that's often "all or nothing". This module fills the
gap by letting non-technical editors build high-quality demo or starter content on
a staging environment and contribute just that content back to the technical
site-template repository as a reviewable MR. It automatically tracks
dependencies, pulling in referenced entities such as Media, Taxonomy Terms, and
(on Drupal CMS) Canvas Pages, so the exported content is structured to drop into
Drupal's Site Template workflow.

You export content from the standard content overview (`/admin/content`) using
the per-row **Export to GitLab** operation, after configuring the GitLab
connection once. It depends on core's **Serialization** module and supports
Drupal 10.5+ and 11.2+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This is an early release (1.0.0-alpha4) and the project is not covered
> by Drupal's security advisory policy. It reads a GitLab access token from
> `settings.php` — see [Configuration](configuration/index.md) for exactly where
> to put it.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your GitLab repository,
   store the API token securely, and grant the export permission.

## Where it lives in the admin menu

There's a settings page (**Configuration → Web services → Content Patch GitLab
API Settings**) where you configure the target GitLab URL, project ID, export
path and default branch (the API token lives in `settings.php`, not on this
form), plus permissions that control which roles may trigger exports. The export
action itself is run from the content overview (`/admin/content`) via the
per-row **Export to GitLab** operation on a node, media item, or taxonomy term.

## How to use it

1. Configure the GitLab connection and token, and grant the export permission —
   see [Configuration](configuration/index.md).
2. Go to **Content** (`/admin/content`) (or the media / taxonomy-term listing).
3. On the row for the item you want to export, open the operations dropdown and
   choose **Export to GitLab**.
4. On the export form, adjust the branch name, commit message, and merge-request
   title, then submit. The module serialises the selected content — plus its
   referenced entities such as media, files, and taxonomy terms — commits it to a
   new branch, and opens a Merge Request in your configured GitLab repository. A
   link to the created MR is shown on success.
5. Review and merge the MR in GitLab as you would any other change.
