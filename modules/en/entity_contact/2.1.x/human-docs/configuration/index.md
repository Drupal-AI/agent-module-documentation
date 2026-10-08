# Configuration

Setting up Entity Contact means creating a **contact form**, adding the **fields**
you want on it, exposing it to the right users, and — optionally — configuring flood
throttling and e-mail on submission. Everything starts at **Content → Entity
contact** (`/admin/content/entity-contact`).

## Create a form and choose whether to store submissions

1. Go to **Content → Entity contact** and click **Add contact form** (requires the
   **administer entity contact forms** permission).
2. Add the fields your form needs to the `entity_contact_message` entity through the
   **Field UI** — these become the form's fields (name, e-mail, message, a file
   upload, select lists, and so on). Nothing is forced on you.
3. On the form, set the **store submission** option:
   - **On** — submissions are kept as `entity_contact_message` content entities you
     can list and view.
   - **Off** — the submission is handled (for example e-mailed) and then deleted on
     insert.

## Expose the public form

Grant the **access entity contact form** permission to the roles that should be able
to submit. Each form's public submission page is generated automatically. Remember
this is a dedicated permission, distinct from `access content`.

## Flood limit and IP storage (Settings)

On the settings form (requires **administer entity contact form settings**):

- **Flood limit / interval** — throttle how many submissions are accepted in a given
  window, to curb abuse.
- **Store IP address** — a toggle to record the submitter's IP. Leave it off unless
  you need it, for privacy/GDPR reasons.

## E-mail on submission (Entity Contact Email submodule)

If you enabled `entity_contact_email`:

1. On a form, open **E-mails** and add an e-mail.
2. Set the **recipients** — static addresses you type in, plus optionally the value
   of a message field you explicitly choose (field recipients are validated as
   e-mail addresses; `list_string` fields map their allowed values to addresses).
3. Write the **subject** and **body**. Both support Token replacement — including the
   `entity_contact_email`, `entity_contact_message`, and `entity_contact_form` token
   types, and `[entity_contact_message:list-fields]` to render all submitted fields
   into the mail.

Because recipients are admin-configured (not free-form submitter input unless you
deliberately map a recipient field) and mail goes through the core mail manager, there
is no open-relay or obvious header-injection path.

## Submission handlers (developers)

Submissions are processed by **submission handler** plugins. To add custom
processing, implement a submission handler plugin (see the
`entity_contact_example_submission_handler` submodule as a starting point). The
handler manager runs every registered handler when a message is inserted.

## Managing submissions

If you store submissions, view them per form for roles with **view entity contact
form submissions**, and use the confirm form to bulk-delete all of a form's
submissions. Old submissions auto-expire and are purged on cron.

## Save

Save your form, its fields, the settings form, and any e-mail configuration. Then
test by submitting the public form and confirming the submission is stored and/or
e-mailed as you configured.
