# Configuration

There is no settings page for this connector. Configuration is two steps: create a
**Key** holding your SFTP credentials, then point a **dataset's SFTP source** at
that Key. The Key module is a hard dependency precisely so the password lives in a
Key entity and not in the site's exported configuration.

## 1. Create the credential Key

The module expects a **username/password** Key (a `user_password` Key type). How
you back that Key is up to you — for a real deployment, keep the actual secret in an
environment variable rather than typing it into the database.

Recommended pattern with DDEV:

1. **Store the SFTP password in an environment variable** and restart so the web
   container loads it:

   ```bash
   ddev dotenv set .ddev/.env --sftp-password=<value>
   ddev restart
   ```

   The flag `--sftp-password` becomes the environment variable `SFTP_PASSWORD`.
   Never commit `.ddev/.env`.

2. **Create the Key** at **Configuration → System → Keys**
   (`/admin/config/system/keys`). Add a Key of the **user/password** type, and for
   the key provider choose the environment/dotenv provider so the value is read
   from `SFTP_PASSWORD` at runtime. (Where you need the username stored too, use
   the user‑password key type so both parts are captured.)

This keeps the credential out of config exports and version control.

## 2. Add the SFTP source to a dataset

Go to **Content → Datasets** (`/admin/content/datasets`) and create or edit a
dataset. In its **source/connection** configuration:

- Choose **SFTP** as the source.
- Enter the SFTP server's connection details (host, port, and the path/file to
  fetch — for example the JSON file to import).
- Select the **credential Key** you created in step 1. The module reads the
  username and password from that Key at connection time; the password is never
  stored in the dataset's own configuration.

Save the dataset. When the pipeline runs, the module connects to the SFTP server
over SSH (encrypted in transit), pulls the file, and feeds it into the pipeline.

## Good practice

- Use a **least‑privilege SFTP account** — one that can read only the files this
  pipeline needs, nothing more.
- Treat the **imported files as untrusted** input; lean on your pipeline's
  validation rules to catch malformed or unexpected data.
