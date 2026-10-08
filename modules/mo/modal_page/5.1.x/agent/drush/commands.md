# modal_page Drush commands

Defined in `src/Drush/Commands/ModalPageCommands.php`.

## `modal_page:cron`

- **Aliases:** `modal-page-cron`
- **Signature:** `drush modal_page:cron`
- **What it does:** calls `ModalPageScheduler::processScheduling()`
  (`modal_page.scheduler` service), which publishes/unpublishes modals based on their
  `publish_on` / `unpublish_on` timestamps. Use it to drive scheduled modals (e.g. from a
  system crontab) so a modal goes live and expires at set times.

```bash
drush modal_page:cron
# or
drush modal-page-cron
```

There is also an HTTP cron endpoint at `/modal-page/cron/{cron_key}`
(`ModalCronController`, access via a cron key) that runs the same scheduling — useful when you
cannot run Drush but can hit a URL. The Drush command is the simpler option on a normal
server.

That is the only Drush command the module provides.
