# Configuration

WebProfiler works as soon as it is enabled — after that, the settings form lets
you tune what it profiles and how the data is shown. There are also two
permissions to grant and a couple of optional `settings.php` switches.

## Permissions first

The module defines two permissions (grant them under **People → Permissions**):

- **Access webprofiler** — opens the dashboards, reports and the settings form.
  This one is marked as a *restricted* permission because the profiler exposes a
  lot of internal detail, so give it only to trusted developers.
- **View webprofiler toolbar** — lets a user see the toolbar injected at the
  bottom of pages.

## Open the settings form

Go to **Configuration → Development → Devel → WebProfiler**
(`/admin/config/development/devel/webprofiler`). It edits the `webprofiler.settings`
config object.

## The settings

- **Excluded paths** (`exclude_paths`) — a list of paths that are not profiled at
  all. Defaults exclude noise like `/contextual/*`, `/toolbar/*`, `/edit/*`, and
  `*.js` / `*.css` requests.
- **Toolbar-excluded paths** (`exclude_toolbar`) — paths that are still profiled
  but where the toolbar is not injected (default `/media/oembed`).
- **Intercept redirects** (`intercept_redirects`) — off by default. When on, the
  profiler pauses on a response that would redirect, so you can open the profile
  instead of being bounced onward.
- **Purge on cache clear** (`purge_on_cache_clear`) — on by default; stored
  profiles are deleted whenever you clear the cache. Turn it off to keep older
  profiles around.
- **Active toolbar items** (`active_toolbar_items`) — which of the many data
  collectors actually appear in the toolbar. Only a subset (ajax, blocks,
  database, devel, forms, memory, request, time, user, views) show by default;
  enable the rest here if you want them.
- **Database query options** — control the query panel: how queries are sorted
  (`query_sort`, by source or duration), the slow-query highlight threshold in
  milliseconds (`query_highlight`, default 5), and a limit
  (`query_detailed_output_threshold`, default 1000) above which detailed output is
  suppressed so pages running very many queries stay responsive.
- **IDE link** (`ide`) — the URL format used to jump from a file reference
  straight into your editor. The default targets PhpStorm
  (`phpstorm://open?file=%f&line=%l`); `%f` is the file and `%l` the line. For VS
  Code you might use `vscode://file/%f:%l`. If your code runs inside a container,
  the remote/local path mapping fields (`ide_remote_path` / `ide_local_path`) let
  you translate container paths to host paths.

Click **Save configuration** when done.

## Optional `settings.php` switches

A couple of features are enabled from `settings.php` rather than the form:

- **Time metrics** — add
  `$settings['tracer_plugin'] = \Drupal\webprofiler\Plugin\Tracer\StopwatchTracer::class;`
  to turn on Stopwatch-based timing. (The Tracer module can alternatively send
  trace data to an external store such as Grafana Tempo.)
- **Disable the custom error handler** — if WebProfiler's error page conflicts
  with another error-handling module, set
  `$settings['webprofiler_error_page_disabled'] = TRUE;` and rebuild the cache.

Stored profiles live in a `profiler` folder inside the public files directory
(this location can be overridden — see the project README).

## Reading the data

With the toolbar visible, click any of its segments to expand that collector, or
open **Reports → Profiler** (`/admin/reports/profiler`) for the full dashboard,
which also lists previously saved profiles by token so you can revisit them.
