# Configuration

NeutrinoAPI needs your **API credentials** before any lookup will work. The module
is built to encourage storing them securely, so the recommended path uses the
**Key** module.

## What you will need

From your NeutrinoAPI account, gather:

- Your **user ID**.
- Your **API key**.

Both come from your (non-free) NeutrinoAPI subscription.

## Store the credentials securely with Key

The API key is a secret — do not paste it into plain, exported configuration. The
maintainer strongly recommends the **Key** module. In outline:

1. Make the API key available to the container without committing it. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --neutrinoapi-api-key=<value>
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.) Confirm it is present without
   printing it:

   ```bash
   ddev exec 'test -n "$NEUTRINOAPI_API_KEY"'   # exit 0 means it is set
   ```

2. Create a **Key** entity backed by that environment variable (env provider), for
   example with `drush key:save`, so Drupal reads the secret at runtime rather than
   from stored config.

## Configure the module

1. Open the module's settings form as an administrator.
2. Enter your **user ID**.
3. Select the **Key** that holds your API key (or enter the key directly if you are
   not using the Key module — not recommended for production).
4. Save the form.

## Confirm it works

Enable one of the submodules — the email validator is the easiest to test — and run
a lookup (for example, submit a form that validates an email address). A successful
response from NeutrinoAPI confirms the credentials are correct. Authentication
errors usually mean the user ID or API key is wrong.

## A note on privacy and egress

The data you look up — **email addresses, IP addresses, and user agents** — is sent
to NeutrinoAPI over the network. Always use HTTPS, confirm that sending this data to
a third party is acceptable for your site, and disclose it to users where your
privacy obligations require it.
