# Configuration

This module has no settings page of its own — you configure it through **Symfony
Mailer's transport list**.

## Add the Graph transport

1. Enable the module at **Administration → Extend** if you have not already.
2. Open Symfony Mailer's transport configuration and **add a new transport**,
   choosing the **Microsoft Graph** transport type this module provides.
3. Enter the credentials from your Azure app registration:
   - **Tenant ID**
   - **Client ID**
   - **Client secret** — the 40-character secret **value** from the app
     registration (not the 36-character secret **ID**). Treat it as a sensitive
     credential; a good practice is to keep it in an environment variable and
     surface it through a Key entity.
4. Save the transport, and set it as the transport your mailer policies use so
   that outgoing mail is routed through Microsoft Graph.

## Things to know

- **Scope the app registration to a specific mailbox.** Use an application
  access policy rather than granting `Mail.Send` tenant-wide — otherwise a
  compromised site could send as anyone in the organisation.
- **Treat the client secret as a sensitive credential.** Prefer an environment
  variable surfaced through a Key entity, and rotate it if it may have been
  exposed.
- **Re-enter the client secret whenever you save this transport.** The secret
  field renders blank on the edit form, so saving with it empty will clear the
  stored value — type it in again each time you save.
- **Official SDK.** Mail is sent through Microsoft's official
  `microsoft/microsoft-graph` SDK (Composer requirement `^2.7`).
