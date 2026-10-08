# Configuration

Setting this module up has two stages: first prepare a text format so the
Embedded Content button is available, then choose which Component Library patterns
editors may embed and shape the form they fill in for each.

## Before you start

Make sure you have at least one **Component Library pattern with one or more
variants** defined on your site. This module embeds those patterns — it does not
create them.

## Step 1 — Enable Embedded Content on a text format

1. Log in as a user who can administer filters (an administrator by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format that uses
   CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **Embedded Content** button
   into the *Active toolbar*.
4. Under the format's **Enabled filters**, turn on the Embedded Content filter.
5. Click **Save configuration**.

## Step 2 — Choose and shape the embeddable patterns

Go to **Structure → Component Library → CKEditor embeds**
(`/admin/structure/component-library/ckeditor-embeds`). You need the *Administer
component library patterns* and *Use CKEditor 5 embedded content* permissions to
open it.

On this page you:

- **Toggle which patterns are embeddable.** Only the patterns you enable here
  appear to editors in CKEditor. Keep the list curated to what you actually want
  editors reaching for.
- **Shape each pattern's embed form.** For every enabled pattern there is an
  **Embed Config Form Settings** field. This is a JSON object keyed by the
  pattern's data properties, where each value is a Drupal Form API definition
  applied to that property's field on the embed form. If you leave it empty, every
  property is offered to editors as a plain text field.

### Shaping fields with the JSON settings

The JSON lets you swap a property's default text field for a more appropriate
widget, give it a sensible default, or take it away from editors entirely. For
example:

```json
{
  "link_text": { "#type": "textfield" },
  "url": { "#type": "url" },
  "html_tag": { "#type": "value" }
}
```

- **`"#type": "url"`** turns a link property into a proper URL field with
  validation, instead of a free‑text box.
- **`"#type": "value"`** hides a property from editors but keeps a fixed value.
  This is the recommended way to lock down something like an `html_tag` that an
  editor could otherwise set to markup that breaks the layout.
- **`"#access": false`** removes an element from the embed form altogether.

Save the form when you are done. At render time each embedded pattern is output
through the module's `ckeditor_component_library_embed` theme hook, using the
property values the editor supplied.

## A note on trust

Because editors choose pattern variants and fill their properties, the security
and correctness of what gets rendered depends on the underlying pattern templates
and on the text format's filter configuration. Expose only patterns you are
comfortable letting editors use, lock properties (with `"#type": "value"`) that
should not be editor‑controlled, and grant the configuration permissions only to
trusted users.
