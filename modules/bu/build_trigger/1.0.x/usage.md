<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Build trigger is a Drupal front-end to an external build system: it lets editors trigger a build of a configured environment and check the resulting job's status (and, where supported, view its log). It does not perform the build itself.

Two config entities model the workflow: a **build_environment** (a plugin-backed configuration of where/how to build) and a **build_job** (a record of one triggered build and its status). Two build-environment plugins ship: `build_hook` (fires a single HTTP request — method + URL — at a deploy webhook, e.g. Netlify/Vercel) and, via the `build_trigger_gitlab_pipeline` submodule, `gitlab_pipeline` (calls the GitLab API v4 to create a pipeline and poll pipelines/jobs/logs using a stored PRIVATE-TOKEN). Build jobs are listed at `/admin/builds`.

Environment administration lives under `/admin/config/services/build-trigger/environments` and requires `administer build_environment`; triggering and updating builds requires `build trigger build`; the `administer build_job` permission is restricted. An API-style update endpoint `/api/build-job/update/{build_job}` is also gated by `build trigger build` (no anonymous access). The GitLab token and URL are stored in `build_trigger_gitlab_pipeline.settings` config.
---
Configure build environments, then trigger and monitor builds from the Builds admin section or per-environment.
---
- Register a build environment that fires a deploy webhook (build hook)
- Choose the HTTP method (GET/POST/PUT/PATCH/DELETE) for a build hook
- Register a GitLab CI pipeline environment (submodule)
- Store a GitLab API token and base URL for pipeline calls
- Trigger a new build for an environment from `/admin/builds/build`
- Create a build job for a specific environment
- List all build jobs and their statuses at `/admin/builds`
- Update the status of a single build job
- Update all active build jobs at once
- Poll a GitLab pipeline's status after triggering it
- Fetch the jobs belonging to a triggered GitLab pipeline
- View the trace/log of a GitLab CI job
- Pass CI variables (ref + key/value vars) when creating a pipeline
- Edit or delete an existing build environment
- Grant editors the `build trigger build` permission to deploy without site-admin rights
- Call the update endpoint `/api/build-job/update/{build_job}` programmatically
- Extend with a custom BuildEnvironment plugin for another CI provider
- Export build-environment configuration between environments