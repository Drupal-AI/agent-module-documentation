# Configuration

You configure Bureau Works the same way you configure any TMGMT translation
provider: by adding a **translator** in TMGMT and pointing it at the Bureau Works
plugin.

## Add the Bureau Works translator

1. Log in as a user who can administer TMGMT.
2. Go to **Translation → Providers** (`/admin/tmgmt/translators`).
3. Add a provider and choose the **Bureau Works** plugin as its translator type.
4. Enter the Bureau Works **API credentials** the platform issued to you. The
   connector uses these to sign and authenticate the requests it sends.

Once saved, Bureau Works becomes selectable when you create a TMGMT job and
choose who should translate it.

## Handling the API credentials safely

The credentials are a secret. Do not paste them into a file you commit, and do
not let them end up in exported configuration that lands in version control.

The safe pattern on this project is to keep the secret in an environment variable
and reference it, rather than typing it into committed config:

1. Store the value with DDEV's dotenv helper (this writes to `.ddev/.env`, which
   is **not** committed):

   ```bash
   ddev dotenv set .ddev/.env --bureau-works-api-key=<value>
   ddev restart
   ```

   The flag `--bureau-works-api-key` becomes the variable `BUREAU_WORKS_API_KEY`
   inside the container.

2. Where the module accepts a **Key** entity, install the
   [Key](https://www.drupal.org/project/key) module and create a Key backed by
   the environment provider so the credential is read from that variable at
   runtime instead of being stored in config.

If you must enter the credential directly on the provider form, exclude that
piece of configuration from your exported/committed config so the secret never
reaches version control.

## Before you send content

Because jobs sent through this provider leave your site for the Bureau Works
platform, confirm with your team that sending the content — including drafts and
anything sensitive — to that external service is acceptable. The connector has no
access-control role of its own; TMGMT's own permissions govern who can create and
manage translation jobs.
