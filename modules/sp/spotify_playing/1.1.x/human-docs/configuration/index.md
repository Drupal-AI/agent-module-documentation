# Configuration

To show your now‑playing track, Spotify Now Playing has to be authorised against a
Spotify app you own. This is a short round trip between the Spotify Developer site
and the module's settings page.

## Step 1 — create a Spotify app

1. Go to the [Spotify Developer site](https://developer.spotify.com/) and sign in.
2. Create a new **App**. Spotify gives you a **Client ID** and a **Client
   Secret** for it.

## Step 2 — enter your credentials in Drupal

1. Log in to Drupal as an administrator.
2. Open the Spotify Now Playing settings page.
3. Paste in the **Client ID** and **Client Secret** from your Spotify app.
4. The settings page displays the **Redirect URI** you need — copy it.

## Step 3 — finish the app setup on Spotify

Back in your Spotify app's settings, add the **Redirect URI** you copied from the
Drupal settings page. This lets the OAuth authorisation complete so the module can
read your currently playing track.

## Keep the credentials secret

The Client Secret and the OAuth tokens the module obtains are secrets. Store them
in an environment variable (or a Key entity) rather than committing them, and make
sure the exchange happens over HTTPS.

## A note on what you expose

If you use the JSON endpoint publicly, remember it reveals what you are currently
listening to. That is usually the point — but only expose the data you actually
intend to make public. Access to the module's features is governed by the
permissions it provides, which you can assign at **People → Permissions**.
