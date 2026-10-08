# Configuration

ClickDimensions is configured as a service inside the parent Tarte au citron
module — this add-on has no settings page of its own. You enable the service and
enter its account key and (optionally) domain, and Tarte au citron takes care of
storing them and gating the tracking script behind consent.

## Open the services screen

1. Log in as an administrator.
2. Go to **Configuration → Tarte au citron → Services**, or navigate directly to
   `/admin/config/tarte_au_citron/services`.
3. Find **ClickDimensions** in the list of services and enable it.

## Settings

The ClickDimensions service adds two fields:

- **Account key** (`clickdimensionsAccountKey`) — *required*. Your ClickDimensions
  account key. This value is fed to the front-end tracking library so it can load
  the correct account's tracking script. Without it the service cannot track.
- **Domain** (`clickdimensionsDomain`) — *optional*. A custom ClickDimensions
  tracking domain, if your setup uses one. Leave it blank to use the default.

Both values are entered by administrators and passed to the tracking JavaScript as
trusted configuration.

## Save

Save the service configuration. From then on, the ClickDimensions tracking script
loads only after a visitor accepts the ClickDimensions service in the Tarte au
citron consent banner — visitors who decline (or have not yet chosen) are not
tracked. Because this add-on reuses Tarte au citron's storage and consent
handling, you manage everything about the service — enabling it, the account key,
the domain, and how it appears in the banner — from this one screen.
