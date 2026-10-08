# Audio Clips — manual setup guide

**Audio Clips** (`audio_clips`) provides an Audio Clips API — a small framework
for managing audio clips (MP3 and WAV) as configurable clip *types* and clip
entities. Instead of treating every sound file as a one-off upload, it gives a
site a structured way to store, organize and serve audio clips such as sound
effects, snippets or short recordings through a defined API.

The module is aimed at builders who need audio as first-class data rather than as
a formatter. You define one or more clip types, and clips are then stored and
served through the module's API. Administering those clip types is gated by the
**Administer audio clip types** permission (`administer audio clip types`), so
only trusted roles can change the type definitions.

It is a media/API building block: it does not talk to any external service, and
it supports Drupal 10.1 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, Audio Clips exposes its API and its clip-type management. Grant the
**Administer audio clip types** permission to the roles that should be able to
define clip types, then create the clip types your site needs (for example one
type for sound effects and another for spoken snippets). Clips in MP3 or WAV
format are then stored and served through the API. Because it is an API-first
module, most of the real work happens where other code or configuration
references the clips — there is no dedicated end-user settings page to fill in.
