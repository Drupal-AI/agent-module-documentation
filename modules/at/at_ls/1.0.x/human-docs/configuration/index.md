# Configuration

AT-LS needs two things before it can work: your AT-LS API credentials (stored
securely, never in plain config) and the connection/workflow settings. It also
uses **Advanced Queue** to process jobs, so a queue runner must be in place.

## 1. Store the AT-LS credentials securely

AT-LS authenticates to the external service with HTTP basic auth, and the module
reads its secret through the **Key** module — which means the actual secret lives
in an **environment variable**, not in exported configuration or version control.

The recommended pattern (DDEV shown; adapt for your host):

1. Save the secret into the container's environment without committing it:

   ```bash
   ddev dotenv set .ddev/.env --at-ls-api-key=<value>
   ddev restart
   ```

   The flag `--at-ls-api-key` becomes the variable `AT_LS_API_KEY`. Keep
   `.ddev/.env` out of version control.

2. Confirm the variable is present **without printing its value**:

   ```bash
   ddev exec 'test -n "$AT_LS_API_KEY"'   # exit status 0 means it is set
   ```

3. Create a **Key** entity that reads that environment variable (Configuration →
   System → Keys, `/admin/config/system/keys`), using the built‑in *Environment*
   key provider pointed at `AT_LS_API_KEY`.

This keeps the credential out of the database export and out of git — the golden
rule for any external‑API secret.

## 2. Enter the connection settings

With the Key in place, open the AT-LS configuration screen and:

- Point the module at your AT-LS endpoint / account.
- Select the **Key** you created above as the credential source.
- Set any translation‑workflow options the form exposes (source/target languages,
  request defaults).

Access to this screen is gated by the module's configuration permission — grant it
only to trusted administrators at **People → Permissions**.

## 3. Make sure the queue runs

Translation requests are processed by **Advanced Queue**, so they only move if a
queue runner is executing — typically via cron or a dedicated Advanced Queue
processor. Check the queue at **Configuration → Advanced Queue** if requests seem
to stall in a pending state.

## 4. Grant permissions

AT-LS ships separate permissions for using the translation‑request form,
administering the configuration, and administering strings/requests. Assign each to
the appropriate role so translators can raise requests while only administrators
change the connection settings.
