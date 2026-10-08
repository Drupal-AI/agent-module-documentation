# Configuration

Configuration has three parts: connect the module to your Riddle account, grant
the right people permission, and then import and embed riddles.

## 1. Enter your Riddle API credentials

The module talks to riddle.com over the Riddle API, so it needs your account's API
token. Open the module's settings form (as a user with the module's administration
permission) and enter the Riddle API credentials/token, then save.

> **Treat the API token as a secret.** Do not paste it into configuration that gets
> committed to Git. Store the value in an environment variable and, where the module
> accepts one, a [Key](https://www.drupal.org/project/key) entity:
>
> 1. With DDEV, save the value with the built-in dotenv helper —
>    `ddev dotenv set .ddev/.env --riddle-api-token=<value>` — and keep
>    `.ddev/.env` out of version control, then `ddev restart`.
> 2. Install and enable the Key module if it isn't already
>    (`ddev composer require drupal/key && ddev drush en key -y`).
> 3. Create a Key backed by the environment variable and reference it from the
>    module's settings instead of pasting the raw token.
>
> Your environment must also be allowed to make **outbound (egress)** requests to
> riddle.com, or importing will fail.

## 2. Grant permissions

Riddle Marketplace provides its own permission that gates configuring the
integration and importing riddles. Go to **People → Permissions**
(`/admin/people/permissions`), find the module's permission, and grant it only to
the trusted editorial/administrative roles that should manage riddles. Save.

## 3. Import and embed riddles

Once the credentials are in place:

- **Import** the riddles you created on riddle.com into Drupal. Imported riddles
  become **Riddle media** (with the `media_riddle_marketplace` submodule enabled),
  so they appear in your media library and can be reused across content.
- **Embed** a riddle in content either by referencing the Riddle media through a
  media field / the media library, or with the **CKEditor embed button** while
  writing in the rich-text editor.

## A note on privacy

The interactive content runs on and is served by Riddle, and participant responses
are handled by Riddle rather than your site. Depending on your audience and
jurisdiction you may need to disclose this in a privacy notice and/or gate the
embed behind cookie/tracking consent.
