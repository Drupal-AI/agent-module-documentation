# Configuration

SPhoenix AI Content Assistant needs to be connected to the SPhoenix AI service
before it can do anything. Configuration is where you supply the credentials that
let Drupal authenticate to that service.

## Connect to SPhoenix AI

1. Log in as an administrator (a user who can administer the module's settings).
2. Open the module's settings form from the SPhoenix AI configuration page and
   enter the credentials issued to you by the SPhoenix AI service.
3. Save the form. The module authenticates against the service — its auth routes
   return only a redirect URL and a status, so no secret is echoed back to the
   browser.

## Keep the credentials secret

Do not hard‑code or commit the SPhoenix credentials. Store them in an environment
variable and reference that from Drupal (for example through a Key entity backed
by the environment provider, if you use the Key module). This keeps the secret
out of your configuration export and version control.

## Grant access

The module provides its own permissions. Decide which roles should be able to use
the AI generation, analysis and chatbot features, and assign the relevant
permissions at **People → Permissions**. Editors then use the assistant from
within the content editing screens.
