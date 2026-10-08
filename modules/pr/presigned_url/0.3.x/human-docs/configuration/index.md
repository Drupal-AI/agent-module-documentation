# Configuration

The security of every presigned URL rests on one secret — the **private signing
key**. Configuring this module is mostly about supplying that key safely, then
minting links with an expiry.

## How the signature works

When a URL is signed, the module computes:

```
signature = hash_hmac('sha256', "host:uri:date:expires:algorithm", PRIVATE_KEY)
```

and appends both the signature and an expiry parameter (`psu-expires`) to the URL.
When the link is requested, the module recomputes the signature from the same
parts and compares it. If the recomputed value matches **and** the expiry is still
in the future, access is granted; otherwise the link is rejected. Because the
private key is the only secret in that formula, anyone who has it can forge valid
links — so protecting the key is the whole game.

## Provide and protect the signing key

**Never** hard-code the private key in code that is committed, or paste it into
configuration that gets exported to your repository. Store it in an environment
variable and reference it from Drupal.

With DDEV, save the key into the project's env file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --presigned-url-key=<a-long-random-secret>
ddev restart
```

Keep `.ddev/.env` out of version control. Where the module supports it, prefer a
**Key** entity backed by that environment variable rather than storing the raw
secret in configuration — install the
[Key](https://www.drupal.org/project/key) module if it is not already enabled and
create an env-provider key that reads the variable. Either way, the goal is the
same: the signing key lives in the environment, not in your codebase or exported
config.

Choose a long, random value for the key, and treat rotating it as invalidating
every outstanding link (all previously signed URLs stop validating once the key
changes).

## Set the expiry and mint a URL

Generate a signed, time-limited URL with the Drush command:

```bash
drush presigned-url:sign <arguments>
```

The command returns a URL carrying the signature and a `psu-expires` timestamp.
Choose an expiry that is as **short as the use case allows** — long enough for the
recipient to download the file, but no longer, since anyone who obtains the link
can use it until it expires. Run `drush presigned-url:sign --help` to see the exact
arguments and expiry option for your installed version.

## Test before relying on it

Because this module is early-stage, verify the full round trip on a non-production
copy: mint a link, confirm it grants access before expiry, confirm it is rejected
after expiry, and confirm a tampered signature is rejected.
