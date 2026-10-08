# Configuration

All of this module's behavior is configured **per field**, in the **Media library**
widget's settings on **Manage form display**. There is no site‑wide settings page.

## Open the widget settings

1. Log in as a user who can administer form displays for the entity type (core's
   **"administer &lt;entity type&gt; form display"** permission — e.g. *administer node
   form display*). This is the only access control; the module does not add its own
   permission.
2. Go to **Structure → (your entity type) → Manage form display**. For a content type
   that is `/admin/structure/types/manage/<type>/form-display`.
3. Find your media field (an entity reference to *media*). In the **Widget** column,
   choose **Media library** if it isn't already selected.
4. Click the **gear / cog icon** at the right‑hand end of that field's row to open the
   widget settings.

## Enter your replacement texts

The gear panel shows five text fields, each pre‑filled with core's default wording.
Type your own text to override any of them:

- **Add button text** — the "Add media" open‑dialog button (default: *Add media*).
- **Empty selection text** — shown when nothing is selected yet (default:
  *No media items are selected.*).
- **Remaining item text** — the singular "one slot left" message (default:
  *One media item remaining.*).
- **Remaining items text** — the plural message; keep the **`@count`** placeholder to
  show the number (default: *@count media items remaining.*).
- **No remaining items text** — shown when the field is full (default:
  *The maximum number of media items have been selected.*).

The "remaining" messages appear only on fields with a **limited** number of allowed
items; unlimited‑cardinality fields never show them. The chosen message is added after
the field's own help text.

> **Note:** all five fields are required in this panel — clear‑and‑save is not offered;
> to return to a core default, retype the default wording shown above.

## Save

Click **Update** on the widget panel, then **Save** on the Manage form display page.
Open the field on a content edit form to confirm the new text appears. If it doesn't
update right away, clear caches (`drush cr`).

> **Tip — translations:** because this simply changes the widget's text, it's a
> convenient way to set consistent, on‑brand wording. If your site is multilingual,
> the texts are translatable config; handle per‑language wording through Drupal's usual
> configuration‑translation tools in addition to the text you set here.
