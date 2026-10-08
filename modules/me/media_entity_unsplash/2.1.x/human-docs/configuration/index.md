# Configuration

Media Entity: Unsplash needs **Unsplash API credentials** before it can fetch
anything. This page covers creating an Unsplash application, getting your keys, and
connecting the module.

## 1. Create an Unsplash application and get your keys

1. Sign in at [unsplash.com/developers](https://unsplash.com/developers) (or
   [unsplash.com/oauth/applications](https://unsplash.com/oauth/applications)) and
   register a new application — this is free.
2. Accept the API terms and fill in the application details.
3. Once created, note the two values the module needs:
   - **Access Key** — your application's public identifier.
   - **Secret Key** — your application's private key.

These credentials are subject to Unsplash's rate limits and terms of use.

## 2. Connect the module

The Unsplash media type ships with the module. Enter your credentials on its
configuration form:

1. Go to **Structure → Media types** (`/admin/structure/media`).
2. Open **Edit** for the **Unsplash** media type
   (`/admin/structure/media/manage/unsplash`).
3. In the source configuration section, fill in:
   - **Access key** — the Access Key from your Unsplash application (required).
   - **Secret key** — the Secret Key from your Unsplash application (required).
   - **UTM Source** — the tracking parameter added to attribution links; use your
     application or site name (defaults to `drupal_media_entity_unsplash`).
   - **Generate thumbnails** — leave checked to have Drupal build local thumbnails
     from the Unsplash images.
4. Save the media type.

Without valid credentials the module cannot add Unsplash images, and it will show
an error with a link back to this configuration page.

## 3. Add a photo

Once the credentials are saved, go to **Content → Media → Add media → Unsplash**.
Start typing keywords to search Unsplash from the autocomplete, or paste a photo ID
or full URL (for example, in
`https://unsplash.com/photos/2ptmnitpUcg` the ID is `2ptmnitpUcg`). Save the item;
the module downloads the image, stores it locally under
`public://unsplash_thumbnails`, and populates the attribution field with the
"Photo by … on Unsplash" credit.

Only users with the **Create Unsplash media** (or edit) permission can use the
search and add Unsplash media, so grant those permissions to the roles that need
them under **People → Permissions**.

## A note on egress and terms

Because the module downloads photos through the Unsplash API, your server makes
outbound requests to Unsplash whenever an editor searches for or adds an image —
make sure your environment allows that egress. Also honour Unsplash's API terms and
rate limits; the automatic "Photo by … on Unsplash" attribution the module
generates is part of staying compliant, so leave it in place.
