# Google Cloud Speech-to-Text Augmentor — manual setup guide

**Google Cloud Speech‑to‑Text Augmentor** is an add‑on for the
[Augmentor](https://www.drupal.org/project/augmentor) framework that transcribes
audio into text using Google Cloud's **Speech‑to‑Text** API. You feed it an audio
file and it returns the most‑likely transcript, which you can then store in a field,
chain into another augmentor, or use to build captions and accessibility workflows.

One naming quirk to know up front: the **project** is
`google_cloud_speech_to_text_augmentor`, but the **module you actually enable** is
`augmentor_google_cloud_speech_to_text`. It registers a single Augmentor plugin
(`google_cloud_speech_to_text`) and is configured entirely from inside the Augmentor
admin UI — there is no separate settings page.

Authentication uses a Google Cloud **service‑account JSON** key, supplied through a
**Key** entity rather than hard‑coded. Note that transcription calls Google's API
and is **billed per use**, so wire the augmentor to trusted, editor‑controlled audio
sources rather than raw visitor input.

> **Status:** this module is marked unsupported/obsolete upstream. Evaluate it
> against the current Augmentor and AI module ecosystem before relying on it for new
> work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `google/cloud-speech` library and the Augmentor module) and enable it.
2. [Configuration](configuration/index.md) — create a Key for your service‑account
   JSON, then add and tune a Speech‑to‑Text augmentor.

## Where it lives in the admin menu

Everything happens in the Augmentor UI at **Configuration → Web services →
Augmentors** (`/admin/config/services/augmentor`), which is gated by the
**Administer augmentors** permission. Grant that permission only to trusted roles —
it controls who can create and run augmentors.
