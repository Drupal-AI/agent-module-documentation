# Smartling Translator — permissions & routes

## Permissions (`tmgmt_smartling.permissions.yml`)
| Permission | `restrict access` | Gates |
|---|---|---|
| `send context smartling` | true | Sending context to Smartling (the send-context action/form). Description warns it "involves automatic switching user during upload". Treat as trusted. |
| `see smartling messages` | true | Viewing Smartling health-check messages and the progress-tracker record delete route. |

General TMGMT admin (`administer tmgmt`, from the tmgmt module) governs provider setup and the
download-by-job-items approve form.

## Routes (`tmgmt_smartling.routing.yml`)
| Route | Path | Access |
|---|---|---|
| `tmgmt_smartling.push_callback` | `POST /tmgmt-smartling-callback/{job}` | `_access: 'TRUE'` |
| `tmgmt_smartling.push_callback_attachment` | `POST /tmgmt-smartling-callback/{job}/{file}` | `_access: 'TRUE'` |
| `tmgmt_smartling.progress_tracker.delete_record` | `DELETE /tmgmt-smartling/firebase/projects/{projectId}/spaces/{spaceId}/objects/{objectId}/records/{recordId}` | perm `see smartling messages` |
| `tmgmt_smartling.send_context_action` | `/admin/tmgmt/send-context-action` | perm `send context smartling` |
| `tmgmt_smartling.download_by_job_items_approve_action` | `/admin/tmgmt/approve-action-download-by-job-items` | perm `administer tmgmt` |

The two **push callback** routes are the endpoints Smartling calls when a translation is ready. Each
loads the `{job}`, checks that `fileUri` and `locale` request parameters are present (otherwise returns
404), then schedules a translation download for that job via `FlowScheduler::scheduleDownload` and
returns `OK`. They are registered with Smartling only when a provider has **Use Smartling callback**
(`callback_url_use`) enabled (default off); downloads otherwise run on cron or on-demand actions.
