# Configuration

Setting up Marketo forms has two parts: **connecting the module to your Marketo
instance** (so the JavaScript API knows where to load forms from), and then
**placing forms** on your site as blocks, fields, or CKEditor tokens.

## 1. Connect your Marketo instance

Marketo's JavaScript Forms API needs to know which Marketo instance to talk to.
Open the module's settings (in the **Marketo** group under **Configuration**) and
provide your Marketo instance details — typically:

- Your **Marketo instance / pod base URL** (the LoadForm host Marketo gives you,
  usually of the form `//app-XXXX.marketo.com`).
- Your **Munchkin account ID** (the identifier for your Marketo subscription).

You will find both of these in your Marketo account under the admin/integration
area. Save the settings.

> **These identifiers are exposed in the page.** The instance URL and Munchkin ID
> are used by client‑side JavaScript, so they are visible in the rendered HTML by
> design — that is how Marketo's embed works. They are configuration values rather
> than secrets, but treat access to *changing* them as an administrative task.

## 2. Place a form

Once connected, embed any form by its **Marketo Form ID** (you can find a form's ID
in Marketo). There are three ways:

### As a block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the Marketo form block in a region and set the **Form ID** it should
   display.

### As a field

1. Go to **Structure → Content types → *(your type)* → Manage fields** and add the
   Marketo form field type.
2. Now each piece of content of that type can specify its own **Form ID**, so
   different nodes show different forms.

### Inside body content (CKEditor)

With the module's CKEditor plugin, an editor can drop a form into rich‑text content
by inserting the token:

```
[marketo-form:FORM_ID]
```

Replace `FORM_ID` with the numeric ID of the Marketo form you want to embed.

## Privacy and consent

Every embedded form loads Marketo's third‑party JavaScript into the visitor's
browser, and the form captures and sends the visitor's data to Marketo. Where
consent requirements apply, gate the forms behind your cookie‑consent mechanism and
disclose the collection and its purpose in your privacy notice. Because lead data
(names, email addresses, and whatever else the form collects) leaves your site on
submission, treat these forms as a personal‑data processing activity, not just a
marketing widget.
