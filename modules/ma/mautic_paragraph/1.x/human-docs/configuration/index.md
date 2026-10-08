# Configuration

Setting up Mautic Paragraph has three parts: prepare the Mautic side, connect Drupal
to Mautic, and choose how editors pick a form.

## 1. Prepare Mautic

On your Mautic instance, configure the **API settings** and — if you plan to use
OAuth2 — create the **API credentials**. When using OAuth2, set the **redirect
URL** in Mautic to:

```
https://yourdrupalsitename.com/mautic/callback
```

Replace `yourdrupalsitename.com` with your actual Drupal domain.

## 2. Connect Drupal to Mautic

In Drupal, go to **Configuration → Web services → Mautic**
(`/admin/config/services/mautic`) and follow the on‑screen instructions to enter your
credentials. The module supports multiple **authentication methods** for retrieving
the list of forms from Mautic; choose the one that matches how you configured Mautic
(for example OAuth2 with the credentials and redirect URL above).

### Keep the credentials secure

The Mautic API credentials and any OAuth2 secret grant access to your marketing
platform, so keep them out of plain, git‑committed configuration. Where your workflow
allows, supply secrets from an environment variable rather than exported config. With
DDEV you can store a value with
`ddev dotenv set .ddev/.env --mautic-secret=<value>` (keep `.ddev/.env` out of
version control) and `ddev restart`.

## 3. Choose how forms are selected

Go to the Mautic paragraph type's form display at
`/admin/structure/paragraphs_type/mautic/form-display` and choose how editors pick a
form when adding a Mautic paragraph:

- a **select list** (a dropdown of the forms fetched from Mautic), or
- an **autocomplete list** (type to search), which is friendlier when the Mautic
  instance has many forms.

## Using it

Once connected, editors add a **Mautic** paragraph (or block), pick a form, and it
renders on the page. Remember that the embedded form loads Mautic's script in the
visitor's browser — gate the embed behind consent where your privacy rules require
it.
