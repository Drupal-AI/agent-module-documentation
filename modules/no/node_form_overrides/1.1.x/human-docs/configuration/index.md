# Configuration

Node Form Overrides has two places to configure it: a **global settings form**
that sets defaults for every content type, and a **per‑content‑type tab** that
lets a single content type override those defaults. Both are gated by the
**Administer content types** permission.

## The global settings form

Go to **Configuration → Content authoring → Node Form Overrides**
(`/admin/config/content/node-form-overrides`). The form has six fields, each
controlling one piece of node‑form wording. The values you leave here become the
site‑wide default for every content type that does not override them.

- **Insert button** — the label on the submit button when *creating* a new node.
  Default: `Save`.
- **Update button** — the label on the submit button when *editing* an existing
  node. Default: `Update`.
- **Insert title** — the page title on the *add* form. Default:
  `Add new [node:content-type:name]`.
- **Update title** — the page title on the *edit* form. Default:
  `Edit this [node:content-type:name]`.
- **Delete form title** — the title on the delete‑confirmation page. Default:
  `Are you sure you want to delete this [node:content-type:name]?`.
- **Delete form description** — the descriptive text shown below the title on the
  delete‑confirmation page. Default: `This action cannot be undone.`.

Click **Save configuration** when done. The changes apply immediately to every
content type that uses the global defaults.

## Tokens

The default values contain tokens like `[node:content-type:name]`. Token
replacement only happens when the optional **Token** module is installed:

- With **Token** enabled, titles and button labels are passed through the token
  service (plain‑text replacement), and the delete description supports full
  token replacement. If the node form is a group‑context form, group tokens are
  available too. A **Browse available tokens** link appears on the forms so you
  can discover valid tokens.
- Without **Token**, the field values are used exactly as typed — a literal
  string. In that case, remove the `[node:…]` placeholders or they will appear
  verbatim.

## Overriding per content type

Each content type can ignore the global defaults and use its own wording:

1. Go to **Structure → Content types**, and click **Edit** on the content type you
   want to customise (for example `/admin/structure/types/manage/article`).
2. Open the new **Label Overrides** tab (added by the module).
3. Tick **Override global defaults**.
4. Fill in the same six fields — insert/update button, insert/update title, and
   the delete‑form title and description — with values for *this* content type.
5. Save the content type.

The resolution rule is straightforward: if a content type has **Override global
defaults** turned on and supplies a non‑empty value for a field, that value wins;
otherwise the field falls back to the global settings form. Leaving a per‑type
field blank means "keep using the global default for this one."
