# Configuration

Build environments live at
`/admin/config/services/build-trigger/environments` (permission
`administer build_environment`). You add one environment per place you want to
build, then trigger and monitor builds from the Builds section at `/admin/builds`.

## Add a build-hook environment

For a deploy webhook (Netlify, Vercel, and similar):

1. Go to
   `/admin/config/services/build-trigger/environments/add/build_hook`.
2. Enter the **Build hook URL** (required) — the deploy webhook to call.
3. Choose the **HTTP method** — GET, POST, PUT, PATCH or DELETE (default POST).

Triggering sends one HTTP request. Because a plain hook returns no status, a
successful trigger simply marks the job as succeeded.

## Add a GitLab pipeline environment (submodule)

If you enabled `build_trigger_gitlab_pipeline`:

1. Set the token and URL at
   `/admin/config/services/build-trigger/environments/gitlab-pipeline`
   (permission `administer build_environment`). The service builds its API base
   as `{gitlab_url}/api/v4` and sends the token as a `PRIVATE-TOKEN` header over
   the URL you configure.
2. Add a **gitlab_pipeline** environment, giving the project id, the ref to
   build, and any CI variables to pass.

### Handling the GitLab token safely

The token and URL are stored in the submodule's configuration
(`build_trigger_gitlab_pipeline.settings`, keys `gitlab_api_token` and
`gitlab_url`). That is plain config, so:

- Keep it out of configuration you commit to public version control.
- On DDEV, hold the token in an environment variable
  (`ddev dotenv set .ddev/.env --gitlab-api-token=<value>` then `ddev restart`,
  never committing `.ddev/.env`) and feed it into the config via a settings.php
  override using `getenv('GITLAB_API_TOKEN')`, so the live token never lands in
  exported config.
- Use a token scoped to just what pipeline creation needs.

## Trigger and monitor builds

- **Trigger a build:** `/admin/builds/build`, or per environment at
  `/admin/builds/build/new/{build_environment}`.
- **List jobs and statuses:** `/admin/builds` (permission `build trigger build`).
- **Update one job:** `/admin/builds/{build_job}/update`; **update all active
  jobs:** `/admin/builds/update`.
- **Programmatic update endpoint:** `/api/build-job/update/{build_job}` — also
  gated by `build trigger build`, so there is no anonymous access.

For GitLab environments the module can poll the pipeline after triggering it,
fetch the pipeline's jobs, and show a job's trace/log.

## Extending to another CI provider

Developers can add support for another provider by implementing a
`@BuildEnvironment` plugin — see
[../agent/configure/environments.md](../agent/configure/environments.md).
