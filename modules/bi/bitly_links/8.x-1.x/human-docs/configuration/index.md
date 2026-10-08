# Configuration

Bitly Links needs a one-time authorization before it can shorten URLs. All of the
pages below require the **Access administration pages** permission.

## 1. Register a Bitly OAuth app

In your Bitly account, create an OAuth application to obtain a **client ID** and
**client secret**. You will also set the app's redirect URL to the module's
authorization callback on your site (`/bitly_links/authorization`).

Treat the client ID, client secret, and the resulting access token as **secrets**.
The module stores them in Drupal's `State` storage, which keeps them out of your
exported site configuration — do not copy them into committed config files. If you
manage other credentials on this site through environment variables (for example
with DDEV's `ddev dotenv set` and a Key entity, or `getenv()` in `settings.php`),
keep to the same discipline of never committing the raw values.

## 2. Run the authorization flow

1. Enter your Bitly client ID and secret on the module's admin pages.
2. Go to **`/admin/bitly_links/authorize`** and start the authorization. Bitly
   sends you back to `/bitly_links/authorization`, where the module exchanges the
   returned code for an access token and stores it in `State`.

## 3. Check the token and test shortening

- An **access-status page** shows whether the module currently holds a valid token.
- **`/admin/bitly_links/shorten_test`** lets you verify connectivity by shortening
  a test URL through the Bitly v4 `/v4/shorten` endpoint.

## Node integration

A settings form provides options for attaching generated short links to your node
workflows. Once the app is authorized and the token is stored, the module can
generate a Bitly short URL for a node by calling the Bitly API with a Bearer
access token.

If a call fails, the module logs the exception to the `bitly_links` log channel —
check **Reports → Recent log messages** when troubleshooting.
