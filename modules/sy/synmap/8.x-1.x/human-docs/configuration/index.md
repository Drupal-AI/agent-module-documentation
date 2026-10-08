# Configuration

SynMap is configured on its own settings form, reached through the `synmap.settings`
route. Here you tell the module which mapping provider to use and where the map
should be centred.

## Open the settings form

1. Log in as a user with permission to administer site configuration (an
   administrator by default).
2. Go to the SynMap settings form (the `synmap.settings` configuration route).

## What to configure

- **Map provider** — choose between **Yandex Maps** and **OpenStreetMap (OSM)**.
  OpenStreetMap needs no account; Yandex may require an API key and loads a
  third-party script in the visitor's browser. If Yandex asks for an API key, keep
  that key in a secret store (an environment variable or a Key entity), not in
  committed configuration, and restrict it to your domain where the provider allows.
- **Location** — set the place the map should show and centre on (the office, shop
  or point of interest you want visitors to see).

Save the form when you are done. Then place the map where it should appear on the
site by adding SynMap's block through **Structure → Block layout**
(`/admin/structure/block`) in your chosen region.

## A note on the Yandex provider

Because Yandex renders the map client-side, using it means the visitor's browser
talks directly to Yandex and loads its script and map tiles. That is a third-party
data flow to be aware of for privacy and for any content-security-policy rules you
maintain. OpenStreetMap is the lighter-weight choice if you would rather avoid an
API key and an external account.
