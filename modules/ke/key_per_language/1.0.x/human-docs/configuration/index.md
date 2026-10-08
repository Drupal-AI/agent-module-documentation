# Configuration

There's no dedicated settings form — you configure Key per language by creating keys
on the **Key** module's own key‑management page. The setup is a two‑stage process:
first the individual language keys, then the special key that chooses between them.

## 1. Create the per‑language keys

For each language that needs its own secret, create an ordinary Key entity as you
normally would:

1. Log in as a user with the **administer keys** permission (an administrator by
   default).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
3. Give it a clear **internal name** (for example `stripe_api_fr`,
   `stripe_api_de`), pick the appropriate key type and a **secure provider**
   (environment variable or file, not a committed value), and save.
4. Repeat for each language.

## 2. Create the "Key per Language" key

Now create the single key that other code will reference:

1. On the **Keys** page, click **Add key** again.
2. Give it an internal name (for example `stripe_api`) — this is the name your
   integrations will use.
3. For the **Key provider**, select **Key per Language**.
4. For each configured language, choose which of the keys from step 1 it should
   resolve to.
5. Save.

## How it resolves at runtime

When any code asks the Key module for the `stripe_api` key, this provider checks the
**language of the current request** and returns the value of the mapped key for that
language. Your integration code stays simple — it always asks for one key name and
transparently gets the right per‑market secret.

## Keep the secrets secure

Every underlying key still holds a real secret, so:

- Source each per‑language value from a **secure provider** (environment/Key), and
  **never commit** raw secret values.
- Restrict the **administer keys** permission to trusted administrators.
