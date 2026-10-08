<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — WebProfiler

Two permissions (`webprofiler.permissions.yml`):

| Permission | `restrict access` | Gates |
|---|---|---|
| `access webprofiler` | **TRUE** | The dashboard (`/admin/reports/profiler/view/{token}`), the saved-profiles list (`/admin/reports/profiler/list`), database EXPLAIN, and the **settings form**. This is the powerful one — profiles expose queries, request data, config and service internals. Grant to trusted developers only. |
| `view webprofiler toolbar` | FALSE | Seeing the injected toolbar on HTML responses, individual panels (`/admin/reports/profiler/view/{token}/panel/{name}`), the raw toolbar route (`/profiler/{token}`), and the frontend CWV/navigation POST endpoints. |

```bash
drush role:perm:add administrator 'access webprofiler'
drush role:perm:add administrator 'view webprofiler toolbar'
```

Because collected profiles can contain sensitive runtime data (query contents, request
parameters, config), treat both permissions as developer-only and never grant on production.
