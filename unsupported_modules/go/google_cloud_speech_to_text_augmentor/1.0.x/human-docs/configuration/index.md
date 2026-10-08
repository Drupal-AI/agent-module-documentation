# Configuration

There is no dedicated settings page — you configure this by creating a **Key** for
your Google credentials and then adding a **Speech‑to‑Text augmentor** in the
Augmentor UI.

## 1. Prepare Google credentials

1. In the [Google Cloud console](https://console.cloud.google.com/), create (or
   reuse) a project and enable the **Cloud Speech‑to‑Text API**.
2. Create a **service account**, generate a **key**, and download the **JSON**
   credentials file. Place the file somewhere on the server **outside the web root**
   and **out of version control**.

## 2. Store the credentials in a Key entity

This module reads the service‑account file path from a **Key** entity and exposes it
to the Google SDK as the `GOOGLE_APPLICATION_CREDENTIALS` environment variable — so
the secret is never hard‑coded.

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
2. Point the key at the **file location** of your service‑account JSON on the server.
3. Save the key.

## 3. Add a Speech‑to‑Text augmentor

1. Go to **Configuration → Web services → Augmentors**
   (`/admin/config/services/augmentor`) and click **Add augmentor**.
2. Choose the **Google Cloud Speech‑to‑Text** type.
3. Select the **Key** you created in step 2 as the credentials source.

## 4. Tune the recognition settings

The augmentor's form exposes the Speech‑to‑Text recognition options:

- **Encoding** — the audio encoding of your source (for example FLAC, LINEAR16,
  MULAW, OGG_OPUS). Match it to your files.
- **Sample rate (Hertz)** — set it to match the source audio's sample rate.
- **Language code** — a BCP‑47 language/locale code (for example `en-US`) telling
  the API what language to transcribe.
- **Maximum alternatives** — how many alternative transcriptions to request; the
  augmentor returns the top transcript.
- **Profanity filter** — toggle masking of profanity in the returned text.
- **Speech context hints** — optional phrases that bias recognition toward expected
  vocabulary, improving accuracy for names or jargon.

Save the augmentor.

## Using it safely

- **Wire it to trusted sources.** The augmentor reads whatever path/URL it is given,
  server‑side, so connect it to editor‑controlled audio fields or media rather than
  raw request input.
- **Restrict administration.** The **Administer augmentors** permission lets a user
  create and run augmentors — grant it only to trusted roles.
- **Mind the cost.** Every transcription is a billed Google Cloud API call. Keep an
  eye on usage and set quotas/budgets in the Google Cloud console.
