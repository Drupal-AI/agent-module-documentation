# Configuration

Encrypt has very little global configuration of its own — the real work is done by the
**encryption profiles** you create. This page explains the profiles list and the model
behind it so the [next section](../creating-a-profile/index.md) makes sense.

## The Encryption profiles list

Go to **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`). This is the home of everything Encrypt
does. Each row is one profile, with columns for its **Label**, its **Encryption
method**, the **Key** it uses, its **Status**, and **Operations** (edit, delete, and
test).

![The Encryption profiles list](../images/profiles.png)

The **+ Add Encryption Profile** button (top left) starts a new profile. The
**Settings** tab holds module-wide options.

Access to this whole area is gated by the **`administer encrypt`** permission, which is
restricted to trusted roles. Note that this permission governs *configuration only* —
it lets someone create and manage profiles, but it does **not** grant the ability to
read encrypted data. Decryption happens through the encryption service in whatever
module consumes a profile.

## Method vs. key: the two halves of a profile

Every profile binds together exactly two things, and it helps to keep them straight:

- **Encryption method** — the *algorithm* (cipher) that transforms plaintext into
  ciphertext and back, for example AES. Methods are plugins; each one is provided by a
  module (Encrypt itself, or an add-on such as Real AES). A method defines *how* data
  is scrambled but carries no secret of its own.

- **Encryption key** — the *secret* the method uses, supplied by a **Key** entity from
  the [Key](../../../../key/1.22.x/human-docs/index.md) module. The Key module stores the
  key material safely (in an environment variable, a file, a KMS, and so on) and the
  profile only *references* it. The secret is never copied into the profile.

This separation is deliberate and important: **keep secrets in the Key module, not in
the profile.** Because the profile stores only a reference, you can export it as
configuration and deploy it between environments without ever exposing the key. It also
means you can swap the underlying key without rebuilding the modules that depend on the
profile.

Once you understand the method-plus-key model, you are ready to
[create a profile](../creating-a-profile/index.md).
