# Configuration

Schema App needs to be connected to your account on the hosted Schema App service
before it can do anything. You do that on the module's settings page.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Schema**, or navigate directly to
   `admin/config/development/schema`.

## Connect your Schema App account

On the settings page, supply the details that link the site to your Schema App
account and the project you want to use. This is where the module learns which
Schema App project to pull markup from and how to authenticate to the service. Once
connected, the module caches the markup Schema App generates locally so your pages
can serve it.

You will need an **active Schema App subscription** for this to work — the
credentials come from your Schema App account.

## Keep credentials secret

Any API key or credential you use here is a secret. Do not hard‑code it in
configuration you commit to version control. Store it in an environment variable
(and, where the field accepts one, a Key entity backed by that variable) so the
value stays out of your repository and exported configuration. Because this module
talks to an external service, be aware that page and markup data flow to and from
Schema App as part of the integration.

## What it does after connecting

The module produces structured‑data (JSON‑LD) markup on your pages, cached locally
from your Schema App project. It has no access‑control role of its own. Keep the
markup managed in Schema App accurate to your page content, so the structured data
matches what visitors actually see.
