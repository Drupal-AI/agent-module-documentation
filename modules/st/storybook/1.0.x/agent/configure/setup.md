<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup, render route, permission, dev mode

No admin settings page (`configure: null`). "Configuration" is code/services + one permission.

## Render endpoint

- Route `storybook.render_story` → **`/storybook/stories/render/{hash}`**
  (`ServerController::renderStory`).
- Access: `_custom_access` = `ServerController::access`, which requires the permission
  **`render storybook stories`**. Storybook fetches this URL to get each story's real
  Drupal-rendered markup.

## Permission

`render storybook stories` (`storybook.permissions.yml`, `restrict access: true`). The
external Storybook app is anonymous, so in **local/dev** you grant it to the anonymous role:

```bash
drush role:perm:add anonymous 'render storybook stories'
# revoke again when done / never enable in production:
drush role:perm:remove anonymous 'render storybook stories'
```

Keep this permission disabled in production.

## Development mode — `storybook.development`

Container parameter (default `FALSE`, in `storybook.services.yml`). When TRUE, the module's
decorators disable page cache, render cache, and asset optimization on the render route so you
see fresh output. Set it in `development.services.yml` (a dev-only file), together with CORS:

```yaml
parameters:
  storybook.development: true
  cors.config:
    enabled: true
    allowedHeaders: ['*']
    allowedMethods: ['*']
    allowedOrigins: ['*']
    supportsCredentials: true
```

Also recommended in dev (state flags, per README):

```bash
drush state:set twig_debug 1
drush state:set twig_cache_disable 1
drush state:set disable_rendered_output_cache_bins 1
```

## Supporting services (automatic, no config)

`storybook.services.yml` wires: a **theme negotiator** (renders stories in your front-end
theme via `?_drupalTheme=`), an **outbound path processor** + decorated **file URL generator**
(force absolute URLs so the iframe loads assets), a **page-cache request policy**, and
decorated **cache.data** / **asset.resolver** — the last three keyed off
`storybook.development`.

## External requirement (the Storybook app)

To actually browse components you run the **Storybook (npm/Node) application** outside Drupal:

```bash
npm init -y                 # if no package.json yet
npx storybook init --type server
# then run it (use --no-open under DDEV):
yarn storybook
```

Point Storybook at your compiled `*.stories.json` (see
[../drush/commands.md](../drush/commands.md)) and enable CORS on Drupal (above). This Node
server is an external dependency; nothing inside Drupal starts it.
