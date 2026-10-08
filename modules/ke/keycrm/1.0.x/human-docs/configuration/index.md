# Configuration

All of KeyCRM's setup happens on one settings form at **Configuration → Web
services → KeyCRM** (`/admin/config/services/keycrm`). You need the **Administer
site configuration** permission (an administrator by default) to reach it.

## Get your KeyCRM API token

Log in to your KeyCRM workspace and generate an **API token** with permission to
create leads/orders. Copy it — you will reference it from Drupal in the next step.

## Store the token securely (recommended)

The API token is a secret. Rather than pasting it straight into the form (where
it can end up in a configuration export and in git), store it in an environment
variable and reference it from Drupal.

With DDEV, save it into the project's dotenv file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --keycrm-api-token=<your-token>
ddev restart
```

That makes the value available as the `KEYCRM_API_TOKEN` environment variable
inside the container. Never commit `.ddev/.env`. Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, create one backed by that
environment variable; otherwise reference the variable from `settings.php` with
`getenv('KEYCRM_API_TOKEN')`. Keeping the secret out of configuration is the
same good practice you would apply to any third‑party API credential.

## Enter the connection settings

On the KeyCRM settings form:

- **API token** — the KeyCRM token from above (or the Key/environment reference
  you set up). This authenticates every request the module makes to KeyCRM.
- **Payment and delivery methods** — as noted in the module's post‑installation
  guidance, add your store's payment and delivery methods so orders map cleanly
  into KeyCRM.

Save the form. From then on, completing checkout on the store sends the order to
KeyCRM, and status changes sync between the two systems.

## A note on data egress

KeyCRM is a hosted service, so orders and customer details (name, email, phone)
are transmitted to KeyCRM's servers. Make sure this is reflected in your privacy
policy and that you are comfortable with the data leaving your infrastructure.
