# Configuration

There are two parts: give the module your Jotform API key, then switch a string
field to the Jotform widget.

## Step 1 — Set the Jotform API key

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Jotform Field Widget**
   (`/admin/config/services/jotform-field-widget`).
3. Enter your **Jotform API key** and save. The module uses it to instantiate its
   Jotform API client so the widget can list your forms.

### Keeping the key out of exported config

The API key is a credential. Keep it out of public version control and be mindful
that it may appear in **configuration exports**. If you run **DDEV**, you can keep
the value in an environment variable rather than typing it into a shared export:

```bash
ddev dotenv set .ddev/.env --jotform-api-key=<your-key>
ddev restart
```

That exposes it inside the container as `JOTFORM_API_KEY` (never commit
`.ddev/.env`). Restrict who holds the **Administer site configuration** permission
and who can read your config exports, and rotate the key if it's ever exposed.

## Step 2 — Put the widget on a field

1. Add (or reuse) a **string** field on your content type at **Structure → Content
   types → *(bundle)* → Manage fields** — the widget works on any string field
   type.
2. Go to the bundle's **Manage form display** tab.
3. For that field, choose the **Jotform** widget in the **Widget** column, adjust
   any widget settings, and save.

Now, when editing content of that type, the field lets an editor select a Jotform
Form ID.

## Outbound network access (egress)

The module makes **outbound HTTPS requests to the Jotform API** to look up your
forms. If your site runs behind an egress firewall, allow outbound access to
Jotform's API host, otherwise the widget won't be able to list forms.
