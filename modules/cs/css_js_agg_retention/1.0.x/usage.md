<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CSS/JS Aggregation Retention keeps recent aggregated CSS/JS files during cache rebuilds instead of deleting them all, deleting only files older than a configurable retention window.

---

Since Drupal 10.1, clearing caches (`drush cr`) deletes the entire `assets://css` and `assets://js` aggregate directories, forcing every aggregate to regenerate on the next request. This module decorates core's CSS and JS collection optimizer services so that, instead of wholesale deletion, cache rebuilds delete only aggregate files older than a retention threshold (default 45 days) and keep the recent ones on disk. This smooths the performance hit after deployments and cache clears, and it is important for statically generated or heavily cached sites where a previously referenced aggregate URL must keep resolving. A settings form under the Performance page controls the retention period, and two Drush commands allow manual purging (respecting the threshold, or purging everything). The module is a pure operations/performance feature — it adds no content entities, no permissions of its own, and reads no user-supplied input beyond the integer retention value entered by a site administrator.

---

- Keep recent CSS/JS aggregates on disk across cache rebuilds.
- Delete only aggregate files older than the retention window during a rebuild.
- Avoid regenerating all aggregates on the first requests after `drush cr`.
- Reduce first-load latency spikes after a deployment.
- Support statically generated sites that depend on stable aggregate files.
- Restore pre-10.1 time-based garbage collection of aggregates.
- Configure the retention period (days) via an admin settings form.
- Set retention anywhere from 1 to 365 days.
- Change the retention value programmatically through the Config API.
- Manually purge stale aggregates via `drush cjar:purge-old`.
- Manually purge all aggregates via `drush cjar:purge-all` for emergency cleanup.
- Balance disk usage against post-rebuild performance.
- Cap growth of the `css`/`js` asset directories with an age-based sweep.
- Keep aggregate URLs referenced by CDN/browser caches resolvable for the retention window.
- Log how many files were scanned and purged on each sweep.
- Operate transparently once enabled, with no theme or content changes.
- Apply the same retention logic to both CSS and JS aggregates.
- Run manual purges from CI/deploy scripts using the Drush commands.
- Tune retention per environment (e.g. shorter on disk-constrained hosts).
- Leave core aggregation behavior otherwise unchanged.
