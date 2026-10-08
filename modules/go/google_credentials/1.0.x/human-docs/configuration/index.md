# Configuration

Configuration is a single step: give the module your Google Cloud service‑account
credentials so other modules can reuse them.

## Store your credentials

1. Log in as a user with permission to administer the module's configuration.
2. Go to **Configuration → Google → Google Cloud Credentials**.
3. **Upload your Google Cloud service‑account credentials JSON file.**
4. **Save** the settings. The credentials are now stored centrally and can be
   retrieved by other Google Cloud modules in your site.

## Getting the service‑account JSON

If you don't already have it:

1. In the [Google Cloud console](https://console.cloud.google.com/), open (or
   create) a project and enable the Google Cloud APIs your other modules need.
2. Create a **service account** with the appropriate permissions for those APIs.
3. Generate a **key** for it and download the **JSON** file.

## Storing the key securely

The JSON key is a real secret — anyone who has it can act as the service account.

- Do **not** commit it to version control, and avoid exporting it into
  version‑controlled configuration.
- Prefer an **environment‑backed** approach or a **mounted key file** kept outside
  the web root. With DDEV, you can hold a secret out of the repository using its
  dotenv support and reference it at runtime rather than baking it into config.
- If the key is ever exposed, **rotate it** in the Google Cloud console and update
  the stored value.

Once saved, other Google Cloud integration modules on the site can retrieve these
credentials automatically — you should not need to enter them again elsewhere.
