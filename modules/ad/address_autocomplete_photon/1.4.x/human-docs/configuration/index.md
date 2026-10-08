# Configuration

Setup is two moves: tell the module which Photon endpoint to query, then switch an
Address field to the autocomplete widget.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration** and open the Address Autocomplete (Photon) settings
   (the `address_autocomplete_photon.configure` route).

## Set the Photon endpoint

The key setting is the **Photon endpoint** — the URL the module sends lookups to.
You have two choices:

- **A self-hosted Photon instance (recommended).** Point the endpoint at your own
  server. The addresses users type stay on your infrastructure, and you're not
  dependent on a public service's availability or rate limits.
- **A public Photon instance.** Quicker to start with, but be aware that the
  partial addresses users type are sent to that third party. Note this in your
  privacy documentation.

Photon can generally be used **without an API key**. If the particular endpoint you
choose does require a key, don't paste it straight into config or commit it — store
it as a **secret** (an environment variable or a Key entity) and reference it from
there.

## Turn on autocomplete for a field

1. Go to **Structure → Content types**, pick the content type with your Address
   field, and open **Manage form display**.
2. Change that Address field's widget to the Photon autocomplete widget.
3. Save. On that form, address entry now offers type-ahead suggestions from
   Photon that fill the address fields.

If you enabled the **geofield submodule**, you can also store the coordinates of
the chosen address on a geofield — configure that field on the same content type.

## Privacy reminder

Whatever endpoint you use, the beginning of a person's address is being sent to it
as they type. Self-hosting keeps that on your own systems; a public instance sends
it to a third party. Either way, keep a manual entry path so addresses that Photon
doesn't know can still be entered by hand.
