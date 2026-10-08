# Configuration

Configuring IP2Location API is a two‑step job: store your API key as a **Key**
entity, then tell the module to use it.

## Step 1 — Get an IP2Location API key

Sign up at [ip2location.com](https://www.ip2location.com) and copy your
IP2Location.io API key from your account.

## Step 2 — Store the key as a Key entity

Because the module depends on the Key module, your secret is kept out of plain
configuration. The most robust approach is to keep the key in an environment
variable and reference it from a Key entity:

1. Save the key into your environment. With DDEV:
   ```bash
   ddev dotenv set .ddev/.env --ip2location-api-key=your-key-here
   ddev restart
   ```
   Keep `.ddev/.env` out of version control.
2. Go to **Configuration → System → Keys → Add key**
   (`/admin/config/system/keys/add`).
3. Set the **Key type** to **IP2 Location API Key** (the type this module
   provides).
4. For the **Key provider**, choose **Environment** and point it at the
   `IP2LOCATION_API_KEY` variable — so the secret is read from the environment,
   never stored in the database or a config export.
5. Save the key.

If you are not using environment variables, the Key module can also store the
value in configuration or a file, but an environment‑backed key is the safest
option.

## Step 3 — Select the key in the module settings

1. Go to **Configuration → System → IP2Location settings**
   (`/admin/config/system/ip2location-settings`).
2. Select the Key you just created.
3. Save.

The service now authenticates to IP2Location using that key.

## Handling IP data

The IP addresses you look up (and the location data returned) are personal data.
Handle and retain them in line with your site's privacy policy, and communicate
with the API over HTTPS.
