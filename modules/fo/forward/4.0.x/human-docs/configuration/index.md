# Configuration

Forward has a single global settings form for the email text and abuse controls,
plus a handful of permissions. You also decide where the Forward entry point
appears by adding a field formatter to an entity display.

## Permissions

Set these under **People → Permissions**:

- **Access forward** (`access forward`) — lets a role use the Forward form and
  send forwards. Commonly granted to **anonymous and authenticated** users, since
  that is the whole point of the module. It still requires view access to the
  target entity.
- **Override email address** (`override email address`) — lets a logged-in user
  change the sender email on the form. Without it, the sender email is locked to
  their account email. Deliberately non-restricted, since it only affects the
  sender's own address.
- **Administer forward** (`administer forward`, restricted) — required to open the
  settings form below.
- **Override flood control** (`override flood control`, restricted) — lets trusted
  roles bypass the per-hour send limit.

Keep the two restricted permissions on trusted roles only.

## Global settings form

Go to **Configuration → User interface → Forward**
(`/admin/config/user-interface/forward`). The form writes to the
`forward.settings` configuration. The main options:

### The form shown to visitors

- **Form title** (`forward_form_title`) — the page/section title, tokenised.
- **Form instructions** (`forward_form_instructions`) — the blurb above the form.
- **Confirmation message** (`forward_form_confirmation`) — shown after a
  successful send.
- **Maximum recipients** (`forward_max_recipients`, default **1**) — how many
  recipient addresses are allowed per send. Setting it above 1 turns the recipient
  field into a textarea.
- **Personal message** (`forward_personal_message`, default optional) — whether
  the sender may add a personal note: off, optional, or required.
- **Allow limited HTML** (`forward_personal_message_filter`, default off) — permit
  a small set of HTML tags (`forward_personal_message_tags`) in that message.
- **Offer plain-text / HTML choice** (`forward_form_allow_plain_text`, default
  off) — let the sender pick the email format.
- **Preview toggles** (`forward_form_display_page`, `_subject`, `_body`) — show a
  preview of the link, subject, or body on the form.
- **No-index** (`forward_form_noindex`, default on) — adds `noindex` to the
  Forward page so search engines skip it.

### The email that gets sent

- **Subject** (`forward_email_subject`) — tokenised email subject.
- **Header message** (`forward_email_message`) and **footer**
  (`forward_email_footer`) — tokenised lines wrapping the body.
- **Logo** (`forward_email_logo`) — path to a logo image in the email.
- **From address** (`forward_email_from_address`) — the envelope/From address;
  falls back to the site mail if unset.
- **Filter formats** (`forward_filter_format_html`, `forward_filter_format_plain_text`)
  — a text format applied to the rendered body. A common use is the **Pathologic**
  filter, which rewrites relative links to absolute ones so they work in email.

### Abuse controls and access

- **Flood control limit** (`forward_flood_control_limit`, default **10**) — the
  maximum number of sends per hour. Roles with *override flood control* skip it.
- **Flood control error** (`forward_flood_control_error`) — the message shown when
  the limit is reached.
- **Bypass access control** (`forward_bypass_access_control`, default off) — when
  off (recommended), the forwarded page is rendered as the **anonymous** user so
  restricted content can't leak. Turn it on only if you deliberately want the page
  rendered as the logged-in sender.

You can also set any key from the command line, for example:

```bash
drush cset forward.settings forward_max_recipients 5 -y
```

## Where the Forward entry point appears

Forward doesn't add a link on its own — you place it as a field formatter on the
entity's **Manage display**:

- **forward_link** — a "Forward" link (styled as text or an icon) that opens the
  form.
- **forward_form** — the Forward form embedded inline on the page.

## Controlling what gets emailed

Create a **forward** view mode on the entity's Manage display to control exactly
which fields are included in the email. If there is no `forward` view mode, the
module falls back to the teaser or full view.

## Reviewing forwards

Every send is logged and aggregated. Two Views are provided — **forward_logs**
(who forwarded what, when, and from which IP) and **forward_statistics** (how many
times each page has been forwarded) — so you can monitor usage.
