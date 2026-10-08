# Configuration

Media Entity: Unsplash needs **Unsplash API credentials** before it can fetch
anything. This page covers getting those credentials, storing the key as a secret
rather than in plain configuration, and connecting the module.

## 1. Create an Unsplash application and get your access key

1. Sign in at [unsplash.com/developers](https://unsplash.com/developers) and
   register a new application (this is free).
2. Accept the API terms and note your application's **Access Key**. That access
   key is the value the module needs.

Keep the access key private — it identifies your application to Unsplash and is
subject to their rate limits and terms of use.

## 2. Store the access key as a secret (recommended)

Do not paste the access key straight into configuration that gets exported to
code — an API credential does not belong in your Git repository. The robust
pattern on this project is an environment variable surfaced to Drupal through a
**Key** entity.

**On DDEV**, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --unsplash-access-key=<your-access-key>
ddev restart
```

The flag `--unsplash-access-key` becomes the environment variable
`UNSPLASH_ACCESS_KEY`. Keep `.ddev/.env` out of version control.

Then, with the [Key](https://www.drupal.org/project/key) module enabled
(`ddev composer require drupal/key && ddev drush en key -y`), create a Key that
reads the variable — never printing the value itself:

```bash
ddev exec 'test -n "$UNSPLASH_ACCESS_KEY"'   # exit status 0 means it is set
ddev drush key:save unsplash_access_key \
  --label='Unsplash Access Key' --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"UNSPLASH_ACCESS_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## 3. Connect the module

Enter the Unsplash access key where the module's setup asks for it (the project's
README documents the exact configuration screen). If the module lets you select a
**Key** entity, choose the `unsplash_access_key` Key you created above so the
credential stays out of exported configuration. If it only accepts the raw value,
reference the environment variable rather than committing the literal key.

Once the module has a valid access key, adding an Unsplash photo ID or URL to a
media item will fetch the image, store it locally, and attach the photographer
attribution automatically.

## A note on egress and terms

Because the module downloads photos through the Unsplash API, your server makes
outbound requests to Unsplash whenever an editor adds an image — make sure your
environment allows that egress. Also honour Unsplash's API terms and rate limits;
the automatic "Photo by … on Unsplash" attribution the module generates is part of
staying compliant, so leave it in place.
