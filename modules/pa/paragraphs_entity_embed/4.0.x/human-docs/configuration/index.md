# Configuration

There is no single global settings page. You enable paragraph embedding **per text
format**, grant the permissions, and (optionally) tune the shipped embed button.
Once that's done, editors get a Paragraphs button in CKEditor 5.

## Enable embedding on a text format

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit the format you want to enable it on
(for example *Full HTML*). Two independent settings on that format have to be on
for embedding to work:

1. **The filter.** Under *Enabled filters*, tick **Display embedded paragraphs**.
   This is a reversible transform filter that turns the `<drupal-paragraph>` tags
   into rendered paragraphs on output.
2. **The toolbar button.** In the **CKEditor 5** toolbar configuration, drag the
   **Paragraphs** button from the available buttons into the active toolbar.

Order matters conceptually: the button only functions when the filter is enabled,
so make sure you turn on both. Save the format.

Repeat for each format where you want the feature — enable it on *Full HTML* but
not on a restricted *Basic HTML*, for instance.

## Grant the permissions

The module adds five permissions (at **People → Permissions**), which control what
editors can do with embeds:

- **View paragraphs entity embed**
- **Add paragraphs entity embed** — grant this to roles that should be able to
  insert embeds via the button.
- **Edit paragraphs entity embed**
- **Delete paragraphs entity embed**
- **Administer paragraphs entity embed** *(restricted)* — covers administration,
  including the embed entity's field/display management.

## Tune the embed button (optional)

The module ships a ready-made **Paragraphs** embed button. To adjust it, go to
**Configuration → Content authoring → Embed buttons**
(`/admin/config/content/embed`) and edit the *Paragraphs* button. Its embed-type
settings let you:

- **Restrict which paragraph types can be embedded** — turn on the paragraph-type
  filter and choose the allowed paragraph bundles, so editors can only insert the
  components you intend.
- **Choose the add mode** — how the dialog lists paragraph types to add:
  *dropdown*, *button*, or *select*.

## How editors use it

With a format set up, an editor editing a rich-text field clicks the **Paragraphs**
button, which opens a dialog. They pick a paragraph type and fill in the inline
Paragraphs form; on save, a `<drupal-paragraph>` element (carrying data attributes
such as `data-paragraph-id` and `data-align`) is inserted into the markup. An
already-embedded paragraph can be re-opened and edited in place. The `data-align`
attribute allows aligning an embed left, right, or centre.

## How embeds are rendered

On output, the *Display embedded paragraphs* filter replaces each
`<drupal-paragraph>` tag with the referenced paragraph, rendered through the
**Embed** view mode for paragraphs (`paragraph.embed`, shipped with the module). To
change how embedded paragraphs look, configure that view mode on the paragraph
type's *Manage display*.
