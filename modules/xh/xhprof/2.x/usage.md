<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
XHProf integrates the hierarchical PHP profiler (XHProf, Tideways, or uprofiler) into Drupal, capturing per-function call counts and inclusive/exclusive wall-time, CPU and memory for a request and letting you browse the results in a native admin UI.

---

To use it you must first install a supported profiler **PHP extension** (`xhprof` or `tideways`); the module cannot collect data without one, and its settings form disables the enable switch until an extension is detected. After enabling the module, visit **Configuration → Development → XHProf** (`/admin/config/development/xhprof`, permission `administer xhprof`) to switch profiling on, pick the extension, choose what to capture (CPU / memory / exclude built-ins), set an optional sampling **interval** (0 = every request), list **exclude** paths that should never be profiled (admin, contextual, toolbar, JS/CSS are excluded by default), and choose a storage backend (only file storage ships, writing serialized runs to `xhprof.output_dir` or the system temp dir). Once on, every non-excluded request is profiled and saved on shutdown; users with **`access xhprof data`** see an injected "XHProf output" link on the page and can open **Reports → XHProf** (`/admin/reports/xhprof`) to see the runs list, a sortable top-N function table per run (`?length`, `?sort`), and a parent/child drill-down per function. It is a development/diagnostic tool: profiling adds overhead and profiles reveal internal code paths and the profiled request paths, so run it on development/staging or for a targeted production investigation and turn it off afterwards. If the `webprofiler` module is present, a summary widget appears in its toolbar instead of the injected link. (The run-diff page and the legacy Drush-8 commands in `xhprof.drush.inc` are non-functional in this beta.)

---

- Profile where a slow request spends its time.
- Capture per-function call counts and timing.
- Measure inclusive vs exclusive wall-time, CPU and memory.
- Choose the XHProf, Tideways, or uprofiler extension.
- Enable or disable profiling from the settings form.
- Exclude admin/toolbar/JS/CSS paths from profiling.
- Add your own paths to the exclude list.
- Sample a fraction of requests via the interval setting.
- Exclude PHP built-in and indirect functions from the profile.
- Store runs as files in the xhprof output dir or temp dir.
- Browse collected runs at Reports → XHProf.
- Sort the function table by any metric column.
- Show all functions or just the top 100.
- Drill into a function's parent and child calls.
- Follow the injected "XHProf output" link after a profiled page.
- Restrict who can view profiles with `access xhprof data`.
- Restrict settings with `administer xhprof`.
- Integrate a summary widget into the Webprofiler toolbar.
- Investigate a performance regression, then turn it off.
- Keep profiling off in production (it is off by default).
- Point storage at a custom backend by tagging a service `xhprof_storage`.
- Diagnose bottlenecks on development or staging.
- Share a run URL with a fellow developer who has access.
- Confirm the profiler PHP extension is installed first.
