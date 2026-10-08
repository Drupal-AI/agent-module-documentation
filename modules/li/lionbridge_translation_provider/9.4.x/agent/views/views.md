<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration

The module exposes its connector table and some computed columns to Views so the TMGMT job
overview can show Lionbridge job status/ids. Table data is declared in
`tmgmt_contentapi_views_data()`; the plugins live under `src/Plugin/views/`.

## Base table

`tmgmt_capi_request_processor` (base field `rid`) — fields exposed include `jobid`,
`statuscode`, `status`, `lastupdated`, `count`, `tjid`, `tjiid`, `updateid`, `providerid`,
`requestid`, `haserror`, `updatedtime`, `file_upload_status`, `file_upload_attempts`,
`errormessage`.

## Custom field handlers

| Plugin id | Class | Shows |
|---|---|---|
| `job_status_field` | `views/field/JobStatusField` | Overall Lionbridge job status for the row. |
| `job_lioxid_field` | `views/field/JobLioxidField` | The remote Lionbridge (Liox) job id. |
| `job_providerid_field` | `views/field/JobProvideridField` | The provider name for the job. |
| `tmgmt_capi_items_count` | `views/field/TmgmtCapiItemsCount` | Count of items from aggregation (registered via `hook_views_plugins_alter`). |

## Custom filter handlers

| Plugin id | Class | Filters by |
|---|---|---|
| `liox_job_status_filter` | `views/filter/LioxJobstatusFilter` | Lionbridge job status. |
| `string` (custom class) | `views/filter/LioxJobIdFilter` | Lionbridge job id. |

These primarily augment the core TMGMT `tmgmt_job_overview` view (also altered by
`hook_views_pre_view`, `hook_views_post_execute`, and `hook_views_query_alter` — see
[hooks/hooks.md](../hooks/hooks.md)).
