# AmplitudeJS — manual setup guide

**AmplitudeJS** (`amplitudejs`) brings the **AmplitudeJS** HTML5 audio library
into Drupal so you can build custom audio players and playlists on your site.
(Note: despite the similar name, this is unrelated to the Amplitude analytics
service — it is an audio player library.)

The base module integrates the library itself. Its optional submodule,
**`amplitudejs_formatters`**, adds field formatters so that an audio file field
can be rendered as an AmplitudeJS player without you writing any front-end code.

It is a media and content-display feature. Audio files continue to follow core
Media and File access rules, and the module adds no content model or access role
of its own — it is purely about how audio is presented.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and turn on the formatters submodule.

## How to use it

There is no central settings page. To render an audio field as an AmplitudeJS
player, enable the **`amplitudejs_formatters`** submodule, then go to the
**Manage display** screen for the entity holding your audio field and choose the
**AmplitudeJS formatter** for that field. Save the display, and the field renders
as an AmplitudeJS audio player on the front end.
