# Configuration

All of Conzent CMP is set up from a single settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default). A dedicated **`administer conzent`** permission is
   also available if you want to delegate CMP administration separately.
2. Go to **Configuration → System → Conzent CMP**, or navigate directly to
   `/admin/config/system/conzent`.

## Fields

- **Website Key** — the key from your Conzent dashboard. This is what activates the
  CMP; paste it and the banner loads on the front end. It is an account identifier
  (configuration), not a secret. The settings page shows a verified‑key status
  message once it is set correctly, and links back to the Conzent dashboard.
- **Server URL** — leave **blank** to use **Conzent Cloud** (hosted, nothing for
  you to run). Set it to your Conzent server address to use a **self‑hosted (OCI)**
  deployment instead.
- **Google Tag Manager container id** *(optional)* — your GTM container id in the
  form `GTM-XXXXXXX`. Provide it to integrate consent with GTM so tags fire only
  according to the visitor's consent (via Google Consent Mode v2 and IAB TCF).
- **Data layer name** *(optional)* — the name of the GTM data‑layer variable to
  use. Leave the default unless your GTM setup uses a custom data‑layer name.

Save the form when you are done. Once a valid website key is present, the banner,
preference center, automatic cookie blocking, and auto‑translation are handled by
the Conzent CMP script on the front end.

## Third‑party script note

The Conzent CMP is loaded from your configured server (Conzent Cloud or your
self‑hosted OCI server) on **every page**. If you run a Content‑Security‑Policy,
allow that origin as a script source. The behavior, consent categories, and consent
records all live in the Conzent service — nothing is stored or enforced locally by
this module.
