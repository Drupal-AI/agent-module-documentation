# SSH Key — manual setup guide

**SSH Key** (`sshkey`) provides an `sshkey_default` field type for storing and
validating OpenSSH **public** keys on any fieldable Drupal entity — users, nodes,
or custom entity types. You add and configure it through the Field UI just like
any core field.

The problem it solves is capturing SSH public keys as proper, validated field
data instead of leaving them as free-form text in a plain text field. Each field
you create can allowlist which algorithms it accepts (`ssh-rsa`, `ssh-dss`,
`ssh-ed25519`) and enforce a minimum RSA key size (default 2048 bits). Validation
is layered and strict: the value is base64-decoded, checked for the correct
algorithm wire-format prefix, and finally parsed by the phpseclib library, so
truncated, malformed, or curve-invalid keys are rejected rather than stored. When
a key is saved, the field automatically derives an OpenSSH-style SHA-256
fingerprint (the `SHA256:…` form you get from `ssh-keygen -lf`) and an editable
name taken from the key's comment.

The security posture is deliberately conservative. The module stores **only public
keys** — no private-key material — and ships **no permissions and no routes of its
own**: who can see or edit a stored key is governed entirely by the host entity's
normal field-access rules. On save it also normalizes the raw value and name,
collapsing control characters (the C0 range and DEL) to spaces to block
newline-injection, NUL-truncation, and ANSI-escape tricks against anything that
later displays the key, such as an admin log view. The stored value is capped at
16 KB. One thing to be aware of: there is no uniqueness constraint on the
fingerprint, so the same key can be stored more than once unless you add your own
validation.

It depends only on core's **Field** module, plus the `phpseclib/phpseclib` library
(pulled in automatically by Composer), and runs on Drupal 10.3, 11, and 12. There
are no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its library
   with Composer, and enable it.

## How to use it

There is no site-wide settings page — the module works entirely through fields
you add:

1. Go to **Structure** and open **Manage fields** for the entity bundle you want
   to attach keys to (for example a User account, or a content type).
2. Add a new field of type **SSH Key**.
3. In the field's settings, choose which **algorithms** are allowed
   (`ssh-rsa`, `ssh-dss`, `ssh-ed25519`) and set the **minimum RSA modulus
   length** in bits (default 2048; set it to 0 to disable the RSA size floor).
   Set the field's cardinality if you want to allow more than one key per entity.
4. Content authors (or users editing their own account) then paste a public key
   into the field's text area. Malformed or disallowed keys are rejected on save.
5. On the field's display settings, use the **fingerprint** formatter to show the
   stored `SHA256:…` fingerprint, or the **name** formatter to show the key's
   human-readable comment/name.

The field also exposes `value`, `fingerprint`, and `name` as separate Views
fields, so you can build listings keyed on any of them.
