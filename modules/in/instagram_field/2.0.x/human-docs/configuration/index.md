# Configuration

Connecting Instagram Field is a one-time flow: register an app with Instagram,
enter its credentials on the settings form, wire up the redirect URI, add your
Instagram account as a tester, and authenticate to obtain an access token. Then
add the field to a content type.

## Open the settings form

Go to **Configuration → Web services → Instagram Field** (under
**Administration → Configuration → Services**). Access requires the module's own
permission, so use an account that has it.

## Register an app and connect it

1. At <https://developers.facebook.com>, go to **My Apps → Create App**, choose
   the **Instagram** flow, and under the Products toolbar set up **Instagram Basic
   Display → Create New App**.
2. Copy the **Instagram App ID** and **Instagram App Secret** into the Instagram
   Field settings form, and **save**.
3. Copy the **OAuth redirect URI** shown on the Instagram Field settings form and
   paste it into your app's **Valid OAuth Redirect URIs**.
4. Add your website URL to the app's **Deauthorize Callback URL** and **Data
   Deletion Request URL** fields.
5. In the app, go to **Roles → Roles → Instagram Testers → Add Instagram
   Testers** and add your Instagram account name (then accept the tester invite
   from within Instagram).
6. Back on the Instagram Field settings form, press the **Authenticate** button to
   run the OAuth flow and obtain an **access token**.

Once authenticated, the module fetches your recent posts and refreshes them when
its cache timeout is reached, caching images and links on your server.

> **Treat the App Secret and access token as secrets.** They authenticate to your
> Instagram account, so keep them out of version control and exported
> configuration. On this project's DDEV convention, prefer storing sensitive
> values in environment variables (`ddev dotenv set …`) rather than committing
> them. Remember the token expires and will need re-authenticating over time — and
> see the Basic Display API caveat in the [overview](../index.md).

## Add the field to your content

With the connection working, add an **Instagram** field to a content type (or
paragraph type) at **Structure → Content types → *(your type)* → Manage fields**,
then view an entity of that type to see the recent posts render.

## Further details

The module's README covers additional options; see it for anything not described
here.
