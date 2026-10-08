# Configuration

Once the base module and the submodules you want are enabled, logging happens
automatically — but a settings form lets you control **where logs go** and **how long
they are kept**. This matters for both performance and privacy: an audit log grows
continuously, and it records who did what.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Event log track**
   (`/admin/config/system/events-log-track`).

## Log deletion (retention)

By default, log entries are kept indefinitely. To stop the table growing without
bound:

- **Enable log deletion** — tick this to have the module prune old records.
- **How long to keep records** — set the retention period. Records older than this are
  removed. Choose a value that matches your organization's retention or compliance
  policy; keeping audit data no longer than necessary is good practice.

## Output destination

By default, tracked events are written to the **database**, which is what the
**Reports → Events Log Track** page reads. If you prefer to send logs elsewhere:

- Enable the **`event_log_track_syslog`** submodule to send events to **syslog**, then
  configure the message format in your syslog settings.
- On this settings form, you can then **disable logging to the database** so events go
  only to syslog. When you do that, the database UI is no longer needed, and the
  project recommends uninstalling `event_log_track_ui`.
- The **`event_log_track_stdout`** submodule similarly sends events to stdout, useful
  in containerized/log-aggregation setups.

## Save

Click **Save configuration**. Retention and output changes take effect going forward.

## Privacy note

These logs capture user activity and can hold personal data. Alongside the retention
setting above, restrict the **access event log track** permission to trusted roles so
only appropriate staff can read the trail, and consider the companion
[Event Log Track Encrypt](https://www.drupal.org/project/event_log_track_encrypt)
module if any tracked area may record especially sensitive details.
