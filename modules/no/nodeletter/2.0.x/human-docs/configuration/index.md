# Configuration

Setting up Nodeletter has four stages: connect Mailchimp, set the global send switch,
enable and map the content types you want to send, and then use the per‑node Newsletter
tab. Take the safety notes at the end seriously — this module sends real email.

## 1. Connect Mailchimp (credentials live in the Mailchimp module)

Nodeletter does the API work through the contributed **Mailchimp** module, so your
Mailchimp **API key** is configured there, not in Nodeletter. Set it up in the
Mailchimp module's own settings and confirm your audiences/lists and templates are
available before continuing.

> **Handling the API key safely (DDEV).** Keep the Mailchimp API key out of code and out
> of version control. Store it in an environment variable with DDEV's dotenv helper and
> restart so the container picks it up:
>
> ```bash
> ddev dotenv set .ddev/.env --mailchimp-api-key=<your-key>
> ddev restart
> ```
>
> Never commit `.ddev/.env`. Then reference that variable from the Mailchimp module's
> key configuration (for example via a **Key** entity using the environment provider) so
> the secret is never stored in exported configuration.

## 2. Global settings — `/admin/config/services/nodeletter`

Open **Configuration → Web services → Nodeletter** (requires **Administer site
configuration**). The key control here is:

- **Allow sending** (`nodeletter_allow_sending`) — the **master switch for real
  newsletter sends**. When it is **off**, the per‑node form still lets editors send
  **test mails**, but the real "send to the list" action is disabled. Leave it off until
  you are ready to send for real; turn it on deliberately.

## 3. Enable and map each content type — the Nodeletter tab

For every content type you want to send as a newsletter, go to **Structure → Content
types → *(type)* → Manage** and open the **Nodeletter** tab
(`/admin/structure/types/manage/{type}/nodeletter`). There you:

- **Enable Nodeletter** for the type (this is what unlocks the per‑node Newsletter tab —
  it satisfies the `_nodeletter_enabled` access check).
- Choose the Mailchimp **list** and **template** to use for this type.
- **Map node fields to the template's variables** so your content populates the
  Mailchimp template. Field mapping uses the module's "Sending Variable" field
  type/formatter.

## 4. Send a newsletter — the per‑node Newsletter tab

On a node of an enabled type, open the **Newsletter** tab (`/node/{node}/nodeletter`).
Access requires **update** permission on the node, the node to be **published**, and the
type to be Nodeletter‑enabled. The form lets you:

- **Send test mail** — to a single address. This is available whenever a list and
  template are set, even if real sending is off. Use it to preview.
- **Submit newsletter sending** — the real send to the list (and any interest‑category
  recipient selectors you choose). This is only available when the global **Allow
  sending** switch is on.

You can optionally add a comment to a send, and each send is recorded as a
`nodeletter_sending` entity. Review history per node on the form, or browse all sends at
`/admin/nodeletter/sendings` (viewing the collection needs the **view nodeletter_sending
entity** permission).

## Safety notes

- **Keep "Allow sending" off** until you have tested with test mails and are confident
  in the field mappings — it prevents accidental real sends.
