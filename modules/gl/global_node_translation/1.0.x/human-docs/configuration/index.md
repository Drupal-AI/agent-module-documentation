# Configuration

Getting Global Node Translation working is a short sequence: tell the module which
**languages** to translate into, make your content **translatable** in core, and
then switch on **automatic translation** for the content types you want covered.

## 1. Choose the target languages

1. Go to **Administration → Extend** and find **Global Node Translation**.
2. Click its **Configure** link to open the module's settings form.
3. Select the **languages** you want translations created for. (Only languages you
   have already added to the site under **Configuration → Regional and language →
   Languages** are available to choose.)
4. Save.

## 2. Make content types and fields translatable

The module builds on core's translation system, so the content must be marked
translatable first:

1. Go to **Configuration → Regional and language → Content language and
   translation** (`/admin/config/regional/content-language`).
2. Enable translation for the **content types** you want translated, and tick the
   individual **fields** that should be translatable.
3. Save.

## 3. Enable automatic translation per content type

Once a content type is translatable, the module adds a per‑type switch:

1. Open the content type's settings page (**Structure → Content types →
   *(your type)* → Edit**).
2. Under the **Language settings**, find **Enable Automatic Translate**.
3. Tick it to turn on automatic translation for this content type, and save.

Repeat for each content type you want covered.

## How it behaves afterwards

- **On node creation:** when an editor creates a node in the original language, the
  module generates translations in all the languages you selected, using the
  Google Translate library. Paragraph reference fields on the node are translated
  too.
- **For existing content:** use the **Translate Nodes** action provided for **Views
  Bulk Operations** — select nodes in a VBO‑enabled view and run the action to
  translate them in bulk.

## Good to know

- The translations are **machine translations**. They give every language a
  starting point, but you'll likely want editors to review and refine them.
- Because the module calls the Google Translate service, translation requires
  outbound network access. If your environment restricts egress, allow the
  outbound calls the `stichoza/google-translate-php` library makes, or translations
  won't be generated.
