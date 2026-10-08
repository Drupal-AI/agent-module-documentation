# Configuration

Setting up Build Hooks is three steps: choose which content is tracked, create
one or more deploy targets, and understand the deploy flow.

## 1. Choose which content is "loggable"

Open **Configuration → Build hooks → Settings**
(`/admin/config/build_hooks/settings`); you need the **Administer site
configuration** permission. Here you pick the **entity types** whose changes are
recorded into deployments and counted in the toolbar. Out of the box only **node**
is tracked.

Restrict this to the entity types that actually appear on your front end — for
example `node` and `media`. Changes to anything not on this list are ignored by
the changelog and the toolbar counter. Settings are stored in
`build_hooks.settings`.

## 2. Create frontend environments (your deploy targets)

Open **Configuration → Build hooks → Frontend environments**
(`/admin/config/build_hooks/frontend_environment`); you need the **Manage
frontend environments** permission. Click **Add**, choose a plugin type, then fill
in the environment:

- **Label** — a human name such as *Production (Gatsby)*.
- **Plugin fields** — depend on the plugin. For the **generic** plugin, this is a
  single **Build hook URL** that will be POSTed to. Provider submodules add their
  own fields (and credentials).
- **Deployment strategy** — see below.

You can create several environments (production, staging, preview), each with its
own build hook and strategy. Environments are configuration entities, so they can
be exported and deployed between sites.

> **Keep build‑hook URLs and tokens secret.** They act as credentials — anyone
> with the URL can trigger a deploy. Be mindful that they are stored in
> configuration.

## 3. Deployment strategy — when a deploy fires

Each environment has a **deployment strategy**:

- **Manual** — the deploy only happens when a user presses the deploy button on
  the deployment form. Best for production.
- **Cron** — every environment with this strategy is fired on each cron run.
  Good for scheduled/batched rebuilds.
- **On entity save** — every environment with this strategy fires immediately
  whenever a *loggable* entity is created, updated, or deleted. Good for a
  preview environment that should rebuild on every draft save.

A common pattern is a **manual** production environment plus an **on entity
save** preview environment.

## 4. The deploy flow

Once configured, editors see a **toolbar item per environment** with a counter of
how many changes are waiting. Clicking it opens the **deployment form**
(`/admin/build_hooks/deployments/{environment}`, gated by the **Trigger
deployments** permission), which shows:

- the **changelog** — the content created, updated, or deleted since the last
  deploy;
- any extra fields a provider plugin adds (for example, Netlify's recent‑builds
  list);
- a **deploy** button.

Pressing deploy fires the outbound request to your host. On success, the current
changelog is closed and a fresh (empty) one starts, and the toolbar counter
resets.

### Triggering a deploy without the UI

You can also fire a deploy from Drush, which is handy for scripting:

```bash
drush php:eval '\Drupal::service("build_hooks.trigger")->triggerBuildHookForEnvironment(
  \Drupal::entityTypeManager()->getStorage("frontend_environment")->load("prod"));'
```

(Replace `prod` with your environment's machine name.) Note the module ships **no
dedicated Drush commands** — use the service call above, or `drush cron` for the
cron strategy. If a deploy seems to do nothing, check the logs (`dblog`): the
trigger reports failures as warnings/errors rather than throwing.

## Provider credentials

When you use a provider submodule, its credential is usually stored on the
provider's **own settings form** (a separate config object), not on the
environment entity — the exception is CircleCI v2, which stores its token on the
environment. See each submodule's own documentation for where to enter the
credential.
