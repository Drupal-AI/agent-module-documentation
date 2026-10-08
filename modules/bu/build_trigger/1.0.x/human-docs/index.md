# Build trigger — manual setup guide

**Build trigger** (`build_trigger`) is a Drupal front-end to an external build
system. On a decoupled or static site, the front end is built elsewhere — Netlify,
Vercel, GitLab CI — and this module lets editors trigger a build of a configured
environment from inside Drupal and then check the resulting job's status (and,
where the provider supports it, view its log). It does not build anything itself;
it kicks off and monitors a build that runs somewhere else.

Two configuration entities model the workflow. A **build environment** describes
where and how to build, and a **build job** records one triggered build and its
status. Two environment types ship:

- **Build hook** — fires a single HTTP request (method + URL) at a deploy
  webhook, such as a Netlify or Vercel build hook.
- **GitLab pipeline** — provided by the `build_trigger_gitlab_pipeline`
  submodule, calls the GitLab API v4 to create a pipeline and poll its
  pipelines, jobs and logs, authenticating with a stored private token.

Every route is permission-gated, including the programmatic update endpoint at
`/api/build-job/update/{build_job}` — there is no anonymous way to trigger a
build. The GitLab token and URL are stored in the submodule's configuration; see
[Configuration](configuration/index.md) for how to keep the token out of
committed config. This release is **1.0.0-alpha1**.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the GitLab submodule if you need it.
2. [Configuration](configuration/index.md) — add build environments, trigger and
   monitor builds, and handle the GitLab token safely.

## Where it lives in the admin menu

- **Build environments:**
  `/admin/config/services/build-trigger/environments`
  (permission `administer build_environment`).
- **Build jobs:** `/admin/builds` — trigger and monitor builds here
  (permission `build trigger build`).
