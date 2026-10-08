# Configuration

There are two parts: store your Laposta API key safely on the module's settings,
then add the Laposta **handler** to each webform that should subscribe people.

## Store the Laposta API key safely

The API key is a secret. Never hard‑code it or commit it to version control. On
this project, keep it in an environment variable:

1. Save the key into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --laposta-api-key=<value>
   ddev restart
   ```

   The flag `--laposta-api-key` becomes the environment variable
   `LAPOSTA_API_KEY`. Keep `.ddev/.env` **out of version control**.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$LAPOSTA_API_KEY"'   # exit status 0 means it is set
   ```

3. Where the module supports a **Key** entity, create one backed by the
   environment provider and select it, so the key never lands in plain
   configuration. If the settings form takes the key directly, make sure that
   configuration is **not exported and committed** with the secret in it.

Enter (or select) the API key on the module's admin settings form. The module
provides its own administration permission — grant it (under **People →
Permissions**) only to trusted roles.

## Add the Laposta handler to a webform

1. Go to **Structure → Webforms** (`/admin/structure/webform`) and edit the form
   you want (or create a new one).
2. Open **Settings → Emails / Handlers** and **Add handler**.
3. Choose the **Laposta** handler.
4. Configure how subscribers are added:
   - **Fixed list** — subscribe everyone to one list; or
   - **Dynamic list selection** — let visitors choose using the module's **Laposta
     list select** or **Laposta list checkboxes** elements (add these to your form
     under **Build**). Use **list filtering** to restrict which lists visitors can
     see and join.
5. **Map fields** from your webform to the Laposta list fields. The handler
   auto‑maps by field name where it can, and supports all Laposta field types
   (text, numeric, date, single select, multiple select). Mark fields required
   where Laposta needs them — the handler validates required fields before
   subscribing.
6. For consent, add an **opt‑in field** to the form and point the handler at it, so
   subscription only happens when the visitor agrees.
7. **Save** the handler and the form.

## Custom elements

If you want visitors to pick lists, remember to add the module's custom elements —
**Laposta list select** (a dropdown) or **Laposta list checkboxes** (multiple
selection) — to the webform under **Build**, then reference them in the handler's
dynamic‑list settings.

## Verify

Submit the webform as a normal visitor (choosing a list if you enabled dynamic
selection, and ticking the opt‑in), then confirm the subscriber appears in the
expected Laposta list with the mapped field values.
