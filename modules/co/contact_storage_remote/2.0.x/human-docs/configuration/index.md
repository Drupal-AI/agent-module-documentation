# Configuration

Contact Storage Remote is configured **per contact form**, not from one global
page. Everything hangs off the form's edit screen under **Structure → Contact
forms → *(your form)* → Manage → Contact Storage Remote**
(`/admin/structure/contact/manage/{contact_form}/contact-storage-remote`).

## Permission

Every route and tab here requires the single permission **"manage
contact_storage_remote contact_form settings"**. Grant it (under **People →
Permissions**) only to trusted administrators, since it controls where your
contact submissions get sent.

## The Contact Storage Remote tabs

Once you open the tab for a form you'll find these areas:

- **Info** — shows which remote‑storage (transport) plugins are currently enabled
  for this form, so you can see at a glance where submissions will be sent. You can
  combine more than one transport on a single form.
- **Conditions** — lists the send conditions for the form. Use **Add condition** to
  create a rule; each rule is stored as a `contact_storage_remote_condition` config
  entity that you can later edit or delete. The shipped condition type is
  **FieldValue**: forward a submission only when a chosen field equals a given
  value (for example, only send when "Department" is "Sales"). If no conditions are
  set, all submissions are forwarded.
- **Mail** — the remote mail settings for this form.

## Field mapping

When a transport plugin supports it, you can **map the contact form's fields onto
the remote payload** — deciding which submitted field becomes which key in the data
sent to the remote system. Mapping is configured on the transport plugin itself, so
the exact fields you see depend on which plugin you installed.

## Where credentials and TLS live

The base module contains **no outbound HTTP client**. The connection details —
endpoint URL, TLS/SSL verification, API keys or tokens — all belong to the concrete
transport plugin you installed. Configure and review those on the plugin, and make
sure it verifies TLS and stores secrets safely before sending real submissions.

## Extending it (for developers)

- **Transport plugin:** implement `RemoteStoragePluginInterface` / extend
  `RemoteStoragePluginBase` and annotate it `@ContactStorageRemoteStorage` (set
  `supports_field_mapping` if it accepts mapping). It receives the submitted
  `contact` Message entity; put the HTTP client, TLS, and credential handling here.
- **Condition plugin:** annotate `@ContactStorageRemoteCondition` and extend
  `ConditionPluginBase` to add new send rules beyond FieldValue.
