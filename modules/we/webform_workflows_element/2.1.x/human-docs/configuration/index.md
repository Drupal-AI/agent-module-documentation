# Configuration

Setting up a submission workflow is a few steps: create the workflow, add the
element to a form and bind it, configure access, and (optionally) wire up emails.
The module defines **no permission of its own** — access is driven entirely by the
element's access rules plus core Webform access.

## 1. Create a workflow

Go to **Configuration → Workflow → Workflows**
(`/admin/config/workflow/workflows`) and add a workflow of type **Webform
workflow**. Define its **states** (e.g. Draft, Needs review, Approved) and the
**transitions** between them using the standard core Workflows UI, and set the
initial state.

## 2. Add the element to a webform

On the webform you want to attach the workflow to, add an element of type **Webform
workflow** and set its workflow to the one you just created. The element records, in
each submission's data, the current state, the previous state, the state label, the
chosen transition, and public/admin log messages.

Useful element properties include:

- **Hide if no transitions** — hide the element when the user has no available
  transitions.
- **Require a transition if one is available** — force the user to pick a transition.
- **Transition element type** — render the transitions as a **select** list or as
  **buttons**.
- **Public / admin log message settings** — whether to collect a public comment
  and/or an admin-only note with each change.

## 3. Configure access (the element's *Access* tab)

This is where the fine-grained control lives. On the element's **Access** tab you set
rules in two dimensions:

- **Per transition** — first enable the transition, then restrict *who* may perform
  it by **roles**, **users**, and/or **permissions**. If a transition's toggle is
  off, it is forbidden (not silently allowed).
- **Per state (edit-while-at-state)** — optionally override edit access while a
  submission sits at a given state, again by roles, users, and/or permissions. This
  controls who may edit a submission at that point in its lifecycle.

By default the element allows *view* and *update* for authenticated users and does
not allow *create* access — adjust these to fit your process.

## 4. Performing transitions

- On the submission edit form, the element shows the current state and the
  transitions the user is allowed to run.
- A dedicated **confirm route** runs a single transition (with its own access check).
  You can preset which transition the form lands on via URL query arguments.

## 5. Summary pages

Two "Workflows summary" pages list submissions grouped by state (both require
*update* access to the webform):

- An admin path under the webform's manage screens
  (`…/manage/{webform}/workflows-summary`).
- A front-end path at `/webform/{webform}/workflows`.

## 6. Transition emails

To notify people when a transition fires, add the **Workflow transition email**
handler to the webform (from the webform's *Emails / Handlers* screen). On the
handler you choose which transitions trigger an email and who receives it.

Site-wide defaults for these emails live at **Structure → Webforms → Configuration
→ Workflows** (`/admin/structure/webform/config/workflows`, requires *Administer
webform*):

- **Default email bodies** — the default plain-text and HTML bodies for transition
  emails, using tokens like
  `[webform_submission:values:workflow:workflow_state_label]`.
- **State colour options** — a newline list of `Label|css-class` entries used to
  colour-code states in the UI.

Workflow-specific tokens (transition URLs and links, including **secure-token**
variants that let a logged-out user perform a transition from an emailed link) are
available in these emails and other webform messages.

## 7. Bulk transitions and extension points

- A bulk **Action**, "Perform workflow transition," runs a transition across many
  submissions at once.
- Custom code can react to changes by subscribing to the workflow **transition
  event**, and can override transition/element access via the module's access-alter
  hooks — see the sibling [`agent/`](../agent/start.md) docs for the developer API.
