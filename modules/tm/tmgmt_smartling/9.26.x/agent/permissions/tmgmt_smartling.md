# Smartling Translator — permissions & routes

## Permissions (`tmgmt_smartling.permissions.yml`)
| Permission | `restrict access` | Gates |
|---|---|---|
| `send context smartling` | true | Sending context to Smartling (the send-context action/form). Description warns it "involves automatic switching user during upload" — treat as trusted. |
| `see smartling messages` | true | Viewing Smartling health-check messages and the progress-tracker record delete route. |

General TMGMT admin (`administer tmgmt`, from the tmgmt module) governs provider setup and the
download-by-job-items approve form.

## Routes (`tmgmt_smartling.routing.yml`)
| Route | Path | Access |
|---|---|---|
| `tmgmt_smartling.push_callback` | `POST /tmgmt-smartling-callback/{job}` | `_access: 'TRUE'` (public) |
| `tmgmt_smartling.push_callback_attachment` | `POST /tmgmt-smartling-callback/{job}/{file}` | `_access: 'TRUE'` (public) |
| `tmgmt_smartling.progress_tracker.delete_record` | `DELETE /tmgmt-smartling/firebase/projects/{projectId}/spaces/{spaceId}/objects/{objectId}/records/{recordId}` | perm `see smartling messages` |
| `tmgmt_smartling.send_context_action` | `/admin/tmgmt/send-context-action` | perm `send context smartling` |
| `tmgmt_smartling.download_by_job_items_approve_action` | `/admin/tmgmt/approve-action-download-by-job-items` | perm `administer tmgmt` |

The two **push callback** routes are called by Smartling when a translation is ready and schedule a
translation download for `{job}` via `FlowScheduler::scheduleDownload`. They require the job to exist and
the `fileUri` + `locale` request params to be present.
