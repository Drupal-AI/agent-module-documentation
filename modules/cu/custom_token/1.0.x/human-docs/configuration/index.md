# Configuration

Custom Token's whole point is the two-store model: **keys travel with your code,
values stay per environment.** This page walks through defining tokens and rolling
them out safely.

## Who can manage tokens

The settings form is guarded by the **`administer custom token`** permission,
which is a *restricted* permission — grant it only to trusted administrators. As
with any permission, you assign it on Drupal's core **People → Permissions** page.

## Open the settings form

1. Log in as a user with **`administer custom token`**.
2. Go to **Configuration → System → Custom Token**
   (`/admin/config/system/custom_token`).

## Define tokens

The form is a table of **key** + **value** rows, with AJAX buttons to add and
remove rows:

- **Key** — the token's machine name, such as `general_email`. Keys are validated
  to lowercase letters, digits, and underscores (`[a-z0-9_]+`). Duplicate keys are
  rejected and empty rows are skipped. The form previews the exact token string
  (for example `[custom_token:general_email]`) so you can copy it.
- **Value** — the actual string this environment should use for that key (for
  example a real email address).

When you save, the module writes the **keys** to configuration
(`custom_token.settings`) and the **values** to the State system, then refreshes
the token information. The keys are now exportable; the values are not.

## Deploy across environments

The recommended workflow keeps sensitive values out of your repository:

1. On any environment, add your keys (and that environment's values) on the form,
   then run:

   ```bash
   drush config:export
   ```

2. **Commit the exported config** — this carries the token *keys* only. The values
   remain in each site's State and are never committed.
3. On another environment, import the config and set that environment's own
   values:

   ```bash
   drush config:import
   ```

   Then open the settings form there and enter the real values for that
   environment.

This way development, QA, and production all share the same token *structure* while
each keeps its own private values — so, for example, QA notifications never reach a
production client's inbox.

## Using a token

Reference `[custom_token:<key>]` anywhere token replacement runs. In particular:

- In **Webform email handler** fields — the To address (`to_mail`) and the options
  mapping (`to_options`, e.g. a purpose → email map) are resolved by the module in
  addition to Webform's own token handling.
- In email **subject lines** and **bodies**, and any other token-enabled field.

## A note on token values

Keep token values **plain text**, and keep the restricted `administer custom
token` permission tightly held.

## Uninstalling

Uninstalling the module cleans up its State entry (the stored values)
automatically.
