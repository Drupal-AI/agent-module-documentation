# Configuration

Seeds Media works as soon as it is enabled — the media types and the in-library
editing are there immediately. The settings form and permissions below are about
the two protective features and about who is allowed to bypass media access.

## Open the settings form

1. Log in as a user with the **Administer Seeds media**
   (`administer seeds media`) permission.
2. Go to **Configuration → Content authoring → Seeds Media** (config route
   `seeds_media.settings`).

## Media Usability Check

On the settings form there is a **Check Media Usability** option. Turn it on and,
when someone edits a media item that is in use elsewhere on the site, a warning
message appears on the media edit form telling them the asset is referenced by
other content. This is a soft guard against accidental edits to assets that many
entities depend on — it warns, it does not block.

## Default Media protection

Once the module is enabled, each media item gains a **Default Media** checkbox.
Tick it on an item to mark that item as a protected default. Editing of a
Default-Media item is then restricted: only users who hold the **Bypass default
media access** permission can change it. Use this to lock down placeholder images,
brand assets, or any media that must stay consistent across the portal.

## Permissions to set carefully

Seeds Media adds two permissions under **People → Permissions**:

- **Administer Seeds media** (`administer seeds media`) — grants access to the
  settings form above. Give it to administrators only.
- **Bypass default media access** (`bypass default media access`) — disables the
  normal media-access checks (including the Default-Media protection) for whoever
  holds it. This is a powerful escape hatch. Grant it deliberately, to a specific
  named role, and never fold it into a general editor role — otherwise the
  Default-Media protection you set up above is effectively off for those users.

## Save

Click **Save configuration** to store the settings-form options.
