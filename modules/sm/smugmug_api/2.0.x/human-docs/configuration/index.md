# Configuration

SmugMug API needs just two values — an API key and secret — before its services
can talk to SmugMug.

## Register your application with SmugMug

1. Visit **https://api.smugmug.com/api/developer/apply**.
2. Register your application. SmugMug gives you an **API Key** and an **API
   Secret**.

## Enter the credentials in Drupal

1. Log in as an administrator and go to **Configuration → Media → SmugMug API**,
   or navigate directly to **`/admin/config/media/smugmug_api`**.
2. Enter the **API Key**.
3. Enter the **API Secret**.
4. Click **Save**.

Once the form is saved, the connection is ready and the module's services can make
authenticated calls to SmugMug.

## Keep the credentials secret

The API key and secret authenticate your site to SmugMug, so treat them as
secrets: keep them out of exported configuration and out of version control (for
example by supplying them via an environment variable or a Key entity where your
workflow allows), and rely on the HTTPS connection the module's Guzzle‑based client
uses.
