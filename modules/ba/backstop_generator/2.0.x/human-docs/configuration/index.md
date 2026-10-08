# Configuration

Backstop Generator's job is to produce a `backstop.json` file for BackstopJS.
Configuration is about telling it *what* to screenshot and *at what widths*, then
generating the file.

## Grant the permission first

The generator ships its own permission. Under **People → Permissions**, give it
to the roles that should be allowed to generate the config — normally just
developers and administrators. There is no reason for ordinary users to reach it.

## Open the generator

Log in as a user who has the generator permission and open the settings form
(the `backstop_generator.settings_form` route, under the site's Configuration
area).

## Configure scenarios and viewports

- **Scenarios** describe the pages BackstopJS should photograph. The generator
  builds these from the site's URLs, so you point it at the pages you care about
  (the home page, a representative article, key landing pages, and so on).
- **Viewports** are the screen widths each page is captured at. These are built
  from your site's **breakpoints** (from core's Breakpoint module), so the
  screenshots match the widths your theme is actually designed for — mobile,
  tablet, desktop, whatever your theme declares.

## Generate the file

Once your scenarios and viewports are set, generate the `backstop.json` file.
That file is the hand-off point: you then run BackstopJS itself (the Node.js
tool, outside Drupal) against it — `backstop reference` to capture the baseline,
`backstop test` to compare later runs against that baseline. Regenerate the
config whenever your site's pages or breakpoints change so the tests keep
covering the right screens.
