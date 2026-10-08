# Configuration

There are two separate mechanisms here, and it is worth keeping them straight: the
**global settings form** only stores defaults for itself, while the **handler you
attach to a webform** is what actually blocks submissions. Configuring the first one
alone does nothing.

## 1. The global settings form (defaults only — not applied automatically)

Go to **Configuration → Webform → Webform Spam Words**
(`/admin/config/webform/webform-spam-words`). You can reach it with **either** the
*Administer webform* permission **or** the module's own *edit webform spam words*
permission. It stores three values in the `webform_spam_words.settings` config
object:

- **Spam words** — one word per line. Shipped defaults are `SEO`,
  `Digital Marketing`, `Click Here`, `unsubscribe`, `FREE`, and `trial`.
- **Error message** — the message shown when a submission is blocked. Default:
  *"Unable to submit form. Please contact the site administrator, if the problem
  persists."*
- **Field names** — a comma-separated list of fields to check. Default: `message`.

Be clear about what this form is for: **nothing in the module reads these values to
protect a webform.** They are a convenient, editable starting point that you copy
into an actual handler. Changing them here has no effect on any form until you
configure a handler (below), and the handler does not read this config either — its
values are separate.

## 2. Attach the handler to a webform (this is what blocks submissions)

1. Edit the webform you want to protect.
2. Go to **Settings → Handlers** and click **Add handler**.
3. Choose **Webform Spam Words** and add it. Only one instance per webform is
   allowed.

The handler checks each named field on submission: it lowercases the submitted text
and looks for any of your spam words as a substring (case-insensitive). A match
blocks the submission and shows your error message on that field.

### Important: the handler has no settings form, and its defaults block nothing

This is the module's biggest gotcha:

- The handler provides **no configuration fields in the "Add handler" screen**, so
  there is nothing to fill in there. To give it real values you must edit the
  webform's exported **configuration YAML** (or set them programmatically).
- The handler's built-in default word list is a single **string** (`SEO`) rather
  than a list. Because of a quirk in how the check loops, a handler left at that
  untouched default **blocks nothing at all**. You must set the words as a proper
  list (a YAML sequence) of one or more words for the filter to do anything.

### Setting the handler's values in config YAML

Add (or edit) a handler block in the webform's config. The `spam_words` value **must
be a list**, never a bare string:

```yaml
handlers:
  block_spam_words:
    id: webform_spam_words
    label: 'Block spam words'
    handler_id: block_spam_words
    status: true
    weight: 0
    conditions: {  }
    settings:
      spam_words:
        - casino
        - viagra
      spam_text_message: 'Blocked: spam detected'
      spam_field_name: email
```

- **`spam_words`** — the list of words to block (one per line as a YAML sequence).
- **`spam_text_message`** — the error message shown when a submission is blocked.
- **`spam_field_name`** — the field(s) to check; use a comma-separated string to
  check more than one, e.g. `message,subject`.

To turn spam checking off for a form again, simply remove or disable this handler.

## Permission

| Permission | Machine name | Gates |
|---|---|---|
| **Edit webform spam words** | `edit webform spam words` | An alternative to *Administer webform* for reaching the global defaults form. |

Assign it at **People → Permissions** if you want an editorial role to curate the
default word list without full webform administration rights.
