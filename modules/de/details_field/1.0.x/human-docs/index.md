# Details Field — manual setup guide

**Details Field** (`details_field`) adds a dedicated field type for creating and
displaying HTML `<details>`/`<summary>` elements — the native, collapsible
"disclosure" widget you click to expand and hide content. After you enable it, a
new field type called **Details element** appears under the *Formatted text*
category when you add a field, and you can use it on any fieldable entity: nodes,
blocks, paragraphs, and so on.

The module ships a matching field widget and formatter. The widget gives editors a
tidy way to author each details element — setting the summary text, the body
content, and the attributes that control how the element behaves (for example
whether it starts open). The formatter then renders that as a real `<details>`
element on the page.

This is a content-editing and display feature; the stored value is text shown
inside a details element, and it has no access-control role. As with any rich text,
make sure the field's text format sanitises editor input. It depends on core's
**Field** and **Text** modules and is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. You set it up per
field, in Field UI, as described below.

## Where it lives in the admin menu

Details Field adds no admin settings page of its own. You use it under **Structure
→ Content types (or other entity types) → *(bundle)* → Manage fields** when adding
or editing a field.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and click
   **Add field**.
2. Choose the **Details element** field type (listed under *Formatted text*).
3. Configure the field as usual and save it.
4. On **Manage form display**, the module's widget lets editors set each details
   element's **summary**, **content** and behaviour attributes. On **Manage
   display**, the field renders as a collapsible `<details>` element.
5. Choose a **text format** for the field that restricts allowed HTML
   appropriately, especially if untrusted users can edit the content.
