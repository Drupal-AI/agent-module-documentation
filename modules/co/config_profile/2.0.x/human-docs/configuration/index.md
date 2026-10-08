# Configuration

Config Profile is configured in one small form, and then it works automatically whenever you
export configuration.

## Open the settings form

1. Log in as a user who can synchronize configuration (an administrator by default).
2. Go to **Administration → Configuration → Development → Synchronize**, then open the
   **Profile** tab.

## Choose the target profile

- **Profile** — select the installation profile you want the active configuration exported
  into on every `drush config:export`. This is the profile whose shipped configuration you
  are keeping in sync with the working site.
- **Configuration to exclude** *(optional)* — specify a set of config entities that you do
  **not** want written into the installation profile. Use this for anything that should stay
  out of the profile even though it exists on your site.

Save the form.

## How export behaves after this

Once a target profile is set, Config Profile hooks into the standard export command:

```bash
drush config:export
```

This still exports to your site's normal configuration directory as usual — you do **not**
need to point your site's config directory at the profile. As a *side effect*, it **also**
writes the changed configuration into the profile's directories, recursively, placing each
config object where it belongs (including inside any modules bundled in the profile). UUIDs
are stripped from the profile copies so the configuration can be imported anywhere.

## Important notes

- **Export only reflects what has changed** relative to your site's main configuration store.
  If you are not seeing the changes you expect in the profile, empty the main config export
  directory first and re‑run the export — otherwise you can get an incomplete set of changes.
- **Always review where each config entity landed before committing.** Placing a config entity
  in the wrong directory (`config/install`, `config/optional`, and so on) can break your
  installation profile. Treat the profile export as something to inspect, not blindly commit.

## Verify it worked

After setting the profile and running `drush config:export`, check your profile's config
directories (for example `profiles/my_profile/config/install`) and confirm your changed
configuration appears there with UUIDs removed. If it does, Config Profile is doing its job.
