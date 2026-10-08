# Configuration

Setting up Login.gov is different from a typical "paste in a client secret" OAuth
integration. Login.gov authenticates your site with **private‑key JWT**: your site
holds a **private signing key**, and Login.gov holds only the matching **public
key**. There is no shared secret to leak. The work, in order, is: create the key
pair, store the private key safely, register the public key with Login.gov, then
wire up the OpenID Connect client.

## Step 1 — Generate the signing key pair

Generate an RSA key pair for signing token requests (for example with `openssl`).
You will register the **public** half with Login.gov and keep the **private** half
on your site — protected, never in configuration or version control.

## Step 2 — Store the private key securely (DDEV + Key entity)

The private key must live in secret storage, not in exported config. The
recommended pattern is an **environment variable** consumed by a **Key entity**.

On DDEV, store the value as an environment variable and load it into the web
container:

```bash
ddev dotenv set .ddev/.env --login-gov-private-key="$(cat private_key.pem)"
ddev restart
```

Keep `.ddev/.env` out of version control. Confirm the variable is present in the
container **without printing its value**:

```bash
ddev exec 'test -n "$LOGIN_GOV_PRIVATE_KEY"'   # exit status 0 means it is set
```

Then create a **Key entity** (at **Configuration → System → Keys**,
`/admin/config/system/keys`) that reads from the environment variable using the
Key module's environment provider. Asymmetric Keys (`key_asymmetric`) provides the
private/public key type Login.gov needs. This keeps the secret out of the database
and out of your configuration export, and makes **rotation** a matter of swapping
the environment value rather than editing config.

> For a non‑DDEV host, set the same environment variable through your hosting
> platform's secret mechanism (or a KMS) and point the Key entity at it. The
> principle is identical: the private key is referenced, never stored in Drupal
> config.

## Step 3 — Register with Login.gov

In the Login.gov dashboard (sandbox first), register your application and upload
the **public** key. Record the client/issuer identifier Login.gov assigns and the
redirect URI(s) your site will use. Remember that **the sandbox and production
environments are separate registrations** — you'll repeat this for production.

## Step 4 — Configure the OpenID Connect client

Go to **Configuration → People → OpenID Connect**
(`/admin/config/services/openid-connect`) and set up the Login.gov client:

- Point it at the correct **Login.gov environment** (sandbox vs production).
- Provide the **client/issuer identifier** from your registration.
- Select the **Key entity** holding your private signing key (from Step 2).
- Set the **IAL and AAL levels** (identity‑proofing and authentication assurance),
  including requiring MFA or PIV/CAC where your programme demands it. Treat these
  as a **programme policy decision** — they determine who can complete
  registration.

## Step 5 — Decide account linking

Before going live, decide what happens when a Login.gov identity arrives whose
email matches an existing local account. Automatically linking accounts by email
is a **security** decision, not merely a convenience — make it deliberately within
OpenID Connect's account‑connection settings.

## Verify and promote to production

Test the full login round‑trip against the **sandbox** first. Only once that works
end to end, repeat the registration and configuration for the **production**
Login.gov environment with its own key registration and client details.
