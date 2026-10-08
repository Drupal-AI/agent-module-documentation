# Configuration

Storybook has no admin settings page. "Configuration" here means a permission, a
development‑mode switch in code, CORS, the external Storybook app, and the Drush
commands that compile your stories. This page walks through a working development
setup.

## Grant the render permission

Storybook fetches each story's markup from a Drupal endpoint at
`/storybook/stories/render/{hash}`, which is gated by the **Render storybook
stories** permission. The external Storybook app runs anonymously, so in **local or
dev** you grant that permission to the anonymous role:

```bash
drush role:perm:add anonymous 'render storybook stories'
# revoke it when you are done — never enable it in production:
drush role:perm:remove anonymous 'render storybook stories'
```

## Turn on development mode and CORS

Storybook renders inside an iframe on a different origin, so you need CORS enabled,
and you want caching off so you see fresh output. Both are set in a **dev‑only**
services file (for example `sites/default/development.services.yml`), never in
production:

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

The `storybook.development` parameter (off by default) tells the module to disable
page cache, render cache, and asset optimization on the render route. It is also
handy to disable Twig caching while you work:

```bash
drush state:set twig_debug 1
drush state:set twig_cache_disable 1
drush state:set disable_rendered_output_cache_bins 1
```

The theme negotiator, absolute asset URLs, and JS behavior re‑runs are all wired up
automatically — you do not configure them.

## Write your stories

Create a file named `<something>.stories.twig` next to the component it documents (in
a module or theme). Use the two tags the module adds:

- `{% stories my_group with { title: 'Components/Examples/Card' } %}` … `{%
  endstories %}` — declares a story group; `title` is where it appears in the
  Storybook sidebar.
- `{% story default with { name: '1. Default', args: { header: 'Hi' } } %}` … `{%
  endstory %}` — one variant. The values in `args` become Twig variables available
  inside the block and drive Storybook's controls.

Inside each story you typically `embed` or `include` the real component template, so
Storybook shows genuine Drupal markup. For example:

```twig
{% stories my_card with { title: 'Components/Examples/Card' } %}
  {% story default with { name: '1. Default', args: { header: 'I am a header!' } } %}
    {% embed '@examples/my-card' with { header } %}{% endembed %}
  {% endstory %}
{% endstories %}
```

## Compile stories with Drush

Storybook reads compiled JSON, not the Twig directly. Two commands do the
compilation:

```bash
# Compile every *.stories.twig under modules, profiles, and themes:
drush storybook:generate-all-stories
drush storybook:generate-all-stories --force           # even unchanged files
drush storybook:generate-all-stories --omit-server-url # for static/multi-env deploys
drush storybook:generate-all-stories --uri=https://my-site.com  # override endpoint domain

# Compile a single template (path relative to the Drupal root):
drush storybook:generate-stories modules/custom/my_theme_stuff/foo.stories.twig
```

**Run these from the Drupal docroot** (the directory that is the Drupal root, e.g.
`web/`), because the single‑file command writes the `.stories.json` relative to your
current working directory:

```bash
cd web && drush storybook:generate-stories modules/custom/my_theme_stuff/foo.stories.twig
```

To recompile continuously while editing:

```bash
watch --color drush storybook:generate-all-stories
```

If you use `--omit-server-url`, set the render endpoint yourself in Storybook's
`.storybook/preview.js` (`parameters.server.url =
'<drupal>/storybook/stories/render'`).

## Run the external Storybook app

Finally, browse the components with the Storybook Node application, which lives
outside Drupal:

```bash
npm init -y                 # if there is no package.json yet
npx storybook init --type server
yarn storybook              # add --no-open under DDEV
```

Point it at your compiled `*.stories.json`, make sure CORS is enabled on Drupal (as
above), and each story will render through the Drupal endpoint with real,
theme‑accurate markup.
