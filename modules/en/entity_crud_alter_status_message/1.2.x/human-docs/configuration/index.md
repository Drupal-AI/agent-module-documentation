# Configuration

Entity CRUD Alter Status Message is configured by creating one or more **message
rules**. Each rule says: "for this entity type and bundle, when this action
happens, show this message instead of the default."

## Open the message listing page

1. Log in as a user with the module's administration permission (grant it under
   **People → Permissions** if needed).
2. Navigate to the module's **message listing page**, found under the **System**
   menu. This page lists any status‑message rules you've already created and offers
   a link to add a new one.

## Create a message rule

When you add or edit a rule, you fill in:

- **Entity type** — the kind of entity the message applies to. The module ships
  support for **node**, **taxonomy term**, and **media**.
- **Bundle** — the specific bundle within that entity type (for example, the
  *Article* content type, or a particular vocabulary or media type). This lets you
  target one bundle without affecting the others.
- **Action** — which CRUD operation triggers the message: **create**, **update**,
  or **delete**. Create a separate rule for each action you want to customize.
- **Message** — the text to display. This replaces the default system message for
  the chosen entity type, bundle, and action. Because the module integrates with
  the **Token** module, you can insert tokens here so the message reflects the
  actual item — for example the title of the node that was just saved. Use the
  token browser (if shown) to find the available tokens; they resolve against
  access‑respecting data.

## Save

Save the rule. From now on, whenever a matching entity of that bundle is created,
updated, or deleted, editors see your custom message in place of Drupal's default
confirmation. You can return to the listing page at any time to add, edit, or
remove rules.
