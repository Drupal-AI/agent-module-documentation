# Configuration

Google Cloud Storage File System is configured from its settings form (the
`gcsfs.config` route), where you tell it which bucket to use and how to
authenticate to Google Cloud.

## Open the settings form

1. Log in as a user with the module's administration permission.
2. Open the settings form provided by the `gcsfs.config` route.

## The settings

- **Bucket** — the name of the Google Cloud Storage bucket where files are stored
  and served from.
- **Google credentials** — the service‑account credential the module uses to
  authenticate to GCS. See the security note below.

Save the form to apply your settings. Once configured, the module exposes a stream
wrapper you can use as a file‑field destination so that managed files, images, and
their derivatives are written to the bucket.

## Securing your credentials

This is the security‑critical part of the setup:

- **Store the service‑account credential as a secret** — in an environment
  variable or a mounted key file, **never** in the web root or version control.
  With DDEV: `ddev dotenv set .ddev/.env --google-application-credentials=<path-or-value>`
  then `ddev restart`.
- **Scope the service account** to the specific bucket with least‑privilege
  permissions.
- **Match bucket access controls to file privacy** — the bucket's ACLs and
  public‑access settings determine whether stored files are public or private, so
  configure them to match your needs. Private files must **not** be world‑readable
  in the bucket.
