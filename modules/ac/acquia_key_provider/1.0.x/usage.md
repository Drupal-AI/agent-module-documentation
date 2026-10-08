Adds an "Acquia file" key provider to the Key module that reads a secret from an Acquia Cloud environment's backup-excluded `/mnt/gfs/[app].[env]/nobackup/` directory.

---

Acquia Key Provider is a small Security-package add-on for the contributed Key module. It registers a single KeyProvider plugin, `acquia_file`, that sources a key's value from a file living in the Acquia Cloud platform's recommended private-information location: the per-environment `nobackup` directory under `/mnt/gfs/`, which Acquia excludes from disaster-recovery backups. The provider derives the site group and environment from the `AH_SITE_GROUP` and `AH_SITE_ENVIRONMENT` environment variables that Acquia sets on every hosted environment, then reads the file `/mnt/gfs/[AH_SITE_GROUP].[AH_SITE_ENVIRONMENT]/nobackup/[file_name]` at retrieval time. Only the file name (plus two flags — strip trailing line breaks, and Base64-decode for encryption keys) is stored in configuration; the secret itself is never entered into a form, stored in Drupal config, or written to the database, so it stays out of config exports and version control. It is the Acquia-native alternative to the core-adjacent File key provider, which lacks a stable cross-environment path on Acquia Cloud Next.

---

- Store an API token, database password, or third-party secret in an Acquia environment's `nobackup` directory and expose it to Drupal as a Key entity.
- Keep secrets out of configuration exports, `settings.php`, and the git repository while still managing them through the Key module UI.
- Give each Acquia environment (dev, test, prod) its own copy of a secret under the same key configuration, resolved automatically per environment via `AH_SITE_GROUP`/`AH_SITE_ENVIRONMENT`.
- Provide credentials to modules that consume Key entities (mail/SMTP, payment gateways, AI providers, search backends, encryption) on Acquia hosting.
- Supply an encryption key (via the Encrypt/Key ecosystem) whose raw bytes are Base64-encoded in the file and decoded on read.
- Avoid the disaster-recovery-backup exposure of secrets by using Acquia's backup-excluded storage path.
- Replace heavy-handed alternatives (config splits or `settings.php` overrides) for per-environment secret management on Acquia.
- Rotate a secret by replacing the file on the Acquia environment over SSH, with no configuration or code deploy required.
- Create the key file per environment via SSH/Cloud Platform, then reference it by name in a Key entity.
- Use with the Key module's key-type/value abstractions so consuming code calls `getKeyValue()` without knowing where the secret lives.
- Serve as the secrets backend for Acquia CMS or other Acquia-hosted distributions.
- Strip a trailing newline that a shell `echo >` may have appended to the secret file, so the retrieved value matches the exact credential.
- Warn site builders during configuration when the environment does not look like an Acquia host (missing `AH_SITE_*` variables), guiding local-development mocking.
- Validate at configuration time that the referenced file exists and is readable before saving the key.
- Centralize credential management for multiple modules behind one platform-managed storage location.
- Support local development by temporarily setting the `AH_SITE_GROUP`/`AH_SITE_ENVIRONMENT` variables and providing a matching local file.
- Swap the file-read and environment-read behavior in automated tests via the module's small reader-service interfaces.
- Adopt Acquia's documented best practice for storing private information in the file system without writing custom key-provider code.
- Keep production credentials readable only by the Acquia environment's filesystem permissions rather than by anyone with Drupal config-import access.
