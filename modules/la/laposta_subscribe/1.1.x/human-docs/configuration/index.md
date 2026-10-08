# Configuration

Setting up Laposta Subscribe has three parts: store your Laposta API key safely,
connect the mailing list on the module's settings form, and place the subscribe
block.

## Who can configure it

The module provides an **`administer laposta subscribe`** permission. Grant it
(under **People → Permissions**) only to trusted roles, since it controls the
Laposta connection.

## Store the Laposta API key safely

The API key is a secret. Never hard‑code it or commit it to version control. On
this project, keep it in an environment variable:

1. Save the key into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --laposta-api-key=<value>
   ddev restart
   ```

   The flag `--laposta-api-key` becomes the environment variable
   `LAPOSTA_API_KEY`. Keep `.ddev/.env` **out of version control**.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$LAPOSTA_API_KEY"'   # exit status 0 means it is set
   ```

3. Where the module supports a **Key** entity, create one backed by the
   environment provider and select it in the settings form, so the key never lands
   in plain configuration. If the settings form takes the key directly, make sure
   that configuration is **not exported and committed** with the secret in it.

## Connect your Laposta list

1. Log in as a user with **`administer laposta subscribe`**.
2. Open the module's settings form (linked from the modules list, or under
   **Configuration**).
3. Provide the **API key** (or select the Key entity holding it) and choose the
   **Laposta list** subscribers should be added to.
4. If you have the **Honeypot** module enabled, turn on its protection for the
   form here to reduce spam sign‑ups.
5. **Save.**

## Place the subscribe block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. **Place block** in your chosen region and pick the **Laposta subscribe** block.
3. Set the usual block visibility and region settings, and **Save block**.

If you want to restyle the form, override the module's included **Twig template**
in your theme.

## Privacy and consent

Because the form sends **subscriber data to Laposta**, you are processing personal
data. Make sure the form makes the purpose clear and captures appropriate consent,
consistent with your privacy policy and applicable regulations.

## Verify

View the page with the block as a normal visitor, submit a test address, and
confirm it appears in the correct Laposta list. Check that validation errors show
sensibly and, if configured, that Honeypot is blocking obvious spam.
