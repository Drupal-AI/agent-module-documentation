# Configuration

Scribit.pro needs a few things wired up before it can submit videos: your API token
stored as a Key, your credentials entered on the settings form, and a Remote Video
media type whose form and display use the Scribit widget and formatter.

## 1. Store the API token with the Key module

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and choose
   **Add key**.
2. Set the key **type** to *Authentication* and paste your Scribit.pro **API
   token** (from your Scribit.pro account) as the key value.
3. Save the key. Storing it as a Key entity keeps the token out of plain
   configuration.

## 2. Enter your Scribit credentials

1. Go to **Configuration → System → Scribit Pro**
   (`/admin/config/system/scribit-pro`). You need the **Administer Scribit Pro**
   (`administer scribit pro`) permission.
2. Set **Scribit ID** to your Scribit ID.
3. Set **API token** to the Key you created in step 1.
4. Save.

## 3. Create (or reuse) a Remote Video media type

If you do not already have one: go to **Structure → Media types → Add media type**,
choose the **Remote video** source, and save.

## 4. Set the widget and formatter on the media type

- **Manage form display:** set the *Remote video URL* field's widget to **Scribit
  Pro oEmbed URL**. Editors will then be able to pick the services they want
  (subtitles, audio description, transcript, sign language), choose the desired
  **voice gender and language**, mark a request **urgent**, and add **remarks** for
  the Scribit.pro team.
- **Manage display:** set the *Remote video URL* field's formatter to **Scribit Pro
  formatter**. Its settings include a **maximum width** and **maximum height** for
  the rendered player.

## 5. The submission flow

When an editor saves a Remote Video media entity, the widget submits the video and
the requested services to the Scribit.pro API using the authenticated Bearer token
(with a 30-second timeout, and a guard that prevents duplicate submissions within a
request). Once Scribit.pro finishes processing the video, the **Scribit Pro
formatter** renders the accessible player on the front end.

## A note on the callback route

The module registers a public callback at `/scribit-pro/callback`, intended for
Scribit.pro's server to call after it finishes processing. In this version that
callback is an **unimplemented stub**: it only redirects to the front page and
changes no state, so it is effectively inert and there is nothing to configure for
it. If a future version implements it, the code notes it must validate the incoming
request's origin/signature before acting.
