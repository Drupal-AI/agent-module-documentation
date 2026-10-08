<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal.org is the site-specific module that powers the drupal.org website: it integrates the site with a GitLab instance, receives GitLab/legacy webhooks, manages issue forks and the security-advisory workflow, and drives Project Browser filter and JSON:API data endpoints.

---

This module bundles the bespoke behaviors drupal.org runs on top of Drupal core, JSON:API and JSON:API Views. It talks to a GitLab instance (`git.drupalcode.org` by default) through the `m4tthumphrey/php-gitlab-api` client to create issue forks, grant fork access, fetch project avatars, and run the security-team fork/advisory workflow. Three POST webhook endpoints under `/drupalorg-api/webhook/*` accept GitLab (and drupal.org legacy) events, verify a shared secret token, and queue the work into four queue workers. It also provides helper services for projects, users and organizations, custom node/field access hooks reflecting drupal.org's role model, a breadcrumb builder, blocks (documentation tree, sponsor widget, documentation issue submission), a Views published-status filter, dynamic "view any unpublished … content" permissions, two admin settings forms (GitLab + credit-migration tokens), and Drush commands for computing active installs, composer namespaces and core compatibility. It is published as contrib mainly for transparency and as an educational example; it is not intended to be generally reusable, and its permissions only make sense on a site replicating drupal.org's roles. Supports Drupal 9, 10 and 11; the optional `drupalorg_test_content` submodule ships default content for local installs.

---

- Integrate a Drupal site with a GitLab instance via a stored personal access token.
- Receive GitLab project (`repository_update`) webhooks and update project logos from GitLab avatars.
- Receive GitLab contribution webhooks (issues, merge requests, notes) and sync contribution records.
- Receive drupal.org legacy (Drupal 7) contribution webhooks via a separate credit-migration token.
- Receive GitLab security-issue webhooks and run the security-team triage workflow.
- Automatically move a reported security issue into a private per-project security fork.
- Add reporters and project maintainers to a private security fork and lock the original issue.
- Post templated advisory-drafting instructions on security issues when the "Security advisory::needed" label is added.
- Grant or remove security-fork access from `/access` and `/remove-access` commands posted by security-team members.
- Let contributors create an issue fork for a git.drupalcode.org issue from a management page.
- Let contributors request Developer access to an issue fork.
- Check whether the current user already has access to a given fork (JSON endpoint).
- Serve Project Browser filter UUIDs and Drupal-version support checks at `/drupalorg-api/project-browser-filters`.
- Renew (rotate) the GitLab personal access token automatically on cron before it expires.
- Warn in the status report when the GitLab token is near or past expiry.
- Provide project/user/organization lookup services (by machine name, composer namespace, git username, repository path).
- Enforce drupal.org's node create/update/delete and field-level access rules (projects, security advisories, user profile fields).
- Restrict which content types can be viewed/created on the new site, redirecting others to www.drupal.org.
- Build custom breadcrumbs for documentation, guides, case studies and contribution records.
- Render a documentation tree block, sponsor widget block and documentation-issue-submission block on doc pages.
- Boost search results by active-install count via a Search API OpenSearch query subscriber.
- Provide a Views "published status (Drupal.org)" filter that honors per-type "view any unpublished" permissions.
- Expose dynamic `view any unpublished <type> content` permissions for every node type.
- Compute per-project active installs, composer namespaces and core compatibility ranges via Drush/cron.
- Load default test content locally with the `drupalorg_test_content` submodule.
