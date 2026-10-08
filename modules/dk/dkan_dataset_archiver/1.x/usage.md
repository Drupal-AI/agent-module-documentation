Automatically preserves durable copies of a DKAN dataset's resource files (and optional theme/keyword/annual zip bundles) so the data survives even after the original distributions are changed or removed.

---

DKAN Dataset Archiver hooks the DKAN metastore dataset lifecycle: when a dataset is published or updated, an event subscriber creates a `dda_archive` content entity that captures the dataset's title, identifier, modified date, access level, themes and keywords, and downloads/copies each distribution resource file into `public://dataset-archives/` (or the private stream, per settings). Because the archive is a stored copy, it persists after the source resource is edited or deleted. Beyond these per-dataset "individual" archives, the module can build aggregated zip bundles grouped by theme, by keyword, or annually (plus a rolling "current" download per group), each accompanied by a `manifest.json` describing the included files. All aggregation work is deferred to Drupal queues (`archive_aggregation`) processed on cron, throttled by a configurable aggregation delay, so large sites are not blocked during a request. A read-only JSON API under `/api/1/archive/…` exposes the archive catalogue for front-end consumption, respecting per-user view permissions and public/non-public access levels. An optional submodule streams the archived files to AWS S3. Configuration lives at `/admin/dkan/archiver`; archives are managed as entities at `/admin/content/archive`.

---

- Keep a permanent copy of every published DKAN dataset's CSV/resource files, immune to later edits or deletions of the source distribution.
- Preserve a point-in-time snapshot of a dataset (title, identifier, modified date, themes, keywords, access level) alongside its files.
- Offer citizens a single "download everything for this topic" zip by aggregating all datasets sharing a theme.
- Offer a "download everything tagged X" zip by aggregating all datasets sharing a keyword.
- Publish an annual archive bundle of all datasets updated in a given year for long-term retention or compliance.
- Provide a continuously-updated "current" zip per theme/keyword that always reflects the latest published data.
- Power a front-end "Data archives" browse page from the `/api/1/archive/individual/…` JSON endpoint.
- Build topic landing pages that list archived downloads via `/api/1/archive/aggregate/theme/{theme}/…`.
- Exclude specific datasets, themes, or keywords from archiving via skip lists on the settings form.
- Normalise messy taxonomy by mapping variant theme/keyword names to a canonical label before archiving (`Original -> New`).
- Archive private / restricted-public datasets separately, optionally into Drupal's private file system, controlled by the "treat as private" access-level policy.
- Cap storage growth by retaining only the last N years of archives.
- Skip the potentially huge single "annual ALL" bundle while still producing per-theme/keyword annuals on busy portals.
- Regenerate this year's annual archives on demand with `drush dkan_dataset_archiver:create-annual`.
- Rebuild the "current" download bundles for all published datasets with `drush dkan_dataset_archiver:create-current`.
- Automatically refresh aggregate bundles when a member dataset changes, without a full rebuild, via queued referencing-archive updates.
- Give data stewards a revisioned entity (`dda_archive`) with view/edit/delete and revision management under `/admin/content/archive`.
- Let other modules inject extra files into an aggregate zip through the `hook_dkan_dataset_archiver_archive_alter` alter hook.
- Serve archive listings with day-long caching keyed by the requester's roles so anonymous and privileged users see appropriately scoped results.
- Offload archived files to AWS S3 (or keep both local and remote copies) using the remote-storage submodule.
