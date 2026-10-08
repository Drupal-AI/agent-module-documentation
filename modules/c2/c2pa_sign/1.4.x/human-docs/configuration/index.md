# Configuration

Configuring C2PA Sign means giving it the **signing certificate and private key**
it uses to sign media. Because signing on upload and publish is automatic, the
configuration is mostly about supplying that key — and doing so safely.

## The signing key is a secret — handle it accordingly

The private key and certificate are what prove your media came from you. If they
leak, someone else can forge provenance in your name. So:

- **Never** commit the key or certificate to the codebase.
- **Never** let the key end up in exported/committed configuration.
- Store it in a proper key store, an HSM, or an environment variable.
- Protect it, restrict who can read it, and rotate it per your security policy.

On this project, the safe pattern is to keep the secret in an environment variable
rather than in config:

1. Store the value with DDEV's dotenv helper (this writes to `.ddev/.env`, which
   is **not** committed):

   ```bash
   ddev dotenv set .ddev/.env --c2pa-signing-key=<value>
   ddev restart
   ```

   The flag `--c2pa-signing-key` becomes the variable `C2PA_SIGNING_KEY` inside the
   container.

2. Where the module supports a **Key** entity, install the
   [Key](https://www.drupal.org/project/key) module and create a Key backed by the
   environment provider so the credential is read from that variable at runtime
   instead of being stored in config.

If the module instead expects a certificate/key **file path**, place the file
outside the web root (or in the private file scheme), reference it by path, and
keep the file itself out of version control.

## Point the module at the certificate and key

In the module's settings, provide the signing certificate and key by the method
the module offers (a Key entity, an environment variable, or a file path as
above). Once set, C2PA Sign signs compatible media assets automatically when they
are uploaded and published — no per-asset action is needed.

The module has no access-control role of its own; it only adds provenance
signatures.
