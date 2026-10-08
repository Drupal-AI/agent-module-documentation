# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **Augmentor** module (`augmentor`).
- The **Google Cloud Speech** PHP library (`google/cloud-speech:^1.6`).
- A Google Cloud project with the **Speech‑to‑Text API** enabled and a
  **service‑account JSON** key — see [Configuration](../configuration/index.md).
- The **Key** module (`drupal/key`) to hold the service‑account credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/google_cloud_speech_to_text_augmentor -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the `google/cloud-speech`
library and the Augmentor dependency alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_cloud_speech_to_text_augmentor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Remember: the machine name to enable is **`augmentor_google_cloud_speech_to_text`**,
not the project name.

```bash
drush en augmentor_google_cloud_speech_to_text -y
```

If the Key module isn't already enabled, add it too:

```bash
drush en key -y
```

## Verify it worked

Go to **Configuration → Web services → Augmentors**
(`/admin/config/services/augmentor`). When you add a new augmentor you should now
see **Google Cloud Speech‑to‑Text** among the available augmentor types. Continue to
[Configuration](../configuration/index.md).
