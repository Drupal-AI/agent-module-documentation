# Audio Wavesurfer — manual setup guide

**Audio Wavesurfer** (`audio_wavesurfer`) renders an audio file as an interactive
waveform player using the wavesurfer.js library. Instead of a plain playback bar,
the visitor sees the audio's waveform and can click along it to seek — a nice fit
for music, spoken-word recordings or anything where seeing the shape of the sound
is useful. It depends on core's **Media** module and belongs to the Audio package.

An optional submodule, **Audio Wavesurfer Clips** (`audio_wavesurfer_clips`), adds
support for clip *regions* — marking and working with sections within a waveform.

This is a media / content-display feature: it visualises audio you already store.
It has no access-control role of its own — audio files continue to follow core's
normal media and file access rules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide whether to turn on the clips submodule.

## How to use it

Audio Wavesurfer works through display configuration rather than a central
settings page:

1. On the entity's **Manage display** tab, find the audio (media/file) field.
2. Choose the **Wavesurfer** waveform player as its format.
3. Save. The field now renders as an interactive waveform on that view mode.

If you enabled **Audio Wavesurfer Clips**, you can additionally define and work
with clip regions inside the waveform.
