Contribution Records is the credit-tracking backend for the new www.drupal.org, storing per-issue contribution credit for individuals and organizations as Paragraphs-based nodes synced from Drupal.org and GitLab issues.

---

The module defines the runtime behavior around a `contribution_record` content type and a `contributor` paragraph type (both expected to already exist in the surrounding www.drupal.org site config). Each record links to a single source issue — a canonical `https://www.drupal.org/node/N` issue/SA URL or a `https://git.drupalcode.org/.../-/issues|merge_requests/N` URL — through `field_source_link`. A `SourceLink` service wrapper detects the source type, validates the URL format and existence, and fetches metadata (title, project, status, security-advisory flag, participants, activity, related MRs) from the Drupal.org `api-d7` JSON endpoint or the GitLab API (using the `drupalorg` module's project/user/organization services and GitLab client). On node presave, contributors are auto-synced from the source into `contributor` paragraphs; maintainers then grant credit through a "Quick Credits" table and a per-contributor paragraph form, with per-user default attribution values stored via `user.data`. Bulk import from the legacy Drupal 7 site happens through a token-guarded POST endpoint (`/contribution-record-import`) and the `contribution_records_import_queue_worker` queue worker, and Drush commands queue re-syncs and report which D7 issues are not yet migrated. Public JSON/redirect endpoints expose per-user, per-organization and aggregate credit metrics by redirecting into `jsonapi_views` displays. Access is layered: only project maintainers (resolved live from the source) and holders of `administer contribution records` may edit/delete records, while a `contributor` may edit only their own contribution paragraph.

---

- Track contribution credit for Drupal.org issues and GitLab merge requests as structured `contribution_record` nodes instead of legacy D7 credit data.
- Create a contribution record on demand from an issue URL via `/contribution-record?source_link=https://www.drupal.org/node/123`.
- Auto-populate a record's contributors by syncing participants from the linked Drupal.org or GitLab issue on save.
- Let project maintainers grant/revoke credit for every participant using the "Quick Credits" tableselect on the record page.
- Let a contributor set their own attribution (volunteer time, organizations, customers) on their contribution paragraph.
- Store each user's preferred default attribution values and reuse them for future contributions ("Save and set values as default").
- Bulk-import curated contribution records from the Drupal 7 www.drupal.org via the trusted `/contribution-record-import` POST endpoint.
- Queue imports/re-syncs and process them with `drush queue:run contribution_records_import_queue_worker`.
- Queue re-syncs of specific D7 issue node IDs with `drush contribution_records:sync-contribution-records --nids=…`.
- Hard-reset a record's contributors to exactly match the source during a queued sync (`--hard-reset`).
- Audit migration completeness with `drush contribution_records:check-import-status` to list D7 issues not yet imported.
- Serve per-user credit listings by redirecting `/contribution-records-by-user` into a JSON:API views display.
- Serve per-organization credit listings via `/contribution-records-by-organization`.
- Serve combined organization-and-user credit listings via `/contribution-records-by-organization-by-user`.
- Filter any of the listing endpoints by project machine name, recent months, security-advisory flag, and page number.
- Export all-time credits as CSV using `csv_export=1` on the user/organization endpoints.
- Expose aggregated contribution metrics (credits, demographics, region, account age) as JSON via `/contribution-records-metrics`.
- Show live issue activity (comments, files, reactions per user) on a record via the `/contribution-record-source-activity` endpoint and attached JS.
- Re-order a record's credited contributors via drag-and-drop, persisted through `/contribution-record-save-order`.
- Sync a record's contributors on demand from the source issue or from related merge requests using buttons on the record.
- Attribute contribution comments posted by the GitLab automation by injecting an "Attribute your contribution" link (via `hook_gitlab_contribution_automated_comment_alter`).
- Hide credit rows for automated/bot accounts (for example "System Message") by listing their user IDs in `$settings['contribution_records_hide_users']`.
- Allow non-production (dev) Drupal.org and GitLab source domains for staging by enabling "Allow dev sources" on the settings form.
- Filter the organization autocomplete on the contributor form to only organizations the editing user belongs to (`node_user_organization` entity-reference selection).
- Automatically clean up orphaned contribution paragraphs when a user account is deleted (queued re-sync of affected records).
- Delete all imported records during development with `drush entity:delete node --bundle=contribution_record`.
