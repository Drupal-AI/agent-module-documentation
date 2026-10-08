# Audio Recorder — manual setup guide

**Audio Recorder** (`audiorecorder`) adds a field widget that records audio
directly in the visitor's browser and saves it to a file field. Collecting
audio — a voice note, a pronunciation, a short interview clip — normally means
recording somewhere else and uploading the result; this widget removes that step
by capturing the audio in the page itself using the vmsg HTML5/JavaScript library.

Because it uses the browser's media APIs, recording requires **HTTPS** and the
visitor's **microphone permission** — the browser will prompt before it will
record. There is no unusual server-side surface: the recorded file is stored and
access-controlled exactly like any other file upload, so confirm the field's file
settings (allowed extensions, and **private storage** if the recordings are
sensitive).

An optional submodule, **Audio Recorder Webform Integration**
(`audiorecorder_webform_integration`), makes the recorder available on Webform
forms so you can collect audio from anonymous or authenticated form submissions.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide whether to turn on the Webform submodule.

## How to use it

1. Add a **file field** to your content type (or use an existing one) for the
   audio.
2. On the **Manage form display** tab, set that field's widget to the **Audio
   Recorder** widget.
3. Make sure the site is served over **HTTPS** — the browser will not grant
   microphone access otherwise.
4. If the recordings are sensitive, set the file field to **private** file storage
   and restrict who can view the field.

When editors (or, via the Webform submodule, form users) open the form, they can
record audio in place, and the recording is saved to the file field.
