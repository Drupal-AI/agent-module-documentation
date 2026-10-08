# Configuration

Content Editing Messages does nothing until you create a message, so this page is
the heart of the module. Each message is a small configuration entity that binds
some text to one or more content or media types and decides how and where it
appears on the edit form.

## Open the message list

1. Log in as a user allowed to administer these messages (the module provides its
   own permission — grant it at **People → Permissions** to the roles that should
   manage editorial guidance).
2. Go to **Configuration → Content authoring → Content Editing Messages**
   (`/admin/config/content/messages`).

You'll see the list of existing messages. Click **Add** to create one, or the edit
link on an existing row to change it.

## The message form, field by field

- **Title** — a heading for the message, shown above the body. It is
  **translatable**, so on a multilingual site you can provide per‑language
  wording.
- **Message** and **text format** — the body of the message, also
  **translatable**. It is a rich-text field with a text-format selector, so you
  can author formatted content such as headings, lists, and links.
- **Style** — how the message is visually presented on the form. Choose from:
  - **Info** — a neutral, informational note.
  - **Warning** — a cautionary note that stands out more.
  - **Error** — the strongest, most attention‑grabbing style, for critical
    caveats.
  - **Plain** — no message styling, just the text.
- **Weight / placement** — where the message sits on the form. Choose **Top** to
  show it above the form, **Bottom** to show it below, or **Custom** to set a
  specific weight and position it precisely relative to other form elements.
- **Content and media types** — select one or more content types and/or media
  types the message applies to. The message appears on the add/edit form of every
  selected type. You can apply a single message to several types at once.
- **Field group machine name** *(only when the Field Group module is installed)* —
  an extra field where you enter a field group's machine name (for example
  `group_mytab`) so the message renders inside that group — handy for placing a
  note inside a specific tab or fieldset.

## Save

Save the message, then open an add/edit form for one of the selected content or
media types. The message should appear in the style and position you chose. Create
as many messages as you need — different types can have different guidance, and a
single type can carry several messages.
