# Configuration

Swagger UI Field Formatter has no central settings page — everything is set on the
field where you display the spec. First make sure the Swagger UI library is
installed (see [Installation](../installation/index.md)); then apply a formatter and
choose its options.

## 1. Choose which field type to use

You need a field that holds the OpenAPI/Swagger spec:

- A **File** field, if you upload the `.json` / `.yaml` spec as a managed file →
  use the **Swagger UI** formatter for file fields.
- A **Link** field, if the spec lives at an external URL → use the **Swagger UI**
  formatter for link fields.

## 2. Apply the formatter

1. Go to the entity bundle's **Manage display** tab
   (`/admin/structure/…/display`).
2. Set your File or Link field's **Format** to **Swagger UI**.
3. Click the settings cog to open the options below.

## 3. The display settings

| Setting | Default | What it does |
|---------|---------|--------------|
| **Validator** | Default | Whether the spec is validated: **None** (no validation — best for private/internal specs), **Default** (swagger.io's *online* validator badge), or **Custom** (your own validator endpoint). |
| **Validator URL** | empty | The custom validator endpoint. Only used when **Validator** is set to Custom. |
| **Doc expansion** | List | How the docs open initially: **None** (collapsed), **List** (tag groups only), or **Full** (tags and operations expanded). |
| **Show top bar** | Off | Show or hide Swagger UI's top bar (the spec URL / explorer). |
| **Sort tags by name** | Off | Order the operation tag groups alphabetically. |
| **Supported submit methods** | all methods | Which HTTP methods get the live **"Try it out"** console (GET, PUT, POST, DELETE, OPTIONS, HEAD, PATCH). Untick methods to limit it — for example leave only GET. Select **none** to disable "Try it out" entirely while still showing the docs. |

Click **Update**, then **Save**.

## Notes and good practice

- **Private specs:** the **Default** validator sends your spec to swagger.io's
  online validator. For internal or confidential APIs, set the validator to
  **None** so nothing is sent off-site.
- **Access control:** for File fields, the spec is access-checked — a user who
  cannot access the file entity will not get a rendered widget. Pair the module with
  node/field access if you need to gate who can view or "try" the API.
- **Multiple specs:** a multi-value File or Link field renders one Swagger UI widget
  per value, so you can show several specs on one entity.
- **OAuth2:** to enable OAuth2 authorization in "Try it out", make sure your Swagger
  UI library includes the OAuth2 redirect assets (see the Installation guide's
  status-report note).
