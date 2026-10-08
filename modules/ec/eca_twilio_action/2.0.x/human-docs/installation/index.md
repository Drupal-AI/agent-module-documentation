# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.
- The **Twilio** module (`twilio`) — provides the SMS service and holds your
  Twilio credentials.
- The **Token** module (`token`) — supports the token replacement in the number
  and message fields.
- A **Twilio account** with an account SID, auth token and an SMS‑capable
  from‑number.

Drupal will enable the module dependencies automatically. There are no
third‑party PHP library requirements beyond what the Twilio module needs.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_twilio_action -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_twilio_action -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_twilio_action -y
```

This also enables `eca`, `twilio` and `token` if they are not already on.

## Configure Twilio credentials securely

Your Twilio **auth token** (and, to a lesser degree, the account SID) are
secrets. Never hard‑code them or commit them to version control. Store them in
environment variables and reference them from the Twilio module's configuration.

With DDEV, save the values into the (git‑ignored) `.ddev/.env` file and restart so
the container picks them up:

```bash
ddev dotenv set .ddev/.env --twilio-auth-token=<your-auth-token>
ddev restart
```

The flag `--twilio-auth-token` becomes the environment variable
`TWILIO_AUTH_TOKEN` inside the web container. Confirm it is present **without
printing its value**:

```bash
ddev exec 'test -n "$TWILIO_AUTH_TOKEN"'   # exit status 0 means it is set
```

Where the Twilio module supports it, use a [Key](https://www.drupal.org/project/key)
entity backed by that environment variable rather than pasting the raw token into
configuration.

> **Egress caveat:** sending an SMS makes an outbound request to Twilio's API over
> the internet. Keep it over HTTPS and be mindful of what content (and which phone
> numbers) leave your site.

## Verify it worked

1. Confirm the Twilio module is configured with a working SID, token and
   from‑number.
2. Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit
   a model, and confirm the **Send Twilio SMS** action appears among the available
   actions.
3. Build a small test model that sends a fixed message to your own phone and
   confirm it arrives. If not, check the `eca_twilio_action` log channel — send
   failures are logged there.
