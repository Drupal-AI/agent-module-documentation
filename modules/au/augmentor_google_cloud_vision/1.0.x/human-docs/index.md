# Augmentor: Google Cloud Vision — manual setup guide

**Augmentor: Google Cloud Vision** (`augmentor_google_cloud_vision`) is a provider
plugin for the [Augmentor](https://www.drupal.org/project/augmentor) framework. Where
the text-oriented Augmentor providers work on words, this one works on **images**: it
runs pictures through Google's Cloud Vision API to detect labels, extract text (OCR),
and run safe-search scoring, and makes those results available inside Augmentor's
AI-augmentation workflows. On its own it does nothing — it registers Google Cloud
Vision as an Augmentor provider and waits to be used.

After you install it alongside Augmentor, you create an Augmentor that uses Google
Cloud Vision and apply it where you want images analyzed. Augmentor supplies the
abstraction and the UI; this module supplies the connection to the Vision API.

Two things matter before you rely on it. First, images you analyze are **sent to the
Google Cloud Vision API** — confirm that off-site egress is acceptable, especially for
private or sensitive images. Second, it authenticates with **Google Cloud
credentials** (a service-account key) over HTTPS, which are secrets and must be
handled as such (see below). The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Augmentor) with
   Composer, then enable it.

## How to use it

This provider has no settings page of its own. After installing and enabling it,
configure it from inside Augmentor:

1. Go to Augmentor's admin section and add a new Augmentor.
2. Choose the **Google Cloud Vision** provider.
3. Supply your Google Cloud credentials and choose which Vision features to use
   (labels, OCR/text detection, safe-search, etc.).
4. Save, then apply that Augmentor to the images you want analyzed.

### Handling the Google Cloud credentials safely

Google Cloud Vision authenticates with a **service-account key** (a JSON credential),
not a short password string. Never commit that file or paste its contents into
exported configuration. Keep it out of the codebase and the database:

- Store the credential outside your web root and reference its path (or contents)
  through an environment variable rather than committed config. With DDEV you can set
  an env var without committing it:

  ```bash
  ddev dotenv set .ddev/.env --google-application-credentials=/var/www/html/private/gcp-vision.json
  ddev restart
  ```

  (Keep `.ddev/.env` and the JSON key file out of version control.)

- Where the module or Google's client library supports the standard
  `GOOGLE_APPLICATION_CREDENTIALS` variable, that env var is the cleanest way to hand
  over the credential. Otherwise store the secret via the
  [Key](https://www.drupal.org/project/key) module's env provider so the value lives
  in the environment, not in the database.

Rotate the service-account key periodically and grant it only the Vision permissions
it needs.
