# Configuration

Sidekick needs two things before editors can use it: your API key, and a decision about
who is allowed to generate content.

## Open the settings form

1. Log in as a user with the **Administer Sidekick configuration** permission.
2. Go to **Configuration → Web services → Sidekick**
   (`/admin/config/services/sidekick`, route `sidekick.settings_form`).

## Enter your API key

On the form, enter the **API key** from your AI Sidekick account, along with any related
options the form offers. These values are saved in the module's `sidekick.settings`
configuration and are what the module sends to the Sidekick service (as an
`Authorization: Bearer` header) when it requests suggestions.

**Where the key is stored — read this.** The API key is kept as **plaintext in the
module's exportable configuration**; it is not stored via the Key module. That means
anyone who can export or read your site's configuration can read the key. Restrict
config-export access accordingly, and treat the key as a sensitive value.

## Grant the generation permission

Go to **People → Permissions** and grant **`sidekick content generation`** to the
editors who should be allowed to request AI suggestions. Keep this narrow: every
generation is a **paid remote call** to the Sidekick service, so limiting who can
trigger it is your main lever for controlling cost and API-quota use.

The separate **Administer Sidekick configuration** permission controls who can change
the settings above — grant that only to administrators.

## Using it

Once the key is in place and a user has the generation permission, they will see the
Sidekick suggestions surfaced in the node edit form (through the module's custom image
widget and templates) as they author content. Suggestions are requested on demand and
should be reviewed before the node is saved — nothing is written automatically. You can
tune the model or behaviour options on the settings form, and effectively enable or
disable the assistant per environment through configuration.

## Outbound calls and TLS

The module talks to the Sidekick API over HTTPS with certificate verification on
(standard Guzzle defaults) — there is no disabled-verification option, so the
connection to the service is protected.
