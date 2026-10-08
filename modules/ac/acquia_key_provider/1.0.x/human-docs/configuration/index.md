# Configuration

Acquia Key Provider has no settings screen of its own. You "configure" it by
creating a **Key entity** (from the Key module) that selects the Acquia provider as
the source of its value. From then on, any module that reads that Key gets the
secret straight from Acquia's platform storage.

## Before you start

Store the secret itself in **Acquia hosting's platform secret storage** first. This
module reads an existing platform secret — it does not put one there. Note the name
under which the secret is stored on the platform; you will point the Key at it.

## Create a Key that uses the Acquia provider

1. Log in as a user with the **Administer keys** permission (an administrator by
   default).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
3. Give the key a clear **Label** — this is the human name other modules will show
   when they let you pick a key (for example *OpenAI API Key* or *Acme API
   token*).
4. Choose a **Key type** that matches what the secret is — commonly
   *Authentication* for an API key or token. The key type describes the shape of
   the value; it does not change where it is read from.
5. For **Key provider**, choose **Acquia**. This is the option this module adds —
   selecting it tells Drupal to read the value from Acquia's platform secret
   storage rather than from configuration or a file.
6. Fill in the provider's settings so it can locate the right secret — typically
   the **name of the platform secret** you stored earlier. Match it exactly to what
   you set up on the Acquia side.
7. Save the key.

## Point your other modules at the Key

Modules that consume Key entities — AI provider credentials, API integrations, and
similar — offer a "select a key" dropdown in their own settings. Choose the Key you
just created there. Those modules then reference the Key by name and never store or
display the raw secret.

## Why this is the right pattern

Because the value lives in the platform and is only referenced by name, your
**exported Drupal configuration carries no secret** — nothing sensitive ends up in
config exports, the Git repository or a database dump. The security of the secret
then rests on Acquia's platform controls, which is exactly where a hosted secret
belongs.
