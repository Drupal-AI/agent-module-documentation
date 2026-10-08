# Configuration

Nova Poshta needs to talk to the carrier's API, so the one thing you *must* do
after enabling the module is give it your API credentials.

## Open the settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → Development → NovaPoshta**, or navigate directly to
   `/admin/config/development/novaposhta`. This is the `novaposhta.settings`
   configuration form.

## API credentials

The settings form is where you enter the Nova Poshta API key (and any related
connection settings the form exposes) that authorises requests to the carrier's
service. You get this key from your Nova Poshta business account.

**Keep the key out of version control.** Treat the API key as a secret: rather than
committing it in exported configuration, store it in an environment variable and
reference it from there. If you are unsure what the form persists, check the values
with `drush cget novaposhta.settings` before you export and commit configuration —
you do not want a live API key ending up in your repository.

## Load the reference data

Entering credentials is only half the job. Nova Poshta's checkout relies on an
up-to-date list of cities and warehouses (branches). The module ships console
commands for this — list them with:

```bash
drush list | grep -i novaposhta
```

Run the relevant refresh command after configuring credentials, and consider
scheduling it (via cron) so the branch list stays current as Nova Poshta opens and
closes locations.

## Save

Save the form, then place a test order choosing Nova Poshta delivery to confirm
that city search and warehouse selection work at checkout.
