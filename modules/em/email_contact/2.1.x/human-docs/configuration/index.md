# Configuration

Email Contact has no global settings page. You configure it per field by choosing one of
its two formats on an entity's **Manage display** screen, then editing that format's
settings.

## Apply a formatter to an email field

1. Go to the entity's display settings — for example **Structure → Content types →
   Article → Manage display** (`/admin/structure/types/manage/article/display`).
2. Find your **Email** field and set its **Format** to one of:
   - **Email contact link** — shows a link (optionally a modal) to the contact form.
   - **Email contact inline** — embeds the contact form directly in the output.
3. Click the **cog / gear** icon next to the field to edit the format's settings
   (described below), then **Update** and **Save**.

Tip: set the field's **Label** to *Hidden* if you don't want a label above the link or
form.

## Settings for "Email contact link"

| Setting | Default | What it does |
|---------|---------|--------------|
| **Link text** | "Contact person by email" | The visible text of the link. |
| **Open in modal** | off | Open the contact form in an AJAX modal dialog instead of on its own page. |
| **Title** | *(empty)* | The page/modal title. If left empty it falls back to "*(entity label)* - Email Contact". |
| **Include field values** | on | Include the submitter's name and email in the message body. |
| **Additional message** | *(empty)* | Extra text prepended to the email body (supports tokens if the Token module is installed). |

## Settings for "Email contact inline"

| Setting | Default | What it does |
|---------|---------|--------------|
| **Redirect to** | Front page | Where to send the visitor after they submit: the **front page**, the **current page**, or a **custom path**. |
| **Custom path** | *(empty)* | The path used when "Redirect to" is set to custom (required and validated in that case). |
| **Include field values** | on | Include the submitter's name and email in the message body. |
| **Additional message** | "*(user)* sent a message using the contact form at *(page url)*." | Extra text prepended to the email body (supports tokens if Token is installed). |

## How the email is sent

When a visitor submits the form, the message goes to the address stored in the email
field (or all addresses, if the field has several values), with the visitor's own email
set as the reply-to so staff can reply directly. The address itself is **never
displayed** — visitors only ever see the link or the form. The form validates the
subject and address and blocks header-injection attempts.

## Access

There is no module-specific permission. The link or form is shown wherever the user can
**view** the entity and the field; the contact controller re-checks that view access
when the form is opened. Control who can use it by controlling who can view the field.

## Developer note

Developers can customise the modal's open/close AJAX behaviour by subscribing to the
`AjaxEmailContactCommandEvent`. That and the module's `hook_mail()` integration are
documented for agents in [`agent/api/integration.md`](../agent/api/integration.md).
