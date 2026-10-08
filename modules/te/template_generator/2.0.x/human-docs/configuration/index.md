# Configuration

Template Generator is driven from a single settings form. There you choose what to
generate and how to organise it, then run the generation to write the template files
into your theme.

## Open the settings form

1. Log in as an administrator.
2. Open the Template Generator settings page (registered at the
   `template_generator.settings` route, in the admin configuration area).

## The options

- **Entities to generate** — select which content entities you want templates
  generated for. Only the entities you tick are processed.
- **Organise by view mode or by bundle** — choose how the generated files should be
  sorted, so the output matches how you like to structure a theme's templates.
- **Ignore certain view modes or bundles** — exclude view modes or bundles you do
  not want templates for, keeping the output focused on what you actually theme.
- **Automatic regeneration** — optionally have the module regenerate templates
  automatically after each change to a display's settings, so your scaffolds stay in
  step with your Manage display configuration.
- **Target theme** — by default files are written to `your-current-theme/templates`;
  change this setting to generate into a different theme.

Each generated file includes a header comment listing the variables available in
that template, which is a handy reference while you flesh the template out.

## Run it and review the output

Generate the templates from the form, then look at the files the module wrote into
the target theme's `templates` directory. Because this tool writes to your theme,
treat the output as a starting point: review each generated template, adjust it to
your needs, and keep the results under version control. Run generation in a
development environment rather than on a live site.

## Clear the cache

After new template files appear, clear Drupal's cache (for example `drush cr`) so
the theme layer picks them up.
