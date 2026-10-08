# Seeds Media — manual setup guide

**Seeds Media** (`seeds_media`) supplies the media types a site normally ends up
creating by hand, plus a set of media-library improvements, as the media layer of
the Seeds distribution. Enable it and you get standard media types and a smoother
editing experience without doing the repetitive first-hour setup yourself.

Every Drupal build repeats the same early media work: create an image type, a
document type, a remote-video type, configure their source fields, set up view
modes, add a media-library view mode, and wire in editing from within the library.
None of it is hard, and all of it is nearly identical from project to project.
Seeds Media ships that configuration. It also pulls in **Media Library Edit**
(`media_library_edit`), which lets an editor edit a media item without leaving the
library — a small change that meaningfully improves how editors work, since the
alternative is opening a second tab and losing the current selection.

On top of the shipped types, Seeds Media adds two behaviours worth knowing about.
**Default Media**: a *Default Media* checkbox appears on media items; tick it to
mark an item as a protected default, which then blocks editing for users who do
not hold a special bypass permission — useful for safeguarding placeholder or
brand assets that many entities rely on. **Media Usability Check**: an optional
warning on the media edit form tells an editor when a media item is currently in
use elsewhere on the site, helping avoid accidental changes to assets that other
content depends on.

One permission deserves attention before you enable this on a real site.
Alongside **Administer Seeds media** (`administer seeds media`), the module defines
**Bypass default media access** (`bypass default media access`), which disables
the normal media-access checks for whoever holds it. That is a legitimate escape
hatch for a distribution — media access in Drupal is genuinely awkward — but grant
it deliberately, to a named role, and never bundle it into a general editor role.
Seeds Media's footprint is much lighter than its sibling `seeds_editor`: nine core
modules and one contrib module.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the *Default
   Media* protection, and the permissions to set carefully.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → Content authoring → Seeds
Media** (config route `seeds_media.settings`). The media types it ships appear
under **Content → Media** and in the media library wherever you add or embed
media.
