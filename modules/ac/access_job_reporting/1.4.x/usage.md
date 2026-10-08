ACCESS Job Reporting reports TAPIS HPC job metadata from a Drupal science gateway to the ACCESS-CI Allocations API so gateway jobs are attributed against ACCESS resource allocations.

---

The module hooks TAPIS job creation on a Drupal site built with the TAPIS suite (tapis_job, tapis_system). When a `tapis_job` entity is inserted, it looks up the job's execution system, resolves the job's TAPIS logical queue to an ACCESS resource name using a per-system resource map, gathers the reporting fields (gateway user's display name, submit time, software name and version, remote scheduler job id, allocation account), and enqueues a report item on the reliable Drupal queue `access_job_reporting.job_queue`. A cron-driven queue worker then POSTs each item to the ACCESS `job_attributes` endpoint using `XA-API-KEY` and `XA-AGENT` request headers, with configurable retry interval, maximum attempt count, and a debug dry-run mode that logs the payload instead of sending it. Reporting is opt-in per TAPIS system and enabled through a small fieldset added to the `tapis_system` node edit form; a site-wide settings page holds the API credentials and delivery options and can fetch a suggested list of valid ACCESS resource names from the API.

---

- Report TAPIS-submitted HPC jobs from a Drupal science gateway to ACCESS-CI for allocation accounting.
- Automatically enqueue an ACCESS report whenever a `tapis_job` entity is created, with no manual step per job.
- Map each TAPIS system's scheduler queues (e.g. `normal`, `gpu`) to named ACCESS resources (e.g. `expanse.sdsc.xsede.org`).
- Enable or disable ACCESS reporting individually per TAPIS system node rather than globally.
- Attribute gateway jobs to the correct ACCESS allocation by parsing the job's `--account` scheduler option.
- Send the gateway user's real name (or username) as the ACCESS `gatewayuser` value for per-user usage tracking.
- Record job submit time, software name and version, and the remote scheduler job id in each ACCESS report.
- Deliver reports reliably in the background via the Drupal queue and cron rather than blocking job submission.
- Retry failed deliveries automatically with a configurable retry interval (default one day) and max attempt cap (default 15).
- Poll TAPIS on later cron runs to fill in a remote job id or submit time that was not yet available at submission.
- Run in debug/dry-run mode to log exactly what would be reported without contacting ACCESS, for staging or QA.
- Store the ACCESS API key securely as a Key entity when the Key module is installed, keeping the secret out of module config.
- Fall back to a plain config-stored API key on sites that do not use the Key module.
- Point the reporter at an alternate endpoint URL for testing against a non-production ACCESS environment.
- Fetch and display a suggested list of valid ACCESS resource names directly from the API while configuring the mapping.
- Validate the resource-map syntax on save so a queue is never ambiguously mapped to two ACCESS resources within one system.
- Set a custom `XA-AGENT` header value to identify the reporting gateway to ACCESS.
- Give ACCESS allocation administrators standardized, per-job usage data from a Tapis/Drupal gateway.
- Operate unattended once configured, requiring only that Drupal cron runs regularly to drain the report queue.
- Keep job submission fast by deferring all outbound HTTP calls to the background worker.
