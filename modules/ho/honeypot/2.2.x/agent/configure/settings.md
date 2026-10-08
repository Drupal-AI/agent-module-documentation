# Configure Honeypot

![Honeypot settings form](../../../../../../../screenshots/honeypot/2.2.x/settings.png)

Settings form at `/admin/config/content/honeypot` (route `honeypot.config`, permission
`administer honeypot`). Config object `honeypot.settings`:

```yaml
protect_all_forms: false          # true = protect every form (minus unprotected_forms)
log: false                        # log rejected submissions to dblog
element_name: 'url'               # machine name of the hidden honeypot field
time_limit: 5                     # min seconds before a submission is accepted (0 disables)
expire: 300                       # seconds honeypot state is kept (cron cleanup)
unprotected_forms:                # never protected
  - user_login_form
  - search_form
  - search_block_form
  - views_exposed_form
  - honeypot_settings_form
form_settings:                    # per-form opt-in when protect_all_forms is false
  user_register_form: false
  user_pass: false
  # <form_id>: true  → protect that specific form
```

- `time_limit` uses an exponential back-off: users who repeatedly trip the trap get a longer
  required delay (tracked in expirable key/value, cleared per `expire`).
- Set via drush, e.g. `drush config:set honeypot.settings protect_all_forms true`.
- `honeypot_cron()` purges expired tracking rows.
