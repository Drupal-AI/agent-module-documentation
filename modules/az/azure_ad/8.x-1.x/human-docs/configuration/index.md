# Configuration

Every screen lives under `/admin/config/people/azure_ad/*` and requires the
**Administer site configuration** permission. The real directory API calls and
OAuth token exchange are delegated to the required **User Provisioning** module.

## 1. Register an Azure app

In the Azure portal, create an **App registration**, grant it Microsoft Graph
application permissions for reading/writing users, and create a **client secret**.
The redirect/callback URL to register is the one the module produces (it is always
forced to `https:`).

## 2. Connect (overview wizard)

Go to the overview wizard at `/admin/config/people/azure_ad/overview` and enter
your **tenant**, **client ID**, and **client secret**.

> **Store the client secret securely.** Do not paste it into plain configuration.
> Keep it in an environment variable and reference it via a Key entity or
> `getenv()`. With DDEV, for example:
> `ddev dotenv set .ddev/.env --azure-client-secret=<value>` then `ddev restart`,
> keeping `.ddev/.env` out of version control.

## 3. Choose a sync direction

- **Drupal → Azure** (`/configure_azure`) — push Drupal accounts into Azure
  AD / B2C.
- **Azure → Drupal** (`/azure_to_drupal_configure`) — import Azure users into
  Drupal.

## 4. Map attributes and roles

On the **mapping** screen (`/mapping`), map Drupal user fields to Azure attributes
and map Azure groups/roles to Drupal roles.

## 5. Choose a provisioning mode

- **Automatic** (`/configureautomaticprovisioning`) — sync on user events.
- **Manual / on‑demand** (`/configuremanualprovisioning` and `/manualuserSync`) —
  sync selected users when you choose.

## 6. Operate

Review the connection at `/reviewconfig`, inspect the sync **audit logs**, and tune
the **advanced settings** as needed.

## Licensing note

This is a commercial miniOrange product. The trial, upgrade‑plans, and
support/customer‑request screens communicate with miniOrange, and higher user
volumes and real‑time sync require a **paid plan**. Review what those forms
transmit before you submit them.
