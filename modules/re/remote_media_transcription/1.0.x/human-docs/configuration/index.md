# Configuration

Remote Media Transcription has a small settings form that controls how the
transcription is *presented*, plus a permission that controls who may administer
it. There are no external services, API keys, or credentials — everything is
local to your site.

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant **Administer
Remote Media Transcription** to the roles that should manage the module's settings.
Keep it to trusted editors and administrators.

## Open the settings form

Go to **Configuration → Media → Remote Media Transcription**
(`/admin/config/media/remote-media-transcription`).

## Settings

- **Default transcription visibility** — whether the transcription is shown or
  hidden by default when the media is displayed. Set it to hidden if you'd rather
  visitors reveal it deliberately with the toggle button, or visible if you want
  it always open.
- **Button labels** — the text shown on the toggle button for showing and hiding
  the transcription (for example "Show transcript" / "Hide transcript"). Word
  these to match your site's voice and language.
- **Animation speed** — how quickly the transcription slides open and closed when
  the button is clicked, for a smooth transition. Choose a speed that feels
  responsive without being jarring.

## Save

Click **Save configuration**. The changes apply to how transcriptions are
displayed across your remote-video media. To add the actual transcription text,
edit a remote video media entity and use the **Video Transcription** WYSIWYG
field (see "How to use it" in the [overview](../index.md)).
