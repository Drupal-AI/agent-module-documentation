<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build environments & jobs

## Build hook environment (core module)
Add at `/admin/config/services/build-trigger/environments/add/build_hook`:
- **Build hook URL** (required) — the deploy webhook to call.
- **Build hook HTTP method** — GET/POST/PUT/PATCH/DELETE (default POST).
Triggering sends one HTTP request; because a plain hook returns no status, a successful trigger marks the job STATUS_SUCCESS.

## GitLab pipeline environment (submodule build_trigger_gitlab_pipeline)
1. Enable the submodule.
2. Set token + URL at `/admin/config/services/build-trigger/environments/gitlab-pipeline` (`administer build_environment`) → config `build_trigger_gitlab_pipeline.settings` keys `gitlab_api_token`, `gitlab_url`. The service builds `{gitlab_url}/api/v4`.
3. Add a `gitlab_pipeline` environment (project id, ref, variables).
The `GitlabApi` service (createPipeline/getPipeline/getPipelineJobs/getJob/getJobLog) sends `PRIVATE-TOKEN: {token}` headers.

## Triggering & monitoring
- Trigger: `/admin/builds/build` or `/admin/builds/build/new/{build_environment}`.
- List jobs: `/admin/builds` (`build trigger build`).
- Update one: `/admin/builds/{build_job}/update`; update all active: `/admin/builds/update`; API: `/api/build-job/update/{build_job}`.

## Extending
Implement a `@BuildEnvironment` plugin (extend `BuildEnvironmentPluginBase`, define `triggerBuild()` / `updateBuild()` and a config form) to support another CI provider.
