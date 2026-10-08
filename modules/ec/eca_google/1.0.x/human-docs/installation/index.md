# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **ECA** base module (`eca`).
- The **Google API PHP Client** module (`google_api_client`), which holds your
  Google credentials.
- A **Google Cloud** project with the APIs you want to use enabled, plus the
  credentials (API key or service account) created there.

Both module dependencies are pulled in automatically when you require this module
with Composer. You will also want one of ECA's modelling tools (BPMN.iO or the ECA
Classic Modeller) installed, and outbound HTTPS access to Google's APIs.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_google -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and the Google
API PHP Client module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_google -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_google -y
```

This also enables `eca` and `google_api_client` if they are not already on.

## Service submodules

ECA: Google is a suite. After you have set up credentials (see the main guide),
enable the service submodule(s) that match the Google APIs you enabled in your
Cloud project — for example **ECA: Google Sheets** or **ECA: Google Meet**. Enable
only the services you actually use.

## Verify it worked

Configure Google authentication on the Google API PHP Client module and confirm it
authenticates. Then open an ECA model at **Configuration → Workflow → ECA**, add an
action, and confirm the Google actions (from the service submodule you enabled)
appear in the list.
