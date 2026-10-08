Advanced Queue Runner processes Advanced Queue jobs automatically as a background daemon, without a cron job or a manually invoked Drush command.

---

Advanced Queue Runner extends the Advanced Queue (advancedqueue) module with a long-running background "runner". From a settings form at /admin/config/advancedqueue/runner an administrator records the site's Drush binary path and Drupal root path, selects which queue(s) to watch, sets a polling interval and a per-queue (or system-wide) concurrency limit, then starts the runner. Starting it spawns a detached PHP process (src/Scripts/jobs.php) that boots the Drupal kernel and uses a ReactPHP event loop to poll the chosen queues on the interval; whenever a queue has pending jobs (and the running-job count is under the limit) it launches a `drush advancedqueue:queue:process <queue>` child process to work them off. The same form stops the runner, shows its live status (PID, queues, interval, limits, start time), and an optional hook_cron() step can restart the daemon automatically if it is found no longer running (for example after a server reboot). It requires the Advanced Queue module plus the ReactPHP event-loop and child-process libraries.

---

- Process Advanced Queue jobs continuously without configuring a system cron job.
- Avoid having to run `drush advancedqueue:queue:process` by hand.
- Turn queued work into near-real-time processing by polling on a short interval.
- Run a persistent background daemon for one or more Advanced Queue queues.
- Start and stop the runner from an admin form instead of the command line.
- Choose exactly which queues the runner should watch (checkbox per queue).
- Set the polling interval (in seconds) between queue checks.
- Limit how many jobs of each queue run concurrently (`-1` for no limit).
- Alternatively enforce a single concurrency limit across the whole system (all queues combined).
- Automatically restart the runner during cron if it stopped (e.g. after a reboot).
- See the runner's live status: PID, watched queues, interval, limits, and start time.
- Record the environment (Drush path, site root, HOME) used to launch queue-processing commands.
- Keep queue throughput independent of front-end request traffic.
- Drive email, indexing, import/export, or other Advanced Queue backends without cron latency.
- Process time-sensitive queued tasks promptly on sites where cron runs infrequently.
- Reduce reliance on external process supervisors for simple Advanced Queue daemonization.
- Run background job processing on hosts where you would otherwise script a systemd/supervisor unit.
- Recover the runner after interruption without manual intervention (with the cron auto-restart option).
- Confine processing to specific business-critical queues while leaving others to cron.
- Tune server load by adjusting interval and concurrency limits.
- Operate entirely within Drupal admin, using the existing Advanced Queue backends and job types.
