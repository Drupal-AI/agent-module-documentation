Read Only Mode is an alternative to Drupal's Maintenance Mode: when enabled it lets visitors keep reading the site but blocks (almost) all form submissions, so content cannot be added or changed while maintenance runs.

---

Read Only Mode adds a "Read Only Mode" section to the core **Maintenance mode** settings form (`system.site_maintenance_mode`) and stores its own configuration in the `readonlymode.settings` config object. When `enabled` is on, `hook_form_alter()` strips the fields out of every non-allowed form (or redirects to a configured `url`) and a validate handler rejects any blocked submission with the configured `messages.not_saved` error, while showing the `messages.default` warning on affected pages. A curated allow-list of always-permitted forms lives in `forms.default.edit` (submittable: login, password reset, search, this settings form, exposed filters, …) and `forms.default.view`; site builders extend it with newline-separated form IDs — supporting `*` wildcards — in `forms.additional.edit` (may be submitted) and `forms.additional.view` (may be shown but not submitted). Two permissions govern behavior: `readonlymode access forms` lets trusted users bypass the lock entirely, and `readonlymode access messages` controls who sees the notices. A "Read Only Mode" block plugin (`readonlymode_block`) can surface the maintenance message in a region. There are no Drush commands; everything is driven by config, so the lock can be toggled and deployed like any other setting.

---

- Freeze a site during a code or database deployment while keeping it fully readable.
- Prevent comments, node edits, and user changes during a content migration.
- Put the site into read-only during a backup or database export.
- Allow anonymous login and password reset to keep working while content is frozen.
- Redirect users who try to submit a blocked form to a custom "maintenance" page via the `url` setting.
- Show a friendly warning message on pages that contain a blocked form.
- Show a specific error when a form is submitted after read-only was switched on mid-session.
- Let a webform keep accepting submissions during read-only using a `webform*` wildcard in the allow-list.
- Permit a specific contact or feedback form to be submitted while everything else is locked.
- Give administrators the `readonlymode access forms` permission so they can still edit during a freeze.
- Hide the read-only notices from anonymous users by withholding `readonlymode access messages`.
- Toggle read-only on/off as a single config change deployable through config sync.
- Keep search forms and exposed Views filters usable while the site is read-only.
- Provide an editorial "content lock" window before a big launch.
- Display the maintenance notice in a sidebar region using the Read Only Mode block.
- Stop content changes on a production mirror/replica used for reporting.
- Enforce a change-freeze during an audit without taking the site offline.
- Allow the maintenance-mode settings form itself to remain submittable so you can turn the lock back off.
- Let editors preview/read admin content listings (node/comment overviews) but not act on them.
- Temporarily disable form spam while investigating an attack, leaving the site readable.
- Customize the wording of both the on-page warning and the rejected-submission error.
- Combine with a redirect path to funnel all edit attempts to a status page.
- Roll out a read-only state across environments by exporting `readonlymode.settings`.
- Protect a demo site from visitor modifications while leaving it browsable.
