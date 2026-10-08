# Configuration

WebProfiler works out of the box, but the settings form lets you control what is
collected and shown, and a few power features are switched on from `settings.php`.

## Open the settings form

1. Log in as a user with the **access webprofiler** permission (and site
   configuration access).
2. Go to **Configuration → Development → Devel → WebProfiler**, or navigate
   directly to `/admin/config/development/devel/webprofiler`.

The form (config object `webprofiler.settings`) covers:

- **Active toolbar items** — choose which collectors appear as segments in the
  bottom toolbar. Trim this to the handful you care about to keep the toolbar
  uncluttered; the full data is still available in the dashboard.
- **Excluded paths** — paths that should not be profiled. The defaults cover noise
  like contextual links, the toolbar, and AJAX/asset requests. Add your own to
  skip endpoints you don't want cluttering the profile list.
- **Intercept redirects** — when on, a response that would normally redirect is
  paused so you can inspect its profile before following the redirect. Handy for
  debugging form submissions and access redirects.
- **Purge on cache clear** — whether stored profiles are deleted whenever the
  cache is cleared. Leave on to keep the profile store tidy; turn off if you want
  profiles to survive a `drush cr`.
- **Database query options** — how queries are displayed, including thresholds so
  that pages running very many queries stay responsive in the panel.
- **IDE link format** — the URL template used to turn file references in the
  profiler into clickable "open in IDE" links (for example a PhpStorm or VS Code
  handler). Set this to jump from a stack frame straight to the line in your
  editor.

Click **Save configuration** when done.

## Optional switches in settings.php

A couple of features are enabled by editing your site's `settings.php` (typically
`sites/default/settings.php` or a local override):

- **Time metrics** — enable the Stopwatch tracer to collect timing data:

  ```php
  $settings['tracer_plugin'] = \Drupal\webprofiler\Plugin\Tracer\StopwatchTracer::class;
  ```

- **Disable the custom error page** — if WebProfiler's error handler conflicts
  with another error-handling module:

  ```php
  $settings['webprofiler_error_page_disabled'] = TRUE;
  ```

## Permissions

Two permissions gate the module (set them at **People → Permissions**):

- **access webprofiler** — access to the dashboards, reports, and this settings
  form. Keep this restricted to trusted developers.
- **view webprofiler toolbar** — see the bottom toolbar on pages.

## A note on Tracer

The dependency **Tracer** can forward trace data to an external store (for example
Grafana Tempo). That's configured on Tracer's own side; WebProfiler simply
consumes the timing data Tracer collects when the Stopwatch tracer plugin is
enabled above.
